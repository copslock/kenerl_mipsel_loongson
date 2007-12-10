Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 15:29:41 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:30140 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024543AbXLJP3d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 15:29:33 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 7FDDA400AB;
	Mon, 10 Dec 2007 16:29:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id rT9zpoWVi3QP; Mon, 10 Dec 2007 16:28:58 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0E8CC4008C;
	Mon, 10 Dec 2007 16:28:58 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lBAFT2en028211;
	Mon, 10 Dec 2007 16:29:02 +0100
Date:	Mon, 10 Dec 2007 15:28:52 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: SiByte 1480 & Branch Likely instructions?
In-Reply-To: <20071209051450.GA18181@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0712101522100.1177@blysk.ds.pg.gda.pl>
References: <DDFD17CC94A9BD49A82147DDF7D545C5590CF0@exchange.ZeugmaSystems.local>
 <20071209051450.GA18181@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/5077/Mon Dec 10 14:59:40 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 9 Dec 2007, Ralf Baechle wrote:

> > Not really a kernel-related question. I've discovered that GCC 4.1.1
> > (which I'm not using for kernel compiling, but user space) generates
> > branch likely instructions by default, even though the documentation
> > says that their use is off by default for MIPS32 and MIPS64, because
> > they are considered deprecated. They are documented as obsolete for the
> > Broadcom chips I am working with.
> 
> Microarchitecture guys love to hate branch likely.  But the deprecation is
> a dream.  Binary compatibility will always require those instructions to
> continue to exist so the genie is out of the bottle and so I feel very
> certain to predict that a future MIPS 3 specification will contain branch
> likely.

 We have been there before -- binary compatibility does not preclude 
emulation.  And I do not mean keeping the MIPS I toys (as they might be 
seen these days) running, but serious products deployed commercially, like 
newer VAX implementations that kept full binary compatibility with their 
predecessors in the area of the some of the more arcane instructions only 
by means of emulating them in the OS.

  Maciej
