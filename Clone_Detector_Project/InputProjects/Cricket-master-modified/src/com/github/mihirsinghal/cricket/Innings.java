package com.github.mihirsinghal.cricket;

public class Innings implements Cloneable {

	// Batting stats
	boolean batted; 
	int score;
	boolean notOut;
	int ballsFaced;
	int fours;
	int sixes;

	// Bowling stats
	boolean bowled;
	int ballsBowled;
	int runsGiven;
	int maidens; // maidens is only used in-game, not for stats purposes
	int wkts;
	
	public Innings() {
		notOut = true;
	}
	
	public Innings clone() {
		
		try {
			return (Innings) super.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	public String getSR() {
		return (ballsFaced == 0) ? "-" : String.format("%.2f", score * 100.0 / ballsFaced);
	}

	public void incorporateInnings(PlayerStats stats) {
		stats.s[PlayerStats.NUM_MATCHES]++;
		if (this.batted) {
			stats.s[PlayerStats.BAT_INNS]++;
			stats.s[PlayerStats.RUNS_SCORED] += this.score;
			if (this.score > stats.s[PlayerStats.HIGH_SCORE]) {
				stats.s[PlayerStats.HIGH_SCORE] = this.score;
				stats.s[PlayerStats.HS_NO] = this.notOut ? 1 : 0;
			} else if (this.score == stats.s[PlayerStats.HIGH_SCORE] && this.notOut) {
				stats.s[PlayerStats.HS_NO] = 1;
			}
			if (this.notOut) {
				stats.s[PlayerStats.NOT_OUTS]++;
			}
			stats.s[PlayerStats.BALLS_FACED] += this.ballsFaced;
			if (this.score >= 100) {
				stats.s[PlayerStats.CENTURIES]++;
			} else if (this.score >= 50) {
				stats.s[PlayerStats.FIFTIES]++;
			}
			stats.s[PlayerStats.FOURS] += this.fours;
			stats.s[PlayerStats.SIXES] += this.sixes;
		}
		if (this.bowled) {
			stats.s[PlayerStats.BOWL_INNS]++;
			stats.s[PlayerStats.BALLS_BOWLED] += this.ballsBowled;
			stats.s[PlayerStats.RUNS_GIVEN] += this.runsGiven;
			stats.s[PlayerStats.WKTS] += this.wkts;
			if (this.wkts > stats.s[PlayerStats.BBI_WKTS]) {
				stats.s[PlayerStats.BBI_WKTS] = this.wkts;
				stats.s[PlayerStats.BBI_RUNS] = this.runsGiven;
			} else if (this.wkts == stats.s[PlayerStats.BBI_WKTS] && this.runsGiven < stats.s[PlayerStats.BBI_RUNS]) {
				stats.s[PlayerStats.BBI_RUNS] = this.runsGiven;
			}
			if (this.wkts >= 5) {
				stats.s[PlayerStats.FIVE_WKTS]++;
			} else if (this.wkts == 4) {
				stats.s[PlayerStats.FOUR_WKTS]++;
			}
		}
	}

}
