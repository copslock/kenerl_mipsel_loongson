Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g38I3J8d031996
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Apr 2002 11:03:19 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g38I3Jsm031995
	for linux-mips-outgoing; Mon, 8 Apr 2002 11:03:19 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g38I3E8d031991
	for <linux-mips@oss.sgi.com>; Mon, 8 Apr 2002 11:03:15 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA10414;
	Mon, 8 Apr 2002 20:03:45 +0200 (MET DST)
Date: Mon, 8 Apr 2002 20:03:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: New style IRQs for DECstation
In-Reply-To: <3CB1D7E6.5010804@mvista.com>
Message-ID: <Pine.GSO.3.96.1020408195036.26107N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 8 Apr 2002, Jun Sun wrote:

> What is the intention of introducing MIPS_CPU_FPUEX?  It seems an overkill if 
> it is just needed by DecStation.  How many CPUs really need this?

 It's needed by any system using a (logically) external FPU.  If set it
means there is no need to install a special FPU exception handler using a
general-purpose interrupt line.  It's a generic flag. 

 Even if it's only of limited use now, it is not an excuse for not writing
clean code.  I'm afraid the current mess within the MIPS port is a result
of people trying to think locally and I'm trying to avoid it.  Are there
any trade-offs of this flags you see and I don't?  I'm willing to change
the code if there really are. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
