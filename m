Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 16:00:36 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:52397 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20036822AbXJOPA1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 16:00:27 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id C555E400E0;
	Mon, 15 Oct 2007 16:59:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id fCC3gg5go2ad; Mon, 15 Oct 2007 16:59:53 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 2787340085;
	Mon, 15 Oct 2007 16:59:53 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9FExu6G005827;
	Mon, 15 Oct 2007 16:59:56 +0200
Date:	Mon, 15 Oct 2007 15:59:51 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Richard Sandiford <rsandifo@nildram.co.uk>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>,
	David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Gcc 4.2.2 broken for kernel builds
In-Reply-To: <87d4vj9tk7.fsf@firetop.home>
Message-ID: <Pine.LNX.4.64N.0710151553200.16262@blysk.ds.pg.gda.pl>
References: <20071012172254.GA10835@linux-mips.org> <470FB386.6080709@avtrex.com>
 <20071012175317.GB1110@linux-mips.org> <470FBE08.8090004@avtrex.com>
 <20071012184909.GA4832@linux-mips.org> <20071012191446.GK3163@deprecation.cyrius.com>
 <20071012191645.GB4832@linux-mips.org> <87d4vj9tk7.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4540/Sun Oct 14 03:43:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 13 Oct 2007, Richard Sandiford wrote:

> FWIW, I've added some notes about the underlying cause.  I think this
> could in principle happen with any gcc release.

 It has been seen with GCC 3.4 and IIRC SDE has a hack in binutils to 
disable this error as a workaround.  I guess the problem has always been 
there since explicit relocs were added to GCC; it is just it hardly ever 
happens.

  Maciej
