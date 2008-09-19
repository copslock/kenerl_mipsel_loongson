Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 12:23:10 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63360 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20310910AbYISLXH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 12:23:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8JBN5Xd015729;
	Fri, 19 Sep 2008 13:23:06 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8JBN4j7015727;
	Fri, 19 Sep 2008 13:23:04 +0200
Date:	Fri, 19 Sep 2008 13:23:04 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
Message-ID: <20080919112304.GB13440@linux-mips.org>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl> <20080917.222350.41199051.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl> <20080918.002705.78730226.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl> <20080918220734.GA19222@linux-mips.org> <Pine.LNX.4.55.0809190112090.22686@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0809190112090.22686@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 19, 2008 at 11:12:22AM +0100, Maciej W. Rozycki wrote:

> > Which is a truely weird operation - but MIPS R2 happens to have a wonderful
> > instruction for this operation, WSBH / DSBH.
> 
>  Ah, finally a justification for the R2 ISA!

As you may recall the real reason is that this instruction was designed
not by engineers but patent law.  Which is f*cked into the head but ...

>  Seriously though, I smell a caller somewhere fails to call csum_fold() on
> the result obtained from csum_partial() where it should, so it would be
> good to fix the bug rather than trying to cover it.  Bryan, would you be
> able to track down the caller?

Not quite.  Internally the IP stack maintains the checksum as a 32-bit
value for performance sake.  It only folds it to 16-bit when it has to.

>  I can see you have done the microoptimisation I had in mind meanwhile --
> thanks for saving me the effort. ;)  There is a delay slot to fill left
> though -- will you take care of it too?

Will do - just couldn't be bothered (too) late last night ...

  Ralf
