Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 21:37:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:34198 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022522AbXCTVhK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 21:37:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2KLYxcv004551;
	Tue, 20 Mar 2007 21:35:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2KEm9fp012916;
	Tue, 20 Mar 2007 14:48:09 GMT
Date:	Tue, 20 Mar 2007 14:48:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: ZONE_DMA on MIPS
Message-ID: <20070320144809.GA12680@linux-mips.org>
References: <20070319154821.GA31766@linux-mips.org> <20070320.013608.103777227.anemo@mba.ocn.ne.jp> <20070319222031.GB8707@linux-mips.org> <20070320.231013.128618011.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070320.231013.128618011.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 20, 2007 at 11:10:13PM +0900, Atsushi Nemoto wrote:

> On Mon, 19 Mar 2007 22:20:31 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > It's probably reasonable to do something like:
> > 
> > config GENERIC_ISA_DMA
> > 	bool
> > 	select ZONE_DMA
> > 
> > I don't think we should expose such deep technical details to the Kconfig
> > user.
> 
> Thanks.  I'll try.  GENERIC_ISA_DMA_SUPPORT_BROKEN also should select
> ZONE_DMA, right?

That one is actually a more interesting issue.  GENERIC_ISA_DMA_SUPPORT_BROKEN
is needed on Indigo 2 but Indigo 2 has no mmeory other than a little bit
for the exception vectors mapped into the low 16MB.  At this stage nobody
seems to know if the machine actually can support ISA DMA or not.
Anyway, that means that for now it seems better to leave ZONE_DMA
disabled.

But maybe somebody who knows a little more about EISA support on Indigo 2
should comment.

  Ralf
