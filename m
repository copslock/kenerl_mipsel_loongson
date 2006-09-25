Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 17:11:43 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:28426 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038557AbWIYQLj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 17:11:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8B189F6947;
	Mon, 25 Sep 2006 18:11:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C05AQNw403lS; Mon, 25 Sep 2006 18:11:35 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 40DBBF6004;
	Mon, 25 Sep 2006 18:11:35 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k8PGBg3m009627;
	Mon, 25 Sep 2006 18:11:42 +0200
Date:	Mon, 25 Sep 2006 17:11:36 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	william_lei@ali.com.tw
cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: How to emulate lw/sw instruction by lb/sb instruction
In-Reply-To: <OFCDEA2C7E.BF7FD296-ON482571F4.0039233C-482571F4.003A3A12@LocalDomain>
Message-ID: <Pine.LNX.4.64N.0609251709340.20016@blysk.ds.pg.gda.pl>
References: <OFCDEA2C7E.BF7FD296-ON482571F4.0039233C-482571F4.003A3A12@LocalDomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1942/Mon Sep 25 11:36:21 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 25 Sep 2006, william_lei@ali.com.tw wrote:

>       Because there are some aligned instruction will load/store from/to
> unaligned base address in some module,such as "lw t0,56(sp)  ##sp is odd
> address"

 Hmm, the stack at an odd address -- somebody must be in the hard joking 
mood...

  Maciej
