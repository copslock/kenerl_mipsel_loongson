Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Dec 2009 20:46:28 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:37987 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493318AbZLLTqY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Dec 2009 20:46:24 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1NJXv2-0003Mw-00; Sat, 12 Dec 2009 20:46:20 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id A157FC2A89; Sat, 12 Dec 2009 20:31:14 +0100 (CET)
Date:   Sat, 12 Dec 2009 20:31:14 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <ffainelli@freebox.fr>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        ralf@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: add readl/write_be
Message-ID: <20091212193114.GA11103@alpha.franken.de>
References: <200912121757.56365.ffainelli@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200912121757.56365.ffainelli@freebox.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sat, Dec 12, 2009 at 05:57:56PM +0100, Florian Fainelli wrote:
> +#define readl_be(addr)			__raw_readl((__force unsigned *)addr)
> +#define writel_be(val, addr)		__raw_writel(val, (__force unsigned *)addr)

looks broken for little endian machines. __raw_XXX doesn't do any swapping,
so IMHO the correct thing would be to use be32_to_cpu/cpu_to_be32.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
