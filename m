Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4EDIunC027162
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 14 May 2002 06:18:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4EDIuXj027161
	for linux-mips-outgoing; Tue, 14 May 2002 06:18:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4EDIonC027151;
	Tue, 14 May 2002 06:18:51 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA02245;
	Tue, 14 May 2002 15:18:50 +0200 (MET DST)
Date: Tue, 14 May 2002 15:18:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: [PATCH] gettimeoffset for swarm
In-Reply-To: <3CE073D0.8030402@mvista.com>
Message-ID: <Pine.GSO.3.96.1020514150417.1471C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 May 2002, Jun Sun wrote:

> By default, swarm will use calibrate_div64_gettimeoffset().  That does
> not work in SMP mode because the two cores have different counter register
> value.  This patch gives swarm its own and accurate gettimeoffset().

 You may consider synchronising the counters as it's done for the i386,
instead.  See synchronize_tsc_ap().  It may be useful for other purposes
as well. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
