package com.github.mihirsinghal.cricket;

import javax.swing.*;
import java.util.*;

public class CricketGame {

	int numOvers;

	Team[] teams;

	PlayCricket pc;

	Random rand;

	boolean selectedHeads;
	boolean wonToss;

	Team battingTeam;
	Team fieldingTeam;
	Player wktKeeper;
	Player[] batsmen;
	Player[] bowlers; // current bowler is always bowlers[over % 2]
	boolean index0IsStriker; // Indicates whether batsmen[0] is the striker

	List<Player> haveBatted;
	List<Player> haveBowled;

	int over;
	int ball; // number of balls elapsed is 6 * over + ball - 1
	int score;
	int wkts;

	boolean isOut;
	boolean strikerWasOut; // if the player who was out was the striker, then
							// true
	boolean wasBall;
	boolean isFreeHit;
	boolean switchedSides;

	int[] extras;
	final static String[] EXTRA_TYPES = new String[] {"wd", "nb", "b", "lb"};
	/*
	 * 0: wides
	 * 1: no ball
	 * 2: bye
	 * 3: leg bye
	 */

	boolean isFirstInns;

	int target; // score that second team has to get

	Queue<String> notifications;

	StringBuilder commentaryText; // Text for pc.mGCommentary

	Innings bowlerInnsPrevOver;

	Ball result;

	CricketGame(PlayCricket pc, int numOvers) {

		this.pc = pc;
		rand = new Random("SEED".hashCode());

		assert numOvers == 20;
		this.numOvers = numOvers;

		teams = new Team[2];

		isFirstInns = true;

		batsmen = new Player[2];
		bowlers = new Player[2];

		index0IsStriker = true;

		haveBatted = new ArrayList<Player>();
		haveBowled = new ArrayList<Player>();

		over = 0;
		ball = 1;
		score = 0;
		wkts = 0;

		extras = new int[4];

		notifications = new PriorityQueue<String>();

		commentaryText = new StringBuilder();

		isFreeHit = false;

	}

	public void askBatOrField() {

		boolean isHeads = rand.nextBoolean();

		wonToss = (isHeads == selectedHeads);

		pc.confirm("It's " + (isHeads ? "heads! " : "tails! ") + teams[wonToss ? 0 : 1].name
				+ ", would you like to bat or field?", "Bat", "Field", State.BAT_OR_FIELD);

	}

	public void promptWktkeeper() {

		pc.selectPlr(fieldingTeam.name + ", select your wicketkeeper:", false,
				Functions.listFromArray(fieldingTeam.players), State.SELECTING_WKTKEEPER);

	}

	public Player striker() {
		return batsmen[index0IsStriker ? 0 : 1];
	}

	public Player nonStriker() {
		return batsmen[index0IsStriker ? 1 : 0];
	}

	public Player currBowler() {
		return bowlers[over % 2];
	}

	public Player offBowler() {
		return bowlers[(over + 1) % 2];
	}

	// Batsmen switch sides
	public void switchSides() {
		index0IsStriker = !index0IsStriker;
		switchedSides = true;
	}

	public void start() {

		pc.mGTeamName.setText(battingTeam.name);
		pc.sVTitle.setText(Functions.boldSize(battingTeam.name + " innings", 1.5f));

		commentaryText.append("<tr><td colspan=\"2\" valign=\"top\"><b>Start of "
				+ battingTeam.name + " innings</b></td></tr>");
		pc.mGCommentary.setText("<table>" + commentaryText.toString() + "</table>");

		for (int i = 0; i < 11; i++) {
			pc.pBBowlStats[i][0].setText(fieldingTeam.players[i].name);
		}

		getReadyForOverStart();

	}

	public void getReadyForSecondInns() {

		target = score + 1;

		Team temp = fieldingTeam;
		fieldingTeam = battingTeam;
		battingTeam = temp;

		isFirstInns = false;

		batsmen = new Player[2];
		bowlers = new Player[2];

		index0IsStriker = true;

		haveBatted = new ArrayList<Player>();
		haveBowled = new ArrayList<Player>();

		over = 0;
		ball = 1;
		score = 0;
		wkts = 0;

		extras = new int[4];

		notifications = new PriorityQueue<String>();

		isFreeHit = false;

		pc.switchToMidOver();

		pc.resetInGameViews();

		pc.mGReqRunRate.setVisible(true);

		promptWktkeeper();

	}

	public void startSecondInns() {

		pc.mGTeamName.setText(battingTeam.name);
		pc.sVTitle.setText(Functions.boldSize(battingTeam.name + " innings", 1.5f));

		commentaryText.append("<tr><td colspan=\"2\" valign=\"top\"><b>Start of "
				+ battingTeam.name
				+ " innings</b></td></tr><tr><td colspan=\"2\" valign=\"top\"><b>Target: " + target
				+ "</b></td></tr>");
		pc.mGCommentary.setText("<table>" + commentaryText.toString() + "</table>");

		for (int i = 0; i < 11; i++) {
			pc.pBBowlStats[i][0].setText(fieldingTeam.players[i].name);
		}

		getReadyForOverStart();

	}

	public double getRunRate() {

		return score * 6.0 / ballsElapsed();

	}

	public boolean executeBall(String exec) {

		// Returns true if out, false if not out

		// TODO update notifications
		// TODO also add notifications to commentary
		// TODO remember to set nextBallIsFreeHit to true if no ball

		int number = 0;
		String ballType;
		if (Character.isDigit(exec.charAt(0))) {
			number = exec.charAt(0) - '0';
			ballType = exec.substring(1);
		} else {
			ballType = exec;
		}

		Innings prevStrikerInns = striker().inns.clone();
		Innings prevBowlerInns = currBowler().inns.clone();
		Innings newStrikerInns = striker().inns;
		Innings newBowlerInns = currBowler().inns;
		PlayerStats strikerStats = striker().stats;

		boolean ans = false;

		switch (ballType) {
		// NOTE remember to include break statements

			case "dot":
				break;

			case "run":
				striker().inns.score += number;
				currBowler().inns.runsGiven += number;
				score += number;
				if (number % 2 == 1) {
					switchSides();
				}
				break;

			case "four":
				striker().inns.score += 4;
				striker().inns.fours++;
				currBowler().inns.runsGiven += 4;
				score += 4;
				break;

			case "six":
				striker().inns.score += 6;
				striker().inns.sixes++;
				currBowler().inns.runsGiven += 6;
				score += 6;
				break;

			case "out":
				strikerWasOut = true;
				striker().inns.notOut = false;
				pc.sVBatStats[haveBatted.indexOf(striker())][1].setText(result.method);
				if (!(result.method.startsWith("run out"))) {
					currBowler().inns.wkts++;
				}
				wkts++;
				ans = true;
				break;

			case "nsout":
				strikerWasOut = false;
				nonStriker().inns.notOut = false;
				pc.sVBatStats[haveBatted.indexOf(nonStriker())][1].setText(result.method);
				if (!(result.method.startsWith("run out"))) {
					currBowler().inns.wkts++;
				}
				wkts++;
				ans = true;
				break;

			case "wd":
				extras[0] += number + 1;
				currBowler().inns.runsGiven += number + 1;
				score += number + 1;
				if (number % 2 == 1) {
					switchSides();
				}
				break;

			case "nb":
				(switchedSides ? nonStriker() : striker()).inns.ballsFaced++;
			case "nbw":
				extras[1] += number + 1;
				currBowler().inns.runsGiven += number + 1;
				score += number + 1;
				if (number % 2 == 1) {
					switchSides();
				}
				break;

			case "bye":
				extras[2] += number;
				currBowler().inns.runsGiven += number;
				if (number % 2 == 1) {
					switchSides();
				}
				break;

			case "lb":
				extras[3] += number;
				currBowler().inns.runsGiven += number;
				if (number % 2 == 1) {
					switchSides();
				}
				break;

			default:
				System.out.println("ERROR: Unknown ball type: " + ballType);
				break;

		}

		return ans;

	}

	public void addRuns(int runs) {
		striker().inns.score += runs;
		currBowler().inns.runsGiven += runs;
		score += runs;
	}

	public void addBatsman(Player batsman, boolean isIndex0) {

		batsmen[isIndex0 ? 0 : 1] = batsman;
		haveBatted.add(batsman);

		batsman.inns.batted = true;

		for (JLabel label: pc.sVBatStats[haveBatted.size() - 1]) {
			label.setVisible(true);
		}
		pc.sVBatStats[haveBatted.size() - 1][0].setText(batsman.name);
		pc.sVBatStats[haveBatted.size() - 1][1].setText("not out");

	}

	public void setBowler(Player bowler) {

		bowlers[over % 2] = bowler;
		if (!haveBowled.contains(bowler)) {
			haveBowled.add(bowler);
		}

		bowler.inns.bowled = true;

		for (JLabel label: pc.sVBowlStats[haveBowled.size() - 1]) {
			label.setVisible(true);
		}
		pc.sVBowlStats[haveBowled.size() - 1][0].setText(bowler.name);

	}

	public void incrementBall() {

		currBowler().inns.ballsBowled++;
		(switchedSides ? nonStriker() : striker()).inns.ballsFaced++;

		ball++;
		if (ball == 7) {
			ball = 1;
			over++;
		}

	}

	public void getReadyForNextBall() {

		if (ball == 1 && wasBall) {

			// TODO update commentary with end-of-over stats (use
			// bowlerInnsPrevOver)

			switchSides();

			Innings currBowlerInns = offBowler().inns;

			if (currBowlerInns.runsGiven == bowlerInnsPrevOver.runsGiven) {
				currBowlerInns.maidens++;
			}

		}

		pc.updateScore(true);

		pc.switchToPanel(pc.midGameView);

		if (ball == 1 && wasBall) {
			pc.switchToEndOver();
		} else {
			pc.switchToMidOver();
		}

	}

	public void getReadyForOverStart() {

		bowlerInnsPrevOver = currBowler().inns.clone();

		pc.updateScore(false);
		pc.switchToMidOver();
		pc.switchToPanel(pc.midGameView);

	}

	public int ballsElapsed() {
		return 6 * over + ball - 1;
	}

	public void playNextBall() {

		result = DataLoader.randomBall();

		if (isFreeHit) {
			result = result.ifFreeHit;
		}

		formatBall();

		pc.mGCurrOver.setText(pc.mGCurrOver.getText() + " " + result.shortForm);

		commentaryText.append("<tr><td style=\"padding:0 15px 0 0;\" valign=\"top\"><b>" + over
				+ "." + ball + "</b></td><td valign=\"top\">" + currBowler().name + " to "
				+ striker().name + ", " + result.longForm + ", " + result.commentary + "</td></tr>");
		pc.mGCommentary.setText("<table>" + commentaryText.toString() + "</table>");
		// System.out.println(pc.mGCommentary.getText());
		// Above is for debugging. TODO remove

		String[] execs = result.exec.split("\\+");

		isOut = false;

		if (nextIsFreeHit(result.exec)) {
			isFreeHit = true;
		} else {
			isFreeHit = false;
		}

		switchedSides = false;

		for (String exec: execs) {
			if (executeBall(exec)) {
				isOut = true;
			}
		}

		if (isBall(result.exec)) {
			wasBall = true;
			incrementBall();
		} else {
			wasBall = false;
		}

		if (isOut) {
			Player dismissed = (strikerWasOut ? striker() : nonStriker());
			String outMessageText = String.format("<font color=\"red\"><b>%s %s %d (%db %dx4 %dx6)"
					+ " SR: %s</b></font>", dismissed.name, result.method, dismissed.inns.score,
					dismissed.inns.ballsFaced, dismissed.inns.fours, dismissed.inns.sixes,
					dismissed.inns.getSR());
			commentaryText.append("<tr><td colspan=\"2\">" + outMessageText + "</td></tr>");
			result.message = "<html><div align=\"center\">" + result.message + "<br>"
					+ outMessageText + "</div></html>";
			pc.mGCommentary.setText("<table>" + commentaryText.toString() + "</table>");
		}

		pc.showMessage(result.message, "OK", State.SHOWING_BALL_RESULT);

	}

	public Ball getBall() {
		int index = rand.nextInt(7);
		return new Ball[] {new Ball("dot", ".", "no runs", "", "It's a dot ball."),
				new Ball("1run", "1", "1 run", "", "It's a single."),
				new Ball("four", "4", "FOUR", "", "It's a four!"),
				new Ball("six", "6", "SIX", "", "It's a six!"),
				new Ball("out", "W", "bowled", "", "He's bowled!", "b [b]"),
				new Ball("1wd", "1wd", "1 wide", "", "It's a wide!"),
				new Ball("1nb", "1nb", "1 no ball", "", "It's a no ball!")}[index];
	}

	// TODO remove above method, replaced by DataLoader.randomBall()

	public void formatBall() {
		// Replaces tags in ball
		// TODO complete formatBall
		
		List<Player> fielders = new ArrayList<Player>();
		for (Player plr: fieldingTeam.players) {
			if (plr != wktKeeper && plr != currBowler()) {
				fielders.add(plr);
			}
		}
		Collections.shuffle(fielders);
		
		result.commentary = formatString(result.commentary, fielders);
		result.method = formatString(result.method, fielders);
		result.ifFreeHit.commentary = formatString(result.ifFreeHit.commentary, fielders);
		result.ifFreeHit.method = formatString(result.ifFreeHit.method, fielders);

	}

	public String formatString(String s, List<Player> fielders) {
		if (s == null) {
			return null;
		} else {
			s = s.replace("[b]", currBowler().name);
			s = s.replace("[s]", striker().name);
			s = s.replace("[ns]", nonStriker().name);
			s = s.replace("[wk]", wktKeeper.name);
			for (int i = 1; i <= 9; i++) {
				s = s.replace("[rf" + i + "]", fielders.get(i - 1).name);
			}
			s = s.replace("[ft]", fieldingTeam.name);
			s = s.replace("[bt]", battingTeam.name);
			return s;
		}
	}

	public void selectNextBowler() {
		List<Player> illegalBowlers = new ArrayList<Player>();
		illegalBowlers.add(wktKeeper);
		illegalBowlers.add(offBowler());

		for (int i = 0; i < 11; i++) {
			boolean isInvisible = (fieldingTeam.players[i] == wktKeeper)
					|| (fieldingTeam.players[i] == offBowler())
					|| (fieldingTeam.players[i].inns.ballsBowled == 60);
			for (int j = 0; j < 6; j++) {
				pc.pBBowlStats[i][j].setVisible(!isInvisible);
			}
			pc.pBButtons[i].setVisible(!isInvisible);
		}

		pc.switchToPanel(pc.pickBowlerView);
	}

	public String getExtraList() {
		// Returns a list of extras, e.g., "(1 wd, 2 nb)"

		String ans = "";

		for (int i = 0; i < 4; i++) {
			if (extras[i] != 0) {
				ans += extras[i] + " " + EXTRA_TYPES[i] + ", ";
			}
		}

		if (ans.equals("")) {
			return "";
		}

		return "(" + ans.substring(0, ans.length() - 2) + ")";

	}

	public static boolean isBall(String exec) {
		return !(exec.contains("wd") || exec.contains("nb"));
	}

	private boolean nextIsFreeHit(String exec) {
		return exec.contains("nb") && !exec.contains("nbw");
	}

	public boolean inningsFinished() {
		return over >= numOvers || wkts == 10 || (!isFirstInns && score >= target);
	}

	public String winnerMessage() {
		if (score > target) {
			return battingTeam.name + " wins!";
		} else if (score < target) {
			return fieldingTeam.name + " wins!";
		} else {
			return "It's a tie!";
		}
	}
}
