Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2004 17:03:56 +0100 (BST)
Received: from p508B68D3.dip.t-dialin.net ([IPv6:::ffff:80.139.104.211]:55321
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225555AbUGAQDw>; Thu, 1 Jul 2004 17:03:52 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i61DxJ5Z006983;
	Thu, 1 Jul 2004 15:59:19 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i61DxJx9006982;
	Thu, 1 Jul 2004 15:59:19 +0200
Date: Thu, 1 Jul 2004 15:59:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 pci_dma_sync_sg fix
Message-ID: <20040701135919.GA6906@linux-mips.org>
References: <20040701.222120.41626500.anemo@mba.ocn.ne.jp> <20040701132240.GA6219@linux-mips.org> <20040701.224535.71082878.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701.224535.71082878.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 01, 2004 at 10:45:35PM +0900, Atsushi Nemoto wrote:

> >>>>> On Thu, 1 Jul 2004 15:22:40 +0200, Ralf Baechle <ralf@linux-mips.org> said:
> 
> ralf> Leave the #ifdef stuff there - or otherwise gcc might optimize
> ralf> this into empty loops ...
> 
> The loop contains paranoid out_of_line_bug, so it never be optimized
> to empty.

Indeed and I think that's a bit of overkill.  I've never seen these
assertions catch any bugs - and 2.4 isn't exactly new anymore.  Anyway,
even if the loop was empty gcc would not eleminate it.

  Ralf
