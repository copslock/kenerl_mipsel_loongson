Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 13:36:24 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49909 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904029Ab1KQMgU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 13:36:20 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAHCaB6K012068;
        Thu, 17 Nov 2011 12:36:11 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAHCa9mm012053;
        Thu, 17 Nov 2011 12:36:09 GMT
Date:   Thu, 17 Nov 2011 12:36:09 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     keguang.zhang@gmail.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        zhzhl555@gmail.com, peppe.cavallaro@st.com, wuzhangjin@gmail.com,
        r0bertz@gentoo.org
Subject: Re: [PATCH V3 2/5] MIPS: Add board support for Loongson1B
Message-ID: <20111117123609.GA16467@linux-mips.org>
References: <1321522748-21391-1-git-send-email-keguang.zhang@gmail.com>
 <1321522748-21391-2-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321522748-21391-2-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14431

On Thu, Nov 17, 2011 at 05:39:05PM +0800, keguang.zhang@gmail.com wrote:

> diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h b/arch/mips/include/asm/mach-loongson1/regs-clk.h
> new file mode 100644
> index 0000000..4f488c3
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson1/regs-clk.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * Loongson1 Clock Register Definitions.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __ASM_MACH_LOONGSON1_REGS_CLK_H
> +#define __ASM_MACH_LOONGSON1_REGS_CLK_H
> +
> +#define LS1X_CLK_REG(x)		(ioremap(LS1X_CLK_BASE + (x), 4))

Uhh...  Don't make assumptions on the MIPS implementation.  Normally
ioremap() consumes some virtual address space and memory for each
invocation.  And eventually io mappings should be freed again with
iounmap.

> +static void ls1x_halt(void)
> +{
> +	pr_notice("\n\n** You can safely turn off the power now **\n\n");

This is so Windows 95 ;-)

Please remove this message.  Messages to a user should be printed by
userspace, most likely an init script.

  Ralf
