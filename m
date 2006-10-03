Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 10:45:32 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40972 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038330AbWJCJp2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 10:45:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1530CF61A3;
	Tue,  3 Oct 2006 11:45:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VtHde4pR2Z0a; Tue,  3 Oct 2006 11:45:23 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B5308F619C;
	Tue,  3 Oct 2006 11:45:23 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k939jRRq012181;
	Tue, 3 Oct 2006 11:45:27 +0200
Date:	Tue, 3 Oct 2006 10:45:24 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] remove Momentum / PMC-Sierra Jaguar ATX evaluation board
In-Reply-To: <200610030144.k931i4TD002658@mbox32.po.2iij.net>
Message-ID: <Pine.LNX.4.64N.0610031033280.4642@blysk.ds.pg.gda.pl>
References: <20061002231432.733374f7.yoichi_yuasa@tripeaks.co.jp>
 <20061002151800.GA25180@linux-mips.org> <200610030144.k931i4TD002658@mbox32.po.2iij.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1982/Tue Oct  3 07:04:49 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 3 Oct 2006, Yoichi Yuasa wrote:

> How about MIPS Technologies boards on the list?

 Both configurations affected build just fine now.

 The Atlas board needs an update for its serial driver that I have to send 
through RMK (which I'll try to do shortly) and the driver for the onboard 
53c810 requires the missing iomap support.  Otherwise it works fine with 
core cards using the Galileo system controller (others may have issues, 
which may or may not eventually be resolved).

 The SEAD board requires an update to its interrupt handler, which I'll 
code as soon as I find a couple of minutes to spare.  It's nothing 
complicated, but I want to test it a little bit before committing.  I need 
to find a useful way of running Linux on it though. ;-)

  Maciej
