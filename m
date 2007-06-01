Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 16:11:25 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:62472 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20025621AbXFAPLY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Jun 2007 16:11:24 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A180BE1CF3;
	Fri,  1 Jun 2007 17:11:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AS+VNiW5PBi0; Fri,  1 Jun 2007 17:11:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 42730E1C82;
	Fri,  1 Jun 2007 17:11:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l51FBNpO002999;
	Fri, 1 Jun 2007 17:11:23 +0200
Date:	Fri, 1 Jun 2007 16:11:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc:	Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] zs: Move to the serial subsystem
In-Reply-To: <20070601140331.GH2649@lug-owl.de>
Message-ID: <Pine.LNX.4.64N.0706011607010.26841@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl>
 <20070530165842.GL29894@sith.mimuw.edu.pl> <Pine.LNX.4.64N.0705301802570.27697@blysk.ds.pg.gda.pl>
 <20070601140331.GH2649@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.2/3336/Fri Jun  1 13:28:33 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jun 2007, Jan-Benedict Glaw wrote:

> IIRC the serial port needs to register a serio device, set correct
> baud/cstopb/... settings and set VSXXXAA/LKKBD identity on the two
> serio ports. I *hope* the rest happens automatically then. (Another
> way would be to look into how the Sun guys get their keyboards
> up'n'running...)

 No it does not happen.  The default serial line discipline is always 
N_TTY.  The Sun guys got their keyboards running by the way of a hack that 
I am currently actively refusing being dragged into.  The serial driver 
itself has no business with CONFIG_SERIO at all.

  Maciej
