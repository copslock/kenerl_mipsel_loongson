Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5O7FZnC020328
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 00:15:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5O7FZ1c020327
	for linux-mips-outgoing; Mon, 24 Jun 2002 00:15:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5O7FTnC020323
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 00:15:30 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA22700;
	Mon, 24 Jun 2002 09:19:16 +0200 (MET DST)
Date: Mon, 24 Jun 2002 09:19:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: DECstation
In-Reply-To: <20020622080045.GT24903@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020624091357.22509A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 22 Jun 2002, Jan-Benedict Glaw wrote:

> Well... Some keys are functional, some are not, and some are better to
> never press... I've tried to understand how X handles the keyboard one
> evening, but I badly failed to understand all those mappings and layouts
> and so on:-(

 A fix is on my to-do list -- hopefully to be done just after the current
task.  There is a long-standing bug in the generic keyboard handling code. 
After fixing it and then the LK driver (which cannot be fixed now because
of the bug), you'll be able to use LK mappings included in the X11
distribution.  It was discussed here earlier this year. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
