package com.github.mihirsinghal.cricket;

// TODO implement password changing
// TODO allow deletion of teams

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;
import java.util.List;
import javax.swing.text.html.HTMLDocument;

public class PlayCricket implements ActionListener {

	JFrame frame;
	JPanel contentPane;
	JPanel offsetPane;

	CricketGame cg;

	List<Team> allTeams;

	State state;

	JPanel currPanel = null;

	JPanel homeMenuView; // Home menu - options to play, create team, etc.
	JLabel hMPrompt;
	JButton hMCreateTeam;
	JButton hMEditTeam;
	JButton hMPlayT20;
	JButton hMViewStats;
	JButton hMQuit;

	JPanel createTeamView; // Create a team
	JLabel cTErrorMessage;
	JLabel cTTeamNamePrompt;
	JTextField cTTeamNameEntry;
	JLabel[] cTPlayerNamePrompts;
	JTextField[] cTPlayerNameEntries;
	JLabel cTPasswordPrompt;
	JPasswordField cTPasswordEntry;
	JLabel cTConfirmPasswordPrompt;
	JPasswordField cTConfirmPasswordEntry;
	JButton cTFinish;
	JButton cTCancel;
	final static int CT_ENTRY_X = 150;
	final static int CT_ENTRY_WIDTH = 250;

	JPanel editTeamView; // List of options to edit a team
	Team currEditingTeam; // Team that is currently being edited
	JLabel eTPrompt;
	JButton eTAddPlr;
	JButton eTSwitchPlrs;
	Player eTPlrBeingSwitchedOut;
	Player eTPlrBeingSwitchedIn;
	Player eTPlrToRemove;
	JButton eTRemovePlr;
	JButton eTChangePassword;
	JButton eTCancel;

	JPanel addPlayerView; // Add a player to a team
	JLabel aPErrorMessage;
	JLabel aPPrompt;
	JTextField aPEntry;
	JButton aPCancel;
	JButton aPFinish;

	JPanel enterPswdView; // Enter password for a team
	Team currEnteringPswdTeam;
	JLabel ePErrorMessage;
	JLabel ePPrompt;
	JPasswordField ePEntry;
	JButton ePCancel;
	JButton ePSubmit;

	JPanel plrStatsView; // View of a player's stats
	JLabel pSMatches;
	JLabel pSBatTitle;
	JLabel pSBowlTitle;
	JLabel[] pSBatStats;
	JLabel[] pSBowlStats;
	JButton pSBack;

	JPanel selectEntityView; // Select a Team or Player object.
	List<Team> currSearchingTeamList;
	List<Player> currSearchingPlrList; // List that is currently being searched
	JLabel sEPrompt;
	JComboBox<String> sESelection;
	JPanel sEButtons;
	JButton sECancel;
	JButton sESelect;

	JPanel midGameView; // Shows the score, current batter & bowler stats, etc.
	JPanel mGTopPanel;
	JLabel mGTeamName;
	JLabel mGScore;
	String MG_SCORE_TEXT = "<html><span style=\"font-size: 4em\"><b>%d/%d</b></span></html>";
	// String format specifiers: Runs, wickets
	JLabel mGOvers;
	JLabel mGRunRate;
	JLabel mGReqRunRate;
	JPanel mGBatsmen;
	JLabel mGBatsman0;
	JLabel mGBatsman1;
	final static String MG_BATSMEN_TEXT = "<html><div align=\"center\">%s<br>"
			+ "<span style=\"font-size: 3em\">%s</span><br><div style=\"margin-bottom: 6px\">(%d)"
			+ "</div>%dx4 %dx6</div></html>";
	// String format specifiers: Player name, score (possibly with a *), balls,
	// fours, sixes
	JPanel mGBowlers;
	JLabel mGBowler0;
	JLabel mGBowler1;
	JLabel mGBowler0Stats;
	JLabel mGBowler1Stats;
	JLabel mGCurrOver;
	JTextPane mGCommentary;
	JScrollPane mGCommentaryScroll;
	JPanel mGButtons;
	JButton mGViewScorecard; // Visible only at end of over
	JButton mGContinue; // Visible only at end of over
	JButton mGNextBall; // Only visible mid over

	JPanel pickBowlerView; // List of bowlers with stats to pick
	JLabel[][] pBBowlStats;
	JButton[] pBButtons;

	JPanel scorecardView; // The scorecard.
	JLabel sVTitle;
	JPanel sVBatStatPanel;
	JLabel[][] sVBatStats;
	/*
	 * Rows represent batsmen, columns represent stat type:
	 * 
	 * 0: batter name
	 * 1: method of out
	 * 2: runs
	 * 3: balls
	 * 4: 4s
	 * 5: 6s
	 * 6: strike rate
	 */
	JLabel sVExtraList; // e.g. "(wd 3, nb 1)"
	JLabel sVExtraTotal;
	JLabel sVWktsOvers; // e.g. "(1 wicket; 20 overs)"
	JLabel sVTotal;
	JLabel sVRunRate;
	JPanel sVBowlStatPanel;
	JLabel[][] sVBowlStats;
	/*
	 * 0: bowler name
	 * 1: overs
	 * 2: maidens
	 * 3: runs
	 * 4: wickets
	 * 5: economy rate
	 */
	JButton sVBack;

	JPanel confirmDialogView; // Confirm dialog, with only two buttons
	JLabel cDPrompt;
	JPanel cDButtons;
	JButton cDButton1;
	JButton cDButton2;

	JPanel showMessageView;
	JLabel sMMessage;
	JButton sMButton;

	Map<JPanel, String> titles;
	JPanel[] allPanels;

	public void createContentPane() {

		titles = new HashMap<JPanel, String>();

		contentPane = new JPanel();
		contentPane.setLayout(new BorderLayout());

		// HOME MENU
		createHMV();

		// CREATE TEAM
		createCTV();

		// EDIT TEAM
		createETV();

		// ADD PLAYER
		createAPV();

		// CONFIRM DIALOG
		createCDV();

		// SHOW MESSAGE
		createSMV();

		// SELECT ENTITY
		createSEV();

		// PLAYER STATS
		createPSV();

		// EDIT PSWD
		createEPV();

		// MID GAME
		createMGV();

		// SCORECARD
		createSV();

		createPBV();

		allPanels = new JPanel[] {homeMenuView, createTeamView, editTeamView, addPlayerView,
				confirmDialogView, selectEntityView, plrStatsView, showMessageView, enterPswdView,
				midGameView, pickBowlerView};

		contentPane.setOpaque(true);

		for (JPanel panel: allPanels) {
			contentPane.add(panel);
		}

		contentPane.add(scorecardView);

	}

	public void createHMV() {

		homeMenuView = new JPanel(new GridBagLayout());
		titles.put(homeMenuView, "Cricket");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.gridwidth = 5;
		c.insets = new Insets(0, 0, 20, 0);

		hMPrompt = new JLabel("What would you like to do?");
		homeMenuView.add(hMPrompt, c);

		c.gridy = 1;
		c.gridwidth = 1;
		c.insets = new Insets(0, 0, 0, 10);

		hMCreateTeam = new JButton("Create a team");
		hMCreateTeam.addActionListener(this);
		homeMenuView.add(hMCreateTeam, c);

		c.gridx++;

		hMEditTeam = new JButton("Edit a team");
		hMEditTeam.addActionListener(this);
		homeMenuView.add(hMEditTeam, c);

		c.gridx++;

		hMPlayT20 = new JButton("Play a T20");
		hMPlayT20.addActionListener(this);
		homeMenuView.add(hMPlayT20, c);

		c.gridx++;

		hMViewStats = new JButton("View stats");
		hMViewStats.addActionListener(this);
		homeMenuView.add(hMViewStats, c);

		c.gridx++;
		c.insets = new Insets(0, 0, 0, 0);

		hMQuit = new JButton("Quit");
		hMQuit.addActionListener(this);
		homeMenuView.add(hMQuit, c);

	}

	public void createCTV() {

		createTeamView = new JPanel(new GridBagLayout());
		titles.put(createTeamView, "Create team");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.gridwidth = 4;
		c.insets = new Insets(0, 0, 20, 0);

		cTErrorMessage = new JLabel(Functions.red("Invalid player name"));
		createTeamView.add(cTErrorMessage, c);
		cTErrorMessage.setVisible(false);

		c.gridy++;
		c.gridwidth = 1;
		c.anchor = GridBagConstraints.LINE_START;

		cTTeamNamePrompt = new JLabel("Team name:");
		createTeamView.add(cTTeamNamePrompt, c);

		c.gridx = 1;
		c.gridwidth = 3;

		cTTeamNameEntry = new JTextField();
		cTTeamNameEntry.setPreferredSize(new Dimension(200,
				cTTeamNameEntry.getPreferredSize().height));
		cTTeamNameEntry.addActionListener(this);
		createTeamView.add(cTTeamNameEntry, c);

		cTPlayerNamePrompts = new JLabel[11];
		cTPlayerNameEntries = new JTextField[11];

		c.insets = new Insets(0, 0, 5, 0);

		for (int i = 0; i < 11; i++) {

			c.gridy++;
			c.gridx = 0;
			c.gridwidth = 1;

			cTPlayerNamePrompts[i] = new JLabel("Player " + (i + 1) + " name:");
			createTeamView.add(cTPlayerNamePrompts[i], c);

			c.gridx = 1;
			c.gridwidth = 3;

			cTPlayerNameEntries[i] = new JTextField();
			cTPlayerNameEntries[i].setPreferredSize(new Dimension(200,
					cTPlayerNameEntries[i].getPreferredSize().height));
			cTPlayerNameEntries[i].addActionListener(this);
			createTeamView.add(cTPlayerNameEntries[i], c);
		}

		c.gridy++;
		c.gridx = 0;
		c.gridwidth = 1;
		c.insets = new Insets(15, 0, 0, 0);

		cTPasswordPrompt = new JLabel("Create password:");
		createTeamView.add(cTPasswordPrompt, c);

		c.gridx = 1;
		c.gridwidth = 3;

		cTPasswordEntry = new JPasswordField();
		cTPasswordEntry.setPreferredSize(new Dimension(200,
				cTPasswordEntry.getPreferredSize().height));
		cTPasswordEntry.addActionListener(this);
		createTeamView.add(cTPasswordEntry, c);

		c.gridy++;
		c.gridx = 0;
		c.gridwidth = 1;
		c.insets = new Insets(5, 0, 0, 50);

		cTConfirmPasswordPrompt = new JLabel("Confirm password:");
		createTeamView.add(cTConfirmPasswordPrompt, c);

		c.gridx = 1;
		c.gridwidth = 3;
		c.insets = new Insets(10, 0, 0, 0);

		cTConfirmPasswordEntry = new JPasswordField();
		cTConfirmPasswordEntry.setPreferredSize(new Dimension(200,
				cTConfirmPasswordEntry.getPreferredSize().height));
		cTConfirmPasswordEntry.addActionListener(this);
		createTeamView.add(cTConfirmPasswordEntry, c);

		c.anchor = GridBagConstraints.LINE_END;
		c.gridy++;
		c.gridx = 3;
		c.gridwidth = 1;

		cTFinish = new JButton("Finish");
		cTFinish.addActionListener(this);
		createTeamView.add(cTFinish, c);

		c.gridx = 2;
		c.insets = new Insets(10, 20, 0, 0);

		cTCancel = new JButton("Cancel");
		cTCancel.addActionListener(this);
		createTeamView.add(cTCancel, c);

	}

	public void createETV() {

		editTeamView = new JPanel(new GridBagLayout());
		titles.put(editTeamView, "Edit team");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.gridwidth = 5;
		c.insets = new Insets(0, 0, 20, 0);

		eTPrompt = new JLabel("What would you like to do?");
		editTeamView.add(eTPrompt, c);

		c.gridy = 1;
		c.gridwidth = 1;
		c.insets = new Insets(0, 10, 0, 0);

		eTAddPlr = new JButton("Add player to squad");
		eTAddPlr.addActionListener(this);
		editTeamView.add(eTAddPlr, c);

		c.gridx++;

		eTSwitchPlrs = new JButton("Switch players on team and squad");
		eTSwitchPlrs.addActionListener(this);
		editTeamView.add(eTSwitchPlrs, c);

		c.gridx++;

		eTRemovePlr = new JButton("Remove player");
		eTRemovePlr.addActionListener(this);
		editTeamView.add(eTRemovePlr, c);

		c.gridx++;

		eTChangePassword = new JButton("Change password");
		eTChangePassword.addActionListener(this);
		editTeamView.add(eTChangePassword, c);

		c.gridx++;
		c.insets = new Insets(0, 0, 0, 0);

		eTCancel = new JButton("Cancel");
		eTCancel.addActionListener(this);
		editTeamView.add(eTCancel, c);

	}

	public void createAPV() {

		addPlayerView = new JPanel(new GridBagLayout());
		titles.put(addPlayerView, "Add player");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.gridwidth = 4;
		c.anchor = GridBagConstraints.LINE_START;
		c.insets = new Insets(0, 0, 20, 0);

		aPErrorMessage = new JLabel(Functions.red("Error"));
		addPlayerView.add(aPErrorMessage, c);
		aPErrorMessage.setVisible(false);

		c.gridy = 1;
		c.gridwidth = 1;
		c.insets = new Insets(0, 0, 20, 30);

		aPPrompt = new JLabel("Enter name of player to add:");
		addPlayerView.add(aPPrompt, c);

		c.gridx = 1;
		c.gridwidth = 2;
		c.insets = new Insets(0, 0, 20, 0);

		aPEntry = new JTextField();
		aPEntry.setPreferredSize(new Dimension(200, aPEntry.getPreferredSize().height));
		aPEntry.addActionListener(this);
		addPlayerView.add(aPEntry, c);

		c.gridy = 2;
		c.gridwidth = 1;
		c.insets = new Insets(0, 30, 0, 0);
		c.anchor = GridBagConstraints.LINE_END;

		aPCancel = new JButton("Cancel");
		aPCancel.addActionListener(this);
		addPlayerView.add(aPCancel, c);

		c.gridx = 2;
		c.insets = new Insets(0, 0, 0, 0);

		aPFinish = new JButton("Finish");
		aPFinish.addActionListener(this);
		addPlayerView.add(aPFinish, c);

	}

	public void createCDV() {

		confirmDialogView = new JPanel(new GridBagLayout());
		titles.put(confirmDialogView, "");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 20, 0);
		c.anchor = GridBagConstraints.CENTER;

		cDPrompt = new JLabel("Confirm dialog prompt - placeholder");
		confirmDialogView.add(cDPrompt, c);

		c.gridy++;
		c.insets = new Insets(0, 0, 0, 0);

		cDButtons = new JPanel(new GridBagLayout());
		confirmDialogView.add(cDButtons, c);

		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 0, 10);

		cDButton1 = new JButton("Nay");
		cDButton1.addActionListener(this);
		cDButtons.add(cDButton1, c);

		c.gridx++;
		c.insets = new Insets(0, 0, 0, 0);

		cDButton2 = new JButton("Aye");
		cDButton2.addActionListener(this);
		cDButtons.add(cDButton2, c);

	}

	public void createSMV() {

		showMessageView = new JPanel(new GridBagLayout());
		titles.put(showMessageView, "");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 20, 0);
		c.anchor = GridBagConstraints.CENTER;

		sMMessage = new JLabel("Show message prompt - placeholder");
		showMessageView.add(sMMessage, c);

		c.gridy = 1;
		c.insets = new Insets(0, 0, 0, 0);

		sMButton = new JButton("OK");
		sMButton.addActionListener(this);
		showMessageView.add(sMButton, c);

	}

	public void createSEV() {
		selectEntityView = new JPanel(new GridBagLayout());
		titles.put(selectEntityView, "");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 20, 0);

		sEPrompt = new JLabel("Select entity prompt - placeholder");
		selectEntityView.add(sEPrompt, c);

		c.gridy++;

		sESelection = new JComboBox<String>();
		selectEntityView.add(sESelection, c);

		c.gridy++;
		c.insets = new Insets(0, 0, 0, 0);

		sEButtons = new JPanel(new GridBagLayout());
		selectEntityView.add(sEButtons, c);

		c.gridy = 0;
		c.insets = new Insets(0, 0, 0, 0);

		sECancel = new JButton("Cancel");
		sECancel.addActionListener(this);
		sEButtons.add(sECancel, c);

		c.gridx = 1;
		c.insets = new Insets(0, 10, 0, 0);

		sESelect = new JButton("Select");
		sESelect.addActionListener(this);
		sEButtons.add(sESelect, c);

	}

	public void createPSV() {

		plrStatsView = new JPanel(new GridBagLayout());
		titles.put(plrStatsView, "Placeholder");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 10, 0);
		c.anchor = GridBagConstraints.LINE_START;

		pSMatches = new JLabel("Matches: <placeholder>");
		plrStatsView.add(pSMatches, c);

		c.gridy++;
		c.insets = new Insets(0, 0, 10, 100);

		pSBatTitle = new JLabel(Functions.bold("Batting stats:"));
		plrStatsView.add(pSBatTitle, c);

		c.gridx = 1;
		c.insets = new Insets(0, 0, 10, 0);

		pSBowlTitle = new JLabel(Functions.bold("Bowling stats:"));
		plrStatsView.add(pSBowlTitle, c);

		pSBatStats = new JLabel[PlayerStats.BAT_STATS_LIST.length];

		c.gridx = 0;
		c.insets = new Insets(0, 0, 5, 0);

		for (int i = 0; i < pSBatStats.length; i++) {
			c.gridy++;
			pSBatStats[i] = new JLabel(PlayerStats.BAT_STATS_LIST[i] + ":");
			plrStatsView.add(pSBatStats[i], c);
		}

		pSBowlStats = new JLabel[PlayerStats.BOWL_STATS_LIST.length];

		c.gridx = 1;
		c.gridy = 1;

		for (int i = 0; i < pSBowlStats.length; i++) {
			c.gridy++;
			pSBowlStats[i] = new JLabel(PlayerStats.BOWL_STATS_LIST[i] + ":");
			plrStatsView.add(pSBowlStats[i], c);
		}

		c.gridx = 0;
		c.gridy = Functions.max(pSBatStats.length, pSBowlStats.length) + 2;
		c.gridwidth = 2;
		c.anchor = GridBagConstraints.LINE_END;
		c.insets = new Insets(0, 0, 0, 0);

		pSBack = new JButton("Back");
		pSBack.addActionListener(this);
		plrStatsView.add(pSBack, c);

	}

	public void createEPV() {

		enterPswdView = new JPanel(new GridBagLayout());
		titles.put(enterPswdView, "");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.gridwidth = 3;
		c.anchor = GridBagConstraints.LINE_START;
		c.insets = new Insets(0, 0, 20, 0);

		ePErrorMessage = new JLabel(Functions.red("Wrong password"));
		enterPswdView.add(ePErrorMessage, c);
		ePErrorMessage.setVisible(false);

		c.gridy++;
		c.gridwidth = 1;
		c.insets = new Insets(0, 0, 20, 30);

		ePPrompt = new JLabel("Enter password for <placeholder>:");
		enterPswdView.add(ePPrompt, c);

		c.gridx++;
		c.gridwidth = 2;
		c.insets = new Insets(0, 0, 20, 0);

		ePEntry = new JPasswordField();
		ePEntry.setPreferredSize(new Dimension(200, ePEntry.getPreferredSize().height));
		ePEntry.addActionListener(this);
		enterPswdView.add(ePEntry, c);

		c.gridy = 2;
		c.gridwidth = 1;
		c.insets = new Insets(0, 30, 0, 0);
		c.anchor = GridBagConstraints.LINE_END;

		ePCancel = new JButton("Cancel");
		ePCancel.addActionListener(this);
		enterPswdView.add(ePCancel, c);

		c.gridx = 2;
		c.insets = new Insets(0, 0, 0, 0);

		ePSubmit = new JButton("Submit");
		ePSubmit.addActionListener(this);
		enterPswdView.add(ePSubmit, c);

	}

	public void createMGV() {

		midGameView = new JPanel(new GridBagLayout());
		titles.put(midGameView, "");

		GridBagConstraints c = new GridBagConstraints();
		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 15, 0);

		mGTopPanel = new JPanel(new GridBagLayout());
		midGameView.add(mGTopPanel, c);

		c.insets = new Insets(0, 0, 0, 20);

		mGTeamName = new JLabel("Batting team");
		mGTopPanel.add(mGTeamName, c);

		c.gridx++;

		mGScore = new JLabel(String.format(MG_SCORE_TEXT, 9, 0));
		mGTopPanel.add(mGScore, c);

		c.gridx++;
		c.insets = new Insets(0, 0, 0, 0);

		mGOvers = new JLabel("(1.5 overs)");
		mGTopPanel.add(mGOvers, c);

		c.gridx = 0;
		c.gridy = 1;
		c.insets = new Insets(0, 0, 5, 0);

		mGRunRate = new JLabel("Run rate: 6.00");
		midGameView.add(mGRunRate, c);

		c.gridy++;

		mGReqRunRate = new JLabel("148 runs required from 48 overs (RRR: 3.08)");
		midGameView.add(mGReqRunRate, c);
		// TODO remove all placeholder labels, slows down the load time

		c.gridy++;
		c.insets = new Insets(15, 0, 20, 0);

		mGBatsmen = new JPanel(new GridBagLayout());
		midGameView.add(mGBatsmen, c);

		c.gridy = 0;
		c.insets = new Insets(0, 0, 0, 25);

		mGBatsman0 = new JLabel(String.format(MG_BATSMEN_TEXT, "Bob", "1*", 5, 0, 0));
		mGBatsmen.add(mGBatsman0, c);

		c.gridx++;
		c.insets = new Insets(0, 0, 0, 0);

		mGBatsman1 = new JLabel(String.format(MG_BATSMEN_TEXT, "Bobby", "7", 4, 0, 1));
		mGBatsmen.add(mGBatsman1, c);

		c.gridx = 0;
		c.gridy = 4;
		c.insets = new Insets(0, 0, 10, 0);

		mGBowlers = new JPanel(new GridBagLayout());
		midGameView.add(mGBowlers, c);

		c.gridy = 0;
		c.insets = new Insets(0, 0, 5, 20);
		c.anchor = GridBagConstraints.LINE_START;

		mGBowler0 = new JLabel("Joey Longname");
		mGBowlers.add(mGBowler0, c);

		c.gridy++;

		mGBowler1 = new JLabel("Joe");
		mGBowlers.add(mGBowler1, c);

		c.gridx = 1;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 5, 0);

		mGBowler0Stats = new JLabel("0.3-0-7-0");
		mGBowlers.add(mGBowler0Stats, c);

		c.gridy++;

		mGBowler1Stats = new JLabel("1-0-2-0");
		mGBowlers.add(mGBowler1Stats, c);

		c.gridx = 0;
		c.gridy = 5;
		c.insets = new Insets(0, 0, 20, 0);
		c.anchor = GridBagConstraints.CENTER;

		mGCurrOver = new JLabel("Current over: 6 . 1");
		midGameView.add(mGCurrOver, c);

		c.gridy++;

		mGCommentary = new JTextPane();
		mGCommentary.setContentType("text/html");
		((HTMLDocument) mGCommentary.getDocument()).getStyleSheet().addRule(
				"body {font-family: Lucida Grande; font-size: 13pt}");
		mGCommentary.setText("Hello");
		mGCommentary.setEditable(false);
		mGCommentaryScroll = new JScrollPane(mGCommentary);
		mGCommentaryScroll.setPreferredSize(new Dimension(600, 200));
		midGameView.add(mGCommentaryScroll, c);

		c.gridy++;
		c.anchor = GridBagConstraints.LINE_END;
		c.insets = new Insets(0, 0, 0, 0);

		mGButtons = new JPanel(new GridBagLayout());
		midGameView.add(mGButtons, c);

		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 0, 10);

		mGViewScorecard = new JButton("View scorecard");
		mGViewScorecard.addActionListener(this);
		mGButtons.add(mGViewScorecard, c);

		c.gridx++;
		c.insets = new Insets(0, 0, 0, 0);

		mGContinue = new JButton("Continue");
		mGContinue.addActionListener(this);
		mGButtons.add(mGContinue, c);

		c.gridx++;

		mGNextBall = new JButton("Play next ball");
		mGNextBall.addActionListener(this);
		mGButtons.add(mGNextBall, c);

	}

	public void createSV() {
		scorecardView = new JPanel(new GridBagLayout());
		titles.put(scorecardView, "Scorecard");

		GridBagConstraints c = new GridBagConstraints();

		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 20, 0);

		sVTitle = new JLabel(Functions.boldSize("The Bobs innings", 1.5f));
		scorecardView.add(sVTitle, c);

		c.gridy++;

		sVBatStatPanel = new JPanel(new GridBagLayout());
		scorecardView.add(sVBatStatPanel, c);

		c.gridx = 0;
		c.gridy = 0;
		c.gridwidth = 2;
		c.anchor = GridBagConstraints.LINE_START;
		c.insets = new Insets(0, 0, 10, 20);

		sVBatStatPanel.add(new JLabel(Functions.bold("Batting")), c);

		c.gridx = 1;
		c.gridwidth = 1;
		c.anchor = GridBagConstraints.LINE_END;

		for (String title: new String[] {"R", "B", "4s", "6s", "SR"}) {
			c.gridx++;
			if (c.gridx == 6) {
				c.insets = new Insets(0, 0, 10, 0);
			}
			sVBatStatPanel.add(new JLabel(title), c);
		}

		sVBatStats = new JLabel[11][7];

		for (int i = 0; i < 11; i++) {
			for (int j = 0; j < 7; j++) {

				c.gridx = j;
				c.gridy = i + 1;
				c.anchor = (j == 0 || j == 1) ? GridBagConstraints.LINE_START
						: GridBagConstraints.LINE_END;
				c.insets = new Insets(0, 0, 5, (j == 6) ? 0 : 20);

				sVBatStats[i][j] = new JLabel("PH" + i);

				sVBatStatPanel.add(sVBatStats[i][j], c);

			}
		}

		c.gridx = 0;
		c.gridy = 12;
		c.anchor = GridBagConstraints.LINE_START;
		c.insets = new Insets(0, 0, 5, 20);

		sVBatStatPanel.add(new JLabel("Extras"), c);

		c.gridx++;

		sVExtraList = new JLabel("(wd 2, nb 1)");
		sVBatStatPanel.add(sVExtraList, c);

		c.gridx++;
		c.anchor = GridBagConstraints.LINE_END;

		sVExtraTotal = new JLabel("3");
		sVBatStatPanel.add(sVExtraTotal, c);

		c.gridx = 0;
		c.gridy = 13;
		c.anchor = GridBagConstraints.LINE_START;

		sVBatStatPanel.add(new JLabel(Functions.bold("Total")), c);

		c.gridx++;

		sVWktsOvers = new JLabel("(1 wicket; 20 overs)");
		sVBatStatPanel.add(sVWktsOvers, c);

		c.gridx++;
		c.anchor = GridBagConstraints.LINE_END;

		sVTotal = new JLabel(Functions.bold("110"));
		sVBatStatPanel.add(sVTotal, c);

		c.gridx++;
		c.gridwidth = 5;
		c.anchor = GridBagConstraints.LINE_START;
		c.insets = new Insets(0, 0, 5, 0);

		sVRunRate = new JLabel("(5.50 runs per over)");
		sVBatStatPanel.add(sVRunRate, c);

		c.gridx = 0;
		c.gridy = 2;
		c.gridwidth = 1;
		c.anchor = GridBagConstraints.CENTER;
		c.insets = new Insets(0, 0, 20, 0);

		sVBowlStatPanel = new JPanel(new GridBagLayout());
		scorecardView.add(sVBowlStatPanel, c);

		c.gridx = 0;
		c.gridy = 0;
		c.anchor = GridBagConstraints.LINE_START;
		c.insets = new Insets(0, 0, 10, 20);

		sVBowlStatPanel.add(new JLabel(Functions.bold("Bowling")), c);

		c.anchor = GridBagConstraints.LINE_END;

		for (String title: new String[] {"O", "M", "R", "W", "Econ"}) {
			c.gridx++;
			if (c.gridx == 5) {
				c.insets = new Insets(0, 0, 10, 0);
			}
			sVBowlStatPanel.add(new JLabel(title), c);
		}

		sVBowlStats = new JLabel[11][6];

		for (int i = 0; i < 11; i++) {
			for (int j = 0; j < 6; j++) {

				c.gridx = j;
				c.gridy = i + 1;
				c.anchor = (j == 0) ? GridBagConstraints.LINE_START : GridBagConstraints.LINE_END;
				c.insets = new Insets(0, 0, 5, (j == 5) ? 0 : 20);

				sVBowlStats[i][j] = new JLabel("PH" + i);

				sVBowlStatPanel.add(sVBowlStats[i][j], c);

			}
		}

		c.gridx = 0;
		c.gridy = 3;
		c.anchor = GridBagConstraints.LINE_END;
		c.insets = new Insets(0, 0, 0, 0);

		sVBack = new JButton("Back");
		sVBack.addActionListener(this);
		scorecardView.add(sVBack, c);

	}

	public void createPBV() {

		pickBowlerView = new JPanel(new GridBagLayout());
		titles.put(pickBowlerView, "");

		GridBagConstraints c = new GridBagConstraints();

		c.gridwidth = 7;
		c.anchor = GridBagConstraints.LINE_START;
		c.insets = new Insets(0, 0, 20, 0);

		pickBowlerView.add(new JLabel("Pick next bowler:"), c);

		c.gridx++;
		c.gridwidth = 1;
		c.anchor = GridBagConstraints.LINE_END;
		c.insets = new Insets(0, 0, 10, 20);

		for (String title: new String[] {"O", "M", "R", "W", "Econ"}) {
			c.gridx++;
			pickBowlerView.add(new JLabel(title), c);
		}

		pBBowlStats = new JLabel[11][6];

		c.insets = new Insets(0, 0, 5, 20);

		for (int i = 0; i < 11; i++) {
			for (int j = 0; j < 6; j++) {

				c.gridx = j;
				c.gridy = i + 2;
				c.anchor = (j == 0) ? GridBagConstraints.LINE_START : GridBagConstraints.LINE_END;

				pBBowlStats[i][j] = new JLabel("PH" + i);

				pickBowlerView.add(pBBowlStats[i][j], c);

			}
		}

		pBButtons = new JButton[11];

		c.gridx = 6;
		c.gridy = 1;
		c.insets = new Insets(0, 0, 0, 0);

		for (int i = 0; i < 11; i++) {

			c.gridy++;

			pBButtons[i] = new JButton("Select");
			pBButtons[i].addActionListener(this);
			pickBowlerView.add(pBButtons[i], c);

		}

	}

	public static PlayCricket setup() {
		// Creates JFrame object and starts the GUI
		PlayCricket pc = new PlayCricket();

		pc.loadTeams();

		JFrame.setDefaultLookAndFeelDecorated(true);
		// NOTE default font is LucidaGrande size 13
		pc.frame = new JFrame();

		pc.createContentPane();

		for (JPanel panel: pc.allPanels) {
			panel.setVisible(false);
		}

		pc.frame.setContentPane(pc.contentPane);

		pc.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		pc.frame.setSize(1200, 800);
		pc.frame.setVisible(true);

		return pc;

	}

	public static void main(String[] args) {

		PlayCricket pc = setup();

		DataLoader.init();

		pc.switchToPanel(pc.homeMenuView);

	}

	public void actionPerformed(ActionEvent e) {

		if (e.getSource() == hMCreateTeam) {

			switchToPanel(createTeamView);

		} else if (e.getSource() == hMEditTeam) {

			selectTeam("Select team to edit", true, allTeams, State.EDIT_TEAM);

		} else if (e.getSource() == hMPlayT20) {

			playT20();

		} else if (e.getSource() == hMViewStats) {

			selectTeam("Select a team to view stats for:", true, allTeams,
					State.VIEW_STATS_SELECTING_TEAM);

		} else if (e.getSource() == hMQuit) {

			frame.dispatchEvent(new WindowEvent(frame, WindowEvent.WINDOW_CLOSING));

		} else if (e.getSource() == cTCancel) {

			cTClearFields();
			cTErrorMessage.setVisible(false);
			switchToPanel(homeMenuView);

		} else if (e.getSource() == cTFinish || e.getSource() == cTTeamNameEntry
				|| Functions.indexInArray(cTPlayerNameEntries, e.getSource()) > 0
				|| e.getSource() == cTPasswordEntry || e.getSource() == cTConfirmPasswordEntry) {

			cTFinishClicked();

		} else if (e.getSource() == eTAddPlr) {

			switchToPanel(addPlayerView);

		} else if (e.getSource() == eTCancel) {

			switchToPanel(homeMenuView);

		} else if (e.getSource() == eTSwitchPlrs) {

			if (!currEditingTeam.squad.isEmpty()) {
				selectPlr("Select a player to switch out:", true,
						currEditingTeam.getMainPlrsAsList(), State.SELECTING_PLR_TO_SWITCH_OUT);
			} else {
				showMessage(Functions.red("Error: Squad is empty"), "OK", State.SQUAD_EMPTY_ERROR);
			}

		} else if (e.getSource() == eTRemovePlr) {

			if (!currEditingTeam.squad.isEmpty()) {
				selectPlr("Select a player to remove:", true, currEditingTeam.squad,
						State.SELECTING_PLR_TO_REMOVE);
			} else {
				showMessage(Functions.red("Error: Squad is empty"), "OK", State.SQUAD_EMPTY_ERROR);
			}

		} else if (e.getSource() == aPCancel) {

			aPEntry.setText("");
			aPErrorMessage.setVisible(false);
			switchToPanel(editTeamView);

		} else if (e.getSource() == aPFinish || e.getSource() == aPEntry) {

			aPFinishClicked();

		} else if (e.getSource() == cDButton2) {

			cDButton2Clicked();

		} else if (e.getSource() == cDButton1) {

			cDButton1Clicked();

		} else if (e.getSource() == sMButton) {

			sMButtonClicked();

		} else if (e.getSource() == sECancel) {

			sECancelClicked();

		} else if (e.getSource() == sESelect) {

			sESelectClicked();

		} else if (e.getSource() == pSBack) {

			switchToPanel(selectEntityView);

		} else if (e.getSource() == ePCancel) {

			ePCancelClicked();

		} else if (e.getSource() == ePSubmit || e.getSource() == ePEntry) {

			ePSubmitClicked();

		} else if (e.getSource() == mGNextBall) {

			cg.playNextBall();

		} else if (e.getSource() == mGContinue) {

			mGCurrOver.setText("Current over:");

			if (cg.over == 1 || cg.currBowler().inns.ballsBowled == 60) {
				cg.selectNextBowler();
			} else {
				Innings inns = cg.currBowler().inns;
				confirm(String.format("<html>Would you like to change the bowler?<br><br>"
						+ "Current bowler: %s %s-%d-%d-%d</html>", cg.currBowler().name,
						Functions.ballsToOvers(inns.ballsBowled), inns.maidens, inns.runsGiven,
						inns.wkts), "No", "Yes", State.CONFIRM_CHANGE_BOWLER);
			}

		} else if (e.getSource() == mGViewScorecard) {

			switchToPanel(scorecardView);

		} else if (e.getSource() == sVBack) {

			if (sVBack.getText().equals("Back")) {
				switchToPanel(midGameView);
			} else if (sVBack.getText().equals("Continue")) {
				setMidGameViewVisible();
				cg.getReadyForSecondInns();
			} else if (sVBack.getText().equals("Exit")) {
				for (Team team: cg.teams) {
					for (Player plr: team.players) {
						plr.incorporateInnings();
					}
				}
				switchToPanel(homeMenuView);
				commit();
			} else {
				System.out.println("Invalid text for sVBack");
			}

		} else if (Functions.indexInArray(pBButtons, e.getSource()) >= 0) {

			cg.setBowler(cg.fieldingTeam.players[Functions.indexInArray(pBButtons, e.getSource())]);
			cg.getReadyForOverStart();

		} else {

			Functions.setUnimplemented((JButton) e.getSource());

		}

	}

	public void ePCancelClicked() {

		switch (state) {
		// NOTE remember to include break statements!
			case PSWD_EDIT_TEAM:
				switchToPanel(homeMenuView);
				break;
			case PSWD_FIRST_TEAM:
				state = State.SELECTING_FIRST_TEAM;
				switchToPanel(selectEntityView);
				break;
			case PSWD_SECOND_TEAM:
				state = State.SELECTING_SECOND_TEAM;
				switchToPanel(selectEntityView);
				break;
			default:
				System.out.println("INVALID STATE FOR ePCancelClicked");
				break;
		}

	}

	public void ePSubmitClicked() {

		if (currEnteringPswdTeam.password.equals(new String(ePEntry.getPassword()))) {

			switch (state) {
			// NOTE remember to include break statements!
				case PSWD_EDIT_TEAM:
					switchToPanel(editTeamView);
					break;
				case PSWD_FIRST_TEAM:
					selectTeam("Select second team:", true,
							Functions.listWithoutElem(allTeams, cg.teams[0]),
							State.SELECTING_SECOND_TEAM);
					break;
				case PSWD_SECOND_TEAM:
					for (Player plr: cg.teams[0].players) {
						plr.inns = new Innings();
					}
					for (Player plr: cg.teams[1].players) {
						plr.inns = new Innings();
					}
					confirm(cg.teams[0].name + ", select heads or tails.", "Heads", "Tails",
							State.HEADS_OR_TAILS);
					break;
				default:
					System.out.println("INVALID STATE FOR ePSubmitClicked");
					break;
			}

		} else {

			ePErrorMessage.setVisible(true);

		}

	}

	public void sECancelClicked() {
		switch (state) {
		// NOTE remember to include break statements!
			case EDIT_TEAM:
			case VIEW_STATS_SELECTING_TEAM:
			case VIEW_STATS_SELECTING_PLR:
			case SELECTING_FIRST_TEAM:
			case SELECTING_SECOND_TEAM:
				switchToPanel(homeMenuView);
				break;

			case SELECTING_PLR_TO_SWITCH_OUT:
			case SELECTING_PLR_TO_SWITCH_IN:
			case SELECTING_PLR_TO_REMOVE:
				switchToPanel(editTeamView);
				break;

			default:
				System.out.println("INVALID STATE FOR sECancelClicked");
				break;

		}
	}

	public void sESelectClicked() {

		switch (state) {
		// NOTE remember to include break statements!
			case EDIT_TEAM:
				currEditingTeam = currSearchingTeamList.get(sESelection.getSelectedIndex());
				getPassword(currEditingTeam, State.PSWD_EDIT_TEAM);
				break;

			case VIEW_STATS_SELECTING_TEAM:
				Team viewingTeam = currSearchingTeamList.get(sESelection.getSelectedIndex());
				String plrListStr = "<html><div align=\"center\"><b>Players:</b><br>";
				for (Player plr: viewingTeam.players) {
					plrListStr += plr.name + "<br>";
				}
				if (!viewingTeam.squad.isEmpty()) {
					plrListStr += "<br><b>Squad:</b><br>";
					for (Player plr: viewingTeam.squad) {
						plrListStr += plr.name + "<br>";
					}
				}
				plrListStr += "<br>";
				selectPlr(plrListStr + "Select a player to view stats for:" + "</div></html>",
						true, viewingTeam.getAllPlrs(), State.VIEW_STATS_SELECTING_PLR);
				break;

			case VIEW_STATS_SELECTING_PLR:
				updateStatsView(currSearchingPlrList.get(sESelection.getSelectedIndex()));
				switchToPanel(plrStatsView);
				break;

			case SELECTING_PLR_TO_SWITCH_OUT:
				eTPlrBeingSwitchedOut = currSearchingPlrList.get(sESelection.getSelectedIndex());
				selectPlr("Select a player to switch in:", true, currEditingTeam.squad,
						State.SELECTING_PLR_TO_SWITCH_IN);
				break;

			case SELECTING_PLR_TO_SWITCH_IN:
				eTPlrBeingSwitchedIn = currSearchingPlrList.get(sESelection.getSelectedIndex());
				confirm("Are you sure you want to switch out " + eTPlrBeingSwitchedOut.name
						+ " and switch in " + eTPlrBeingSwitchedIn.name + "?", "No", "Yes",
						State.CONFIRM_SWITCHING_PLRS);
				break;

			case SELECTING_PLR_TO_REMOVE:
				eTPlrToRemove = currSearchingPlrList.get(sESelection.getSelectedIndex());
				confirm("Are you sure you want to remove " + eTPlrToRemove.name + " from "
						+ currEditingTeam.name + "?", "No", "Yes", State.CONFIRM_REMOVE_PLR);
				break;

			case SELECTING_FIRST_TEAM:
				cg.teams[0] = currSearchingTeamList.get(sESelection.getSelectedIndex());
				getPassword(cg.teams[0], State.PSWD_FIRST_TEAM);
				break;

			case SELECTING_SECOND_TEAM:
				cg.teams[1] = currSearchingTeamList.get(sESelection.getSelectedIndex());
				getPassword(cg.teams[1], State.PSWD_SECOND_TEAM);
				break;

			case SELECTING_WKTKEEPER:
				cg.wktKeeper = currSearchingPlrList.get(sESelection.getSelectedIndex());
				selectPlr("Pick the first batsman:", false,
						Functions.listFromArray(cg.battingTeam.players),
						State.SELECTING_FIRST_BATSMAN);
				break;

			case SELECTING_FIRST_BATSMAN:
				cg.addBatsman(currSearchingPlrList.get(sESelection.getSelectedIndex()), true);
				selectPlr("Pick the second batsman:", false,
						Functions.listWithoutElem(cg.battingTeam.players, cg.batsmen[0]),
						State.SELECTING_SECOND_BATSMAN);
				break;

			case SELECTING_SECOND_BATSMAN:
				cg.addBatsman(currSearchingPlrList.get(sESelection.getSelectedIndex()), false);
				selectPlr("Pick the first bowler:", false, Functions.listWithoutElem(
						Functions.listFromArray(cg.fieldingTeam.players), cg.wktKeeper),
						State.SELECTING_FIRST_BOWLER);
				break;

			case SELECTING_FIRST_BOWLER:
				cg.setBowler(currSearchingPlrList.get(sESelection.getSelectedIndex()));
				if (cg.isFirstInns) {
					cg.start();
				} else {
					cg.startSecondInns();
				}
				break;

			case SELECTING_NEW_BATSMAN:
				cg.addBatsman(currSearchingPlrList.get(sESelection.getSelectedIndex()),
						cg.strikerWasOut == cg.index0IsStriker);
				cg.getReadyForNextBall();
				break;

			default:
				System.out.println("INVALID STATE FOR sESelectClicked: " + state);
				break;

		}

	}

	public void sMButtonClicked() {

		switch (state) {
		// NOTE break statements
			case SQUAD_EMPTY_ERROR:
				switchToPanel(editTeamView);
				break;

			case SHOWING_NOTIFICATION:
			case SHOWING_BALL_RESULT:
				if (!cg.notifications.isEmpty()) {

					showMessage(cg.notifications.poll(), "OK", State.SHOWING_NOTIFICATION);

				} else if (cg.inningsFinished()) {

					updateMidGameViewEndOfInns();
					if (cg.isFirstInns) {
						switchToPanel(midGameView);
					} else {
						showMessage(cg.winnerMessage(), "OK", State.END_OF_GAME);
					}

				} else if (cg.isOut) {

					List<Player> availableBatsmen = Functions.listSubtract(cg.battingTeam.players,
							cg.haveBatted);
					selectPlr("Select a new batsman:", false, availableBatsmen,
							State.SELECTING_NEW_BATSMAN);

				} else {

					cg.getReadyForNextBall();

				}

				break;

			case END_OF_GAME:
				switchToPanel(midGameView);
				break;

			default:
				System.out.println("INVALID STATE FOR sMButtonClicked");
				break;
		}

	}

	// cDButton1 is usually "no"
	public void cDButton1Clicked() {

		switch (state) {
		// NOTE remember to include break statements!
			case CONFIRM_ADDING_PLR:
				switchToPanel(addPlayerView);
				break;

			case CONFIRM_CREATING_TEAM:
				switchToPanel(createTeamView);
				break;

			case CONFIRM_SWITCHING_PLRS:
			case CONFIRM_REMOVE_PLR:
				switchToPanel(editTeamView);
				break;

			case HEADS_OR_TAILS:
				cg.selectedHeads = true;
				cg.askBatOrField();
				break;

			case BAT_OR_FIELD:
				cg.battingTeam = cg.teams[cg.wonToss ? 0 : 1];
				cg.fieldingTeam = cg.teams[cg.wonToss ? 1 : 0];
				cg.promptWktkeeper();
				break;

			case CONFIRM_CHANGE_BOWLER:
				updateScore(false);
				switchToMidOver();
				switchToPanel(midGameView);
				break;

			default:
				System.out.println("INVALID STATE FOR cdButton1Clicked: " + state);
				break;

		}

	}

	// cDButton2 is usually "yes"
	public void cDButton2Clicked() {

		switch (state) {
		// NOTE remember to include break statements!
			case CONFIRM_ADDING_PLR:
				switchToPanel(editTeamView);
				currEditingTeam.addPlayer(aPEntry.getText());
				aPEntry.setText("");
				commit();
				break;

			case CONFIRM_CREATING_TEAM:
				switchToPanel(homeMenuView);
				String[] plrNames = new String[11];
				for (int i = 0; i < 11; i++) {
					plrNames[i] = cTPlayerNameEntries[i].getText();
				}
				Team newTeam = new Team(cTTeamNameEntry.getText(), new String(
						cTPasswordEntry.getPassword()), plrNames);
				allTeams.add(newTeam); // add the new team

				cTClearFields();
				commit();
				break;

			case CONFIRM_SWITCHING_PLRS:
				switchToPanel(editTeamView);
				currEditingTeam.switchPlrs(eTPlrBeingSwitchedOut, eTPlrBeingSwitchedIn);
				commit();
				break;

			case CONFIRM_REMOVE_PLR:
				switchToPanel(editTeamView);
				currEditingTeam.removePlr(eTPlrToRemove);
				commit();
				break;

			case HEADS_OR_TAILS:
				cg.selectedHeads = false;
				cg.askBatOrField();
				break;

			case BAT_OR_FIELD:
				cg.battingTeam = cg.teams[cg.wonToss ? 1 : 0];
				cg.fieldingTeam = cg.teams[cg.wonToss ? 0 : 1];
				cg.promptWktkeeper();
				break;

			case CONFIRM_CHANGE_BOWLER:
				cg.selectNextBowler();
				break;

			default:
				System.out.println("INVALID STATE FOR cdButton2Clicked");
				break;

		}

	}

	public void aPFinishClicked() {

		boolean isValid = true;

		if (currEditingTeam.containsPlayerWithName(aPEntry.getText().trim())) {
			aPErrorMessage.setText(Functions.red("Error: Player with that name already exists on team"));
			isValid = false;
		}

		if (!Functions.isValidName(aPEntry.getText())) {
			aPErrorMessage.setText(Functions.red("Error: Invalid player name - player names can "
					+ "only contain letters, numbers, and spaces"));
			isValid = false;
		}

		if (aPEntry.getText().trim().isEmpty()) {
			aPErrorMessage.setText(Functions.red("Error: Player name cannot be empty"));
			isValid = false;
		}

		if (isValid) {
			aPErrorMessage.setVisible(false);
			confirm("Are you sure you want to add a player with name \"" + aPEntry.getText()
					+ "\" to " + currEditingTeam.name + "?", "No", "Yes", State.CONFIRM_ADDING_PLR);
		} else {
			aPErrorMessage.setVisible(true);
		}
	}

	public void cTFinishClicked() {
		String[] plrNames = new String[11];
		for (int i = 0; i < 11; i++) {
			plrNames[i] = cTPlayerNameEntries[i].getText();
		}

		boolean isValid = checkTeamToCreate(cTTeamNameEntry.getText(), plrNames, new String(
				cTPasswordEntry.getPassword()), new String(cTConfirmPasswordEntry.getPassword()));

		if (isValid) {
			cTErrorMessage.setVisible(false);
			confirm("Are you sure you want to create team " + cTTeamNameEntry.getText() + "?",
					"No", "Yes", State.CONFIRM_CREATING_TEAM);
		} else {
			cTErrorMessage.setVisible(true);
		}
	}

	public void cTClearFields() { // Clear all fields in create team view
		cTTeamNameEntry.setText("");
		for (int i = 0; i < 11; i++) {
			cTPlayerNameEntries[i].setText("");
		}
		cTPasswordEntry.setText("");
		cTConfirmPasswordEntry.setText("");
	}

	public void updateScore(boolean switchBowlersIfFirstBall) {
		// Updates all text fields containing scores, run rate, over, etc. using
		// currGame
		// switchBowlersIfFirstBall should be false by default

		mGScore.setText(String.format(MG_SCORE_TEXT, cg.score, cg.wkts));

		if (cg.ball == 1) {
			mGOvers.setText(String.format("(%d overs)", cg.over));
		} else {
			mGOvers.setText(String.format("(%d.%d overs)", cg.over, cg.ball - 1));
		}

		mGOvers.setText(String.format("(%s over%s)", Functions.ballsToOvers(6 * cg.over + cg.ball
				- 1), (cg.over == 1 && cg.ball == 1) ? "" : "s"));

		if (cg.over == 0 && cg.ball == 1) {
			mGRunRate.setText("Run rate: N/A");
		} else {
			mGRunRate.setText(String.format("Run rate: %.2f", cg.getRunRate()));
		}

		if (!cg.isFirstInns) {
			int ballsLeft = cg.numOvers * 6 - cg.ballsElapsed();
			mGReqRunRate.setText(String.format("%d runs required from %s (RRR: %.2f)", cg.target
					- cg.score, (ballsLeft > 60) ? (Functions.ballsToOvers(ballsLeft) + " overs")
					: (ballsLeft + " balls"), ((double) (cg.target - cg.score)) / ballsLeft));
		}

		mGBatsman0.setText(String.format(MG_BATSMEN_TEXT, cg.batsmen[0].name,
				cg.batsmen[0].inns.score + (cg.index0IsStriker ? "*" : ""),
				cg.batsmen[0].inns.ballsFaced, cg.batsmen[0].inns.fours, cg.batsmen[0].inns.sixes));
		mGBatsman1.setText(String.format(MG_BATSMEN_TEXT, cg.batsmen[1].name,
				cg.batsmen[1].inns.score + (cg.index0IsStriker ? "" : "*"),
				cg.batsmen[1].inns.ballsFaced, cg.batsmen[1].inns.fours, cg.batsmen[1].inns.sixes));

		Player currBowler = (cg.ball == 1 && switchBowlersIfFirstBall) ? cg.offBowler()
				: cg.currBowler();
		Player otherBowler = (cg.ball == 1 && switchBowlersIfFirstBall) ? cg.currBowler()
				: cg.offBowler();

		mGBowler0.setText(currBowler.name);
		mGBowler0Stats.setText(String.format("%s-%d-%d-%d",
				Functions.ballsToOvers(currBowler.inns.ballsBowled), currBowler.inns.maidens,
				currBowler.inns.runsGiven, currBowler.inns.wkts));

		try {

			if (cg.over == 1 && cg.ball == 1) {
				mGBowler1.setVisible(true);
				mGBowler1Stats.setVisible(true);
			}
			mGBowler1.setText(otherBowler.name);
			mGBowler1Stats.setText(String.format("%s-%d-%d-%d",
					Functions.ballsToOvers(otherBowler.inns.ballsBowled), otherBowler.inns.maidens,
					otherBowler.inns.runsGiven, otherBowler.inns.wkts));

		} catch (NullPointerException e) {

			mGBowler1.setVisible(false);
			mGBowler1Stats.setVisible(false);

		}

		for (int i = 0; i < cg.haveBatted.size(); i++) {

			Innings inns = cg.haveBatted.get(i).inns;
			JLabel[] row = sVBatStats[i];

			row[2].setText(Integer.toString(inns.score));
			row[3].setText(Integer.toString(inns.ballsFaced));
			row[4].setText(Integer.toString(inns.fours));
			row[5].setText(Integer.toString(inns.sixes));
			if (inns.ballsFaced > 0) {
				row[6].setText(inns.getSR());
			} else {
				row[6].setText("-");
			}

		}

		for (int i = 0; i < cg.haveBowled.size(); i++) {

			Innings inns = cg.haveBowled.get(i).inns;
			JLabel[] row = sVBowlStats[i];

			row[1].setText(Functions.ballsToOvers(inns.ballsBowled));
			row[2].setText(Integer.toString(inns.maidens));
			row[3].setText(Integer.toString(inns.runsGiven));
			row[4].setText(Integer.toString(inns.wkts));
			if (inns.ballsBowled > 0) {
				row[5].setText(String.format("%.2f", inns.runsGiven * 6.0 / inns.ballsBowled));
			} else {
				row[5].setText("-");
			}

		}

		sVExtraList.setText(cg.getExtraList());

		sVExtraTotal.setText(Integer.toString(Functions.arraySum(cg.extras)));

		sVWktsOvers.setText(String.format("%d wicket%s; %s over%s", cg.wkts, cg.wkts == 1 ? ""
				: "s", Functions.ballsToOvers(cg.ballsElapsed()),
				(cg.over == 1 && cg.ball == 1) ? "" : "s"));

		sVTotal.setText(Integer.toString(cg.score));

		if (cg.over == 0 && cg.ball == 1) {
			sVRunRate.setText("");
		} else {
			sVRunRate.setText(String.format("(%.2f runs per over)",
					cg.score * 6.0 / cg.ballsElapsed()));
		}

		for (int i = 0; i < 11; i++) {

			Innings inns = cg.fieldingTeam.players[i].inns;
			JLabel[] row = pBBowlStats[i];

			row[1].setText(Functions.ballsToOvers(inns.ballsBowled));
			row[2].setText(Integer.toString(inns.maidens));
			row[3].setText(Integer.toString(inns.runsGiven));
			row[4].setText(Integer.toString(inns.wkts));
			if (inns.ballsBowled > 0) {
				row[5].setText(String.format("%.2f", inns.runsGiven * 6.0 / inns.ballsBowled));
			} else {
				row[5].setText("-");
			}

		}

	}

	public void updateMidGameViewEndOfInns() {

		updateScore(true);
		mGReqRunRate.setVisible(false);
		mGBatsmen.setVisible(false);
		mGBowlers.setVisible(false);
		mGCurrOver.setText("End of innings");

		if (cg.isFirstInns) {
			cg.commentaryText.append("<tr><td colspan=\"2\" valign=\"top\"><b>End of first innings"
					+ "</b></td></tr>");
		} else {
			cg.commentaryText.append("<tr><td colspan=\"2\" valign=\"top\"><b>End of second innings"
					+ "</b></td></tr><tr><td colspan=\"2\" valign=\"top\"><b>"
					+ cg.winnerMessage()
					+ "</b></td></tr>");
		}
		mGCommentary.setText("<table>" + cg.commentaryText.toString() + "</table>");

		mGContinue.setVisible(false);
		mGNextBall.setVisible(false);
		if (cg.isFirstInns) {
			sVBack.setText("Continue");
		} else {
			sVBack.setText("Exit");
		}

	}

	public void setMidGameViewVisible() {
		// Resets everything set to invisible in updateMidGameViewEndOfInns
		mGBatsmen.setVisible(true);
		mGBowlers.setVisible(true);
		mGContinue.setVisible(true);
		mGNextBall.setVisible(true);
		sVBack.setText("Back");
	}

	public void hideCurrPanel() {
		// Hides current JPanel
		currPanel.setVisible(false);
		currPanel = null;
	}

	public void switchToPanel(JPanel panel) {
		if (currPanel != null) {
			hideCurrPanel();
		}
		panel.setVisible(true);
		frame.setContentPane(panel);

		frame.setTitle(titles.get(panel));
		currPanel = panel;

		if (panel == editTeamView) {
			if (currEditingTeam != null) {
				frame.setTitle("Edit team " + currEditingTeam.name);
			}
		} else if (panel == addPlayerView) {
			if (currEditingTeam != null) {
				frame.setTitle("Add player to " + currEditingTeam.name);
			}
		}
	}

	public void selectPlr(String prompt, boolean showCancel, List<Player> plrs, State s) {

		sECancel.setEnabled(showCancel);

		state = s;

		sEPrompt.setText(prompt);
		currSearchingPlrList = plrs;
		sESelection.removeAllItems();
		for (Player plr: plrs) {
			sESelection.addItem(plr.name);
		}
		switchToPanel(selectEntityView);

	}

	public void selectTeam(String prompt, boolean showCancel, List<Team> teams, State s) {

		sECancel.setEnabled(showCancel);

		state = s;

		sEPrompt.setText(prompt);
		currSearchingTeamList = teams;
		sESelection.removeAllItems();
		for (Team team: teams) {
			sESelection.addItem(team.name);
		}
		switchToPanel(selectEntityView);
	}

	public boolean checkTeamToCreate(String teamName, String[] plrNames, String pswd,
			String confirmPswd) {

		// returns true iff given consitutes a valid team

		if (!pswd.equals(confirmPswd)) {
			cTErrorMessage.setText(Functions.red("Error: Passwords do not match"));
			return false;
		}

		if (teamName.trim().isEmpty()) {
			cTErrorMessage.setText(Functions.red("Error: Team name can't be empty"));
			return false;
		}

		for (String name: plrNames) {
			if (name.trim().isEmpty()) {
				cTErrorMessage.setText(Functions.red("Error: Player name can't be empty"));
				return false;
			}
		}

		if (pswd.isEmpty()) {
			cTErrorMessage.setText(Functions.red("Error: Password can't be empty"));
			return false;
		}

		if (!Functions.isValidName(teamName)) {
			cTErrorMessage.setText(Functions.red("Error: Invalid team name: team names can only "
					+ "contain letters, numbers, and spaces"));
			return false;
		}

		for (String name: plrNames) {
			if (!Functions.isValidName(name)) {
				cTErrorMessage.setText(Functions.red("Error: Invalid player name: team names can "
						+ "only contain letters, numbers, and spaces"));
				return false;
			}
		}

		for (int i = 0; i < 11; i++) {
			for (int j = i + 1; j < 11; j++) {
				if (cTPlayerNameEntries[i].getText().equals(cTPlayerNameEntries[j].getText())) {

					cTErrorMessage.setText(Functions.red("Error: Players " + (i + 1) + " and "
							+ (j + 1) + " have the same name."));
					return false;
				}
			}
		}

		for (Team team: allTeams) {
			if (team.name.equals(teamName.trim())) {
				cTErrorMessage.setText(Functions.red("Error: Team with name \"" + teamName.trim()
						+ "\" already exists."));
				return false;
			}
		}

		return true;
	}

	public void playT20() {

		switchToMidOver();

		resetInGameViews();

		cg = new CricketGame(this, 20);
		selectTeam("Select first team", true, allTeams, State.SELECTING_FIRST_TEAM);

	}

	public void loadTeams() {
		// allTeams = new ArrayList<Team>();
		// allTeams.add(new Team("Team 1"));
		// allTeams.add(new Team("Team 2"));
		// allTeams.add(new Team("Team 3"));
		// TODO remove
		allTeams = DataLoader.readAllTeams();
	}

	public void commit() {
		// commits all changes made during session to the text file
		DataLoader.writeAllTeams(allTeams);
	}

	public void confirm(String prompt, String button1Text, String button2Text, State s) {
		// Goes to confirm dialog view
		state = s;
		cDPrompt.setText(prompt);
		cDButton1.setText(button1Text);
		cDButton2.setText(button2Text);
		switchToPanel(confirmDialogView);
	}

	public void showMessage(String message, String buttonText, State s) {
		state = s;
		sMMessage.setText(message);
		sMButton.setText(buttonText);
		switchToPanel(showMessageView);
	}

	public void updateStatsView(Player plr) { // updates plrStatsView with given
												// player's stats

		pSMatches.setText("Matches: " + plr.stats.s[PlayerStats.NUM_MATCHES]);

		String[] batStats = plr.stats.getBatStats();
		String[] bowlStats = plr.stats.getBowlStats();

		for (int i = 0; i < batStats.length; i++) {
			pSBatStats[i].setText(PlayerStats.BAT_STATS_LIST[i] + ": " + batStats[i]);
		}

		for (int i = 0; i < bowlStats.length; i++) {
			pSBowlStats[i].setText(PlayerStats.BOWL_STATS_LIST[i] + ": " + bowlStats[i]);
		}

		titles.put(plrStatsView, "Stats for " + plr.name);
	}

	public void getPassword(Team team, State s) {

		state = s;
		currEnteringPswdTeam = team;
		ePPrompt.setText("Enter password for " + team.name + ":");
		ePErrorMessage.setVisible(false);
		ePEntry.setText("");
		switchToPanel(enterPswdView);

	}

	public void switchToMidOver() {
		mGContinue.setVisible(false);
		mGNextBall.setVisible(true);
	}

	public void switchToEndOver() {
		mGContinue.setVisible(true);
		mGNextBall.setVisible(false);
		mGCurrOver.setText("End of over " + cg.over);
	}

	public void resetInGameViews() {

		mGCommentary.setText("");

		mGReqRunRate.setVisible(false);

		mGCurrOver.setText("Current over:");

		for (JLabel[] row: sVBatStats) {
			for (JLabel label: row) {
				label.setVisible(false);
			}
		}

		for (JLabel[] row: sVBowlStats) {
			for (JLabel label: row) {
				label.setVisible(false);
			}
		}

		sVBack.setText("Back");

	}

}