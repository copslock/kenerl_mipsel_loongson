Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2009 17:40:43 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6057 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494309AbZLNQkh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Dec 2009 17:40:37 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b266a770000>; Mon, 14 Dec 2009 08:40:23 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 14 Dec 2009 08:40:23 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 14 Dec 2009 08:40:23 -0800
Message-ID: <4B266A75.6020809@caviumnetworks.com>
Date:   Mon, 14 Dec 2009 08:40:21 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Florian Fainelli <ffainelli@freebox.fr>
CC:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        ralf@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: add readl/write_be
References: <200912121757.56365.ffainelli@freebox.fr>
In-Reply-To: <200912121757.56365.ffainelli@freebox.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2009 16:40:23.0403 (UTC) FILETIME=[21BAF3B0:01CA7CDC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli wrote:
> MIPS currently lacks the readl_be and writel_be accessors
> which are required by BCM63xx for OHCI and EHCI support.
> Let's define them globally for MIPS. This also fixes the
> compilation of the bcm63xx defconfig against USB.
> 
> Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
> ---
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 436878e..65cb4e4 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -447,6 +447,9 @@ __BUILDIO(q, u64)
>  #define readl_relaxed			readl
>  #define readq_relaxed			readq
>  
> +#define readl_be(addr)			__raw_readl((__force unsigned *)addr)
> +#define writel_be(val, addr)		__raw_writel(val, (__force unsigned *)addr)
> +


Without addressing the need for the patch, as a technical matter, the 
macro parameters should probably be protected by parenthesis.  I.E.:

#define readl_be(addr)			__raw_readl((__force unsigned *)(addr))
#define writel_be(val, addr)		__raw_writel((val), (__force unsigned 
*)(addr))
