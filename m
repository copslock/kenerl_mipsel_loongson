Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 16:10:31 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:34928 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492168Ab0A3PK1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Jan 2010 16:10:27 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
        by smtp6-g21.free.fr (Postfix) with ESMTP id 9E79FE08137;
        Sat, 30 Jan 2010 16:10:21 +0100 (CET)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
        by smtp6-g21.free.fr (Postfix) with ESMTP id B03A6E08033;
        Sat, 30 Jan 2010 16:10:18 +0100 (CET)
Subject: Re: [PATCH] powertv: Fix support for timer interrupts when using
 >64 external IRQs
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20091222014922.GA30164@dvomlehn-lnx2.corp.sa.net>
References: <20091222014922.GA30164@dvomlehn-lnx2.corp.sa.net>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Organization: Freebox
Date:   Sat, 30 Jan 2010 16:10:18 +0100
Message-ID: <1264864218.32192.1.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19419


On Mon, 2009-12-21 at 17:49 -0800, David VomLehn wrote:

Hi,

>  	if (cpu_has_mips_r2) {
> -		cp0_compare_irq = (read_c0_intctl() >> 29) & 7;
> -		cp0_perfcount_irq = (read_c0_intctl() >> 26) & 7;
> +		cp0_compare_irq_shift = CAUSEB_TI - CAUSEB_IP;
> +		cp0_compare_irq = (read_c0_intctl() >> INTCTLB_IPTI) & 7;
> +		cp0_perfcount_irq = (read_c0_intctl() >> INTCTLB_IPPCI) & 7;

This patch breaks at least bcm63xx, because cp0_compare_irq_shift is not
initialized when cpu_has_mips_r2 is false.

Regards,

-- 
Maxime
