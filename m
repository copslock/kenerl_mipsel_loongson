Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:24:08 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3078 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022453AbXFDPYG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:24:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DC3A8E1CF5;
	Mon,  4 Jun 2007 17:23:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zldui7yqERii; Mon,  4 Jun 2007 17:23:21 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6790AE1C69;
	Mon,  4 Jun 2007 17:23:21 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l54FNXx7005550;
	Mon, 4 Jun 2007 17:23:33 +0200
Date:	Mon, 4 Jun 2007 16:23:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Unify watch.S and remove arch/mips/lib-{32,64}
In-Reply-To: <20070604151048.GA30128@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0706041620500.863@blysk.ds.pg.gda.pl>
References: <20070605.000239.31638706.anemo@mba.ocn.ne.jp>
 <20070604151048.GA30128@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3348/Mon Jun  4 12:51:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 4 Jun 2007, Ralf Baechle wrote:

> I think we can simply drop the entire watchpoint support.  This was
> only ever working on R4000/R4400 and even there only somewhat useful
> for kernel debugging.  So if we ever use watchpoint support I think
> something needs to be developed from scratch.

 A long-term plan is to make them available to userland through ptrace() 
in a uniform way covering MIPS32/64 watchpoints as well for gdb and 
suchlike.

  Maciej
