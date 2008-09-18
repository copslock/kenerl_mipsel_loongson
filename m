Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 23:07:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:3989 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28773946AbYIRWHj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2008 23:07:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8IM7bwk020020;
	Fri, 19 Sep 2008 00:07:37 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8IM7ZSq020018;
	Fri, 19 Sep 2008 00:07:35 +0200
Date:	Fri, 19 Sep 2008 00:07:35 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
Message-ID: <20080918220734.GA19222@linux-mips.org>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl> <20080917.222350.41199051.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl> <20080918.002705.78730226.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 17, 2008 at 07:21:23PM +0100, Maciej W. Rozycki wrote:

> > >  Hmm, what's the purpose of doing the fold in csum_partial() then?
> > 
> > Well, maybe odd-byte handling requires 16-bit holded values?
> 
>  It should be enough to swap odd and even bytes in the word in the
> unaligned path.  Though perhaps extra code to do masking would make it no
> shorter/faster than what we have now; however the aligned path would
> benefit.  Hmm...

Which is a truely weird operation - but MIPS R2 happens to have a wonderful
instruction for this operation, WSBH / DSBH.

  Ralf
