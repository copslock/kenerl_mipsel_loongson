Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 13:51:45 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:4556 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224924AbUGNMvl>; Wed, 14 Jul 2004 13:51:41 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 873D947AAC; Wed, 14 Jul 2004 14:51:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 73C4947777; Wed, 14 Jul 2004 14:51:35 +0200 (CEST)
Date: Wed, 14 Jul 2004 14:51:35 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
In-Reply-To: <20040714124435.GR2019@lug-owl.de>
Message-ID: <Pine.LNX.4.55.0407141446440.27072@jurand.ds.pg.gda.pl>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org>
 <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
 <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de>
 <000e01c4696f$f65cf4f0$0a9913ac@swift> <Pine.LNX.4.55.0407141058480.4513@jurand.ds.pg.gda.pl>
 <20040714124435.GR2019@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 Jul 2004, Jan-Benedict Glaw wrote:

> While we are at it. I'll have to re-verify that, but my mopd is loosing
> file descriptors if you ^A-F your box during a load.

 Hmm, while I get what you mean, what is "^A-F" specifically?

 Anyway, this may be true -- probably the server is still waiting for
following requests to come.  A timeout might be a good thing to add.  
Unfortunately I don't have time to work on mopd ATM.  It would be good to
do a serious rewrite and I plan to do that in the future.  No established 
plan, though.

 Another problem which is already known is mopd dying when one of
interfaces it's listening on goes down.

  Maciej
