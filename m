Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 15:05:15 +0100 (BST)
Received: from p508B5C3F.dip.t-dialin.net ([IPv6:::ffff:80.139.92.63]:38498
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225794AbUEKOFP>; Tue, 11 May 2004 15:05:15 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4BE59xT006683;
	Tue, 11 May 2004 16:05:09 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4BE57ki006682;
	Tue, 11 May 2004 16:05:07 +0200
Date: Tue, 11 May 2004 16:05:07 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: geert@linux-m68k.org, jsun@mvista.com, linux-mips@linux-mips.org
Subject: Re: semaphore woes in 2.6, 32bit
Message-ID: <20040511140507.GA32577@linux-mips.org>
References: <20040509164835.GA28011@linux-mips.org> <20040510.222845.78701815.anemo@mba.ocn.ne.jp> <20040510140606.GA9312@linux-mips.org> <20040511.225305.55510293.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511.225305.55510293.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 11, 2004 at 10:53:05PM +0900, Atsushi Nemoto wrote:

> >> I see.  Thank you for pointing out it.  I must learn 2.6 DMA API
> >> quickly ...
> 
> ralf> This also applies to the 2.4 PCI DMA API.
> 
> But 2.4 PCI DMA API does not have dma_get_cache_alignment() (or
> equivalent), or am I missing something?

No, you don't; that was a problem in the 2.4 DMA API which got fixed
in 2.5.  For 2.4 using L1_CACHE_BYTES from <asm/cache.h> is a reasonable
alternative.

  Ralf
