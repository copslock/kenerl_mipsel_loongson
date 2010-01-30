Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 16:58:30 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:42149 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492977Ab0A3P6Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Jan 2010 16:58:25 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
        by smtp6-g21.free.fr (Postfix) with ESMTP id 83E64E080E9;
        Sat, 30 Jan 2010 16:58:17 +0100 (CET)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
        by smtp6-g21.free.fr (Postfix) with ESMTP id 7A50DE08128;
        Sat, 30 Jan 2010 16:58:15 +0100 (CET)
Subject: Re: [PATCH 3/3] MIPS: deal with larger physical offsets
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <201001281522.37939.florian@openwrt.org>
References: <201001281522.37939.florian@openwrt.org>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Organization: Freebox
Date:   Sat, 30 Jan 2010 16:58:15 +0100
Message-ID: <1264867095.32192.11.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19448


On Thu, 2010-01-28 at 15:22 +0100, Florian Fainelli wrote:

Hi,

>  	if (n == 0 && cpu_has_divec) {
> -		*(u32 *)(ebase + 0x200) = 0x08000000 |
> -					  (0x03ffffff & (handler >> 2));
> -		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
> +		unsigned long jump_mask = ~((1 << 28) - 1);
> +		u32 *buf = (u32 *)(ebase + 0x200);
> +		unsigned int k0 = 26;
> +		if((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
> +			uasm_i_j(&buf, handler & jump_mask);
> +			uasm_i_nop(&buf);

This results in "Micro-assembler field overflow" on my board.

jump_mask is 0xf0000000, so I guess you meant:

-                       uasm_i_j(&buf, handler & jump_mask);
+                       uasm_i_j(&buf, handler & ~jump_mask);


And by the way, shouldn't jump_mask be 0xfc000000 ?

-- 
Maxime
