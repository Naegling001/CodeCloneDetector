package com.github.mihirsinghal.cricket;

public class PlayerStats { // Holds stats for a player. Can hold stats for a
							// player's career or for a single game.

	final static String[] BAT_STATS_LIST = new String[] {"Innings", "Not out", "Runs",
			"High score", "Average", "Balls faced", "Strike rate", "100s", "50s", "4s", "6s"};
	final static String[] BOWL_STATS_LIST = new String[] {"Innings", "Balls", "Runs", "Wickets",
			"BBI", "Average", "Economy rate", "Strike rate", "4w", "5w"};

	final static int NUM_MATCHES = 0;
	// Batting stats
	final static int BAT_INNS = 1;
	final static int RUNS_SCORED = 2;
	final static int HIGH_SCORE = 3;
	final static int HS_NO = 4; // High score not out, always 0 (out) or 1 (not
								// out)
	final static int NOT_OUTS = 5;
	final static int BALLS_FACED = 6;
	final static int CENTURIES = 7;
	final static int FIFTIES = 8;
	final static int FOURS = 9;
	final static int SIXES = 10;

	// Bowling stats
	final static int BOWL_INNS = 11;
	final static int BALLS_BOWLED = 12;
	final static int RUNS_GIVEN = 13;
	final static int WKTS = 14;
	final static int BBI_WKTS = 15;
	final static int BBI_RUNS = 16;
	final static int FOUR_WKTS = 17;
	final static int FIVE_WKTS = 18;

	final static int NUM_STATS = 19;
	int[] s; // array in which the number at each index corresponds to the
				// statistic assigned to the index above

	public PlayerStats() {
		
		s = new int[NUM_STATS];
		s[HIGH_SCORE] = -1;
		
	}

	public PlayerStats(int[] stats) {

		this.s = stats;
		assert stats.length == NUM_STATS;

	}

	public String[] getBatStats() {
		// Updates derived statistics such as average, SR, etc.

		String[] ans = new String[11];
		ans[0] = Integer.toString(s[BAT_INNS]);
		ans[1] = Integer.toString(s[NOT_OUTS]);
		ans[2] = Integer.toString(s[RUNS_SCORED]);
		if (s[HIGH_SCORE] == -1) {
			ans[3] = "-";
		} else {
			ans[3] = Integer.toString(s[HIGH_SCORE]);
			if (s[HS_NO] == 1) {
				ans[3] += "*";
			} else {
				assert s[HS_NO] == 0;
			}
		}
		if (s[BAT_INNS] == s[NOT_OUTS]) {
			ans[4] = "-";
		} else {
			ans[4] = String.format("%.2f", ((double) s[RUNS_SCORED]) / (s[BAT_INNS] - s[NOT_OUTS]));
		}
		ans[5] = Integer.toString(s[BALLS_FACED]);
		if (s[BALLS_FACED] == 0) {
			ans[6] = "-";
		} else {
			ans[6] = String.format("%.2f", 100.0 * s[RUNS_SCORED] / s[BALLS_FACED]);
		}
		ans[7] = Integer.toString(s[CENTURIES]);
		ans[8] = Integer.toString(s[FIFTIES]);
		ans[9] = Integer.toString(s[FOURS]);
		ans[10] = Integer.toString(s[SIXES]);

		return ans;

	}

	public String[] getBowlStats() {

		String[] ans = new String[10];
		ans[0] = Integer.toString(s[BOWL_INNS]);
		ans[1] = Integer.toString(s[BALLS_BOWLED]);
		ans[2] = Integer.toString(s[RUNS_GIVEN]);
		ans[3] = Integer.toString(s[WKTS]);
		if (s[BBI_WKTS] == 0) {
			ans[4] = "-";
		} else {
			ans[4] = s[BBI_WKTS] + "/" + s[BBI_RUNS];
		}
		if (s[WKTS] == 0) {
			ans[5] = ans[7] = "-";
		} else {
			ans[5] = String.format("%.2f", ((double) s[RUNS_GIVEN]) / s[WKTS]);
			ans[7] = String.format("%.2f", ((double) s[BALLS_BOWLED]) / s[WKTS]);
		}
		if (s[BALLS_BOWLED] == 0) {
			ans[6] = "-";
		} else {
			ans[6] = String.format("%.2f", 6.0 * s[RUNS_GIVEN] / s[BALLS_BOWLED]);
		}
		ans[8] = Integer.toString(s[FOUR_WKTS]);
		ans[9] = Integer.toString(s[FIVE_WKTS]);
		return ans;

	}
}
