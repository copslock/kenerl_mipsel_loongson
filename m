Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FJ5Kv29384
	for linux-mips-outgoing; Tue, 15 Jan 2002 11:05:20 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FJ5HP29380
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 11:05:17 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 87872A092; Tue, 15 Jan 2002 19:05:14 +0100 (CET)
Date: Tue, 15 Jan 2002 19:05:14 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Perl on R4k6 (_not_ the segfault problem)
Message-ID: <20020115190514.N15285@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

I'm facing another problem with Perl. (Again, this is on nfsroot.)
Some perl scripts ( notably update-info) stall, they do not(!)
segfault). I strace'd it a time, last operation was a munmap().

The problem appears independend of the settings for LD_BIND_NOW,
so it's different from the problem described on Debian's
Ports pages.

Is anybody working on this, or is anything known about this?

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
