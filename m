Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB50VV430050
	for linux-mips-outgoing; Tue, 4 Dec 2001 16:31:31 -0800
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB50VRo30047
	for <linux-mips@oss.sgi.com>; Tue, 4 Dec 2001 16:31:27 -0800
Received: from gate.mgnet.de (gate.gmx.net [194.221.183.17])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id AAA21910
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 00:31:24 +0100 (MET)
Received: (qmail 3224 invoked from network); 4 Dec 2001 23:30:13 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by gate.mgnet.de with SMTP; 4 Dec 2001 23:30:13 -0000
Date: Wed, 5 Dec 2001 00:31:24 +0100 (CET)
From: Klaus Naumann <spock@mgnet.de>
To: Linux/MIPS list <linux-mips@oss.sgi.com>
Subject: Re: 2.4.16 success on Decstation 5000/150
In-Reply-To: <Pine.GSO.3.96.1011204131553.5469D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.21.0112050028270.14590-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Morning ppl,

something wonderful happened - the Illegal Instruction Problem
which I had on my I2 magically went away using 2.4.16 from
current cvs.
Boots just fine.

	Cya, Klaus

root@ivy:~# cat /proc/cpuinfo
processor               : 0
cpu model               : R4000SC V6.0  FPU V0.0
BogoMIPS                : 100.44
wait instruction        : no
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 7269
VCEI exceptions         : 2267


-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
