package com.github.mihirsinghal.cricket;

public class Ball {

	String exec; // e.g. "4run+nb"
	String shortForm; // e.g. "5nb"
	String longForm; // e.g. "5 no ball"
	String commentary; // e.g.
						// "The bowler oversteps and the batsman hits it for four"
	String message;
	String method; // If out, the method of being out
	Ball ifFreeHit;

	/*
	 * List of exec commands:
	 * 
	 * dot: dot ball (no runs)
	 * *run: * runs
	 * four: 4 runs, boundary
	 * six: 6 runs, boundary
	 * out: striker out
	 * nsout: nonstriker out
	 * *wd: * wides (0 wides = normal wide, 4 wides = four + wide, etc.)
	 * *nb: * no balls (due to height or overstepping) <- ball counts for
	 * batsman Note: the * is only added to when the ball goes for byes after
	 * the no ball. If the batsman hit the ball, then use *run+nb
	 * *nbw: * no balls (due to ball being too wide) <- ball does not count for
	 * batsman
	 * *bye: * byes
	 * *lb: * leg byes
	 * + joins commands
	 * Important: out should always be last!
	 * 
	 * 
	 * List of tags:
	 * 
	 * [b]: bowler
	 * [s]: striker
	 * [ns]: nonstriker
	 * [wk]: wicketkeeper
	 * [rf*]: random fielder
	 * [ft]: fielding team name
	 * [bt]: batting team name
	 */

	public Ball(String exec, String shortForm, String longForm, String commentary, String message) {
		this.exec = exec.trim();
		this.shortForm = shortForm;
		this.longForm = longForm;
		this.commentary = commentary;
		this.message = message;
		ifFreeHit = this;
	}

	public Ball(String exec, String shortForm, String longForm, String commentary, String message,
			String method) {
		this.exec = exec;
		this.shortForm = shortForm;
		this.longForm = longForm;
		this.commentary = commentary;
		this.message = message;
		this.method = method;
		ifFreeHit = this;
	}

	public Ball(String exec, String shortForm, String longForm, String commentary, String message,
			String method, Ball ifFreeHit) {
		this.exec = exec;
		this.shortForm = shortForm;
		this.longForm = longForm;
		this.commentary = commentary;
		this.message = message;
		this.method = method;
		this.ifFreeHit = ifFreeHit;
	}

}
