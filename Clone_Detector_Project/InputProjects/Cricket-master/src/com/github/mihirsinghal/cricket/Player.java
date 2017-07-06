package com.github.mihirsinghal.cricket;

public class Player {

	String name;
	PlayerStats stats;
	Innings inns;

	public Player(String name) {
		this.name = name;
		stats = new PlayerStats(); 
	}
	
	public Player(String name, int[] stats) {
		this.name = name;
		this.stats = new PlayerStats(stats);
	}

	public void incorporateInnings() { // Uses currInns to update stats
		inns.incorporateInnings(stats);

	}

}
