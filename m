Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2005 22:29:10 +0000 (GMT)
Received: from p508B6A4B.dip.t-dialin.net ([IPv6:::ffff:80.139.106.75]:55878
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225275AbVAEW3F>; Wed, 5 Jan 2005 22:29:05 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j05MSnMt026192;
	Wed, 5 Jan 2005 23:28:49 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j05MSmZv026191;
	Wed, 5 Jan 2005 23:28:48 +0100
Date: Wed, 5 Jan 2005 23:28:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: James Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/4] mips: remove cli()/sti() from arch/mips/*
Message-ID: <20050105222848.GA25921@linux-mips.org>
References: <20050104223327.21889.11863.64754@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104223327.21889.11863.64754@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 04, 2005 at 04:33:07PM -0600, James Nelson wrote:

> This series of patches is to remove the last cli()/sti() function calls in arch/mips.
> 
> These are the only instances in active code that grep could find.
> 
>  gt64120/ev64120/irq.c                            |    2 +-
>  jmr3927/rbhma3100/setup.c                        |    2 +-
>  tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c   |    2 +-
>  tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |    4 ++--

The usual suspects for bitrot ...

Thanks, all four patches applied.

  Ralf
