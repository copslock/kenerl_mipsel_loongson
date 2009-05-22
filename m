Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 14:01:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:63216 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20021612AbZEVNB3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 May 2009 14:01:29 +0100
Received: from localhost (p3039-ipad311funabasi.chiba.ocn.ne.jp [123.217.213.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ADBAA9F17; Fri, 22 May 2009 22:01:23 +0900 (JST)
Date:	Fri, 22 May 2009 22:01:23 +0900 (JST)
Message-Id: <20090522.220123.59650403.anemo@mba.ocn.ne.jp>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, yanh@lemote.com,
	philippe@cowpig.ca, r0bertz@gentoo.org, zhangfx@lemote.com,
	apatard@mandriva.com, loongson-dev@googlegroups.com,
	gnewsense-dev@nongnu.org, hofrat@hofr.at, liujl@lemote.com,
	erwan@thiscow.com
Subject: Re: [loongson-PATCH-v1 22/27] Hibernation Support in mips system
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <817be0da759e19d781e98237cc70efeb33f10a40.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	<817be0da759e19d781e98237cc70efeb33f10a40.1242855716.git.wuzhangjin@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 21 May 2009 06:11:11 +0800, wuzhangjin@gmail.com wrote:
> --- /dev/null
> +++ b/arch/mips/power/cpu.c
> @@ -0,0 +1,51 @@
> +/*
> + * Suspend support specific for mips.
> + *
> + */
> +#include <linux/mm.h>
> +#include <asm/mipsregs.h>
> +#include <asm/page.h>
> +#include <linux/suspend.h>
> +
> +/* References to section boundaries */
> +extern const void __nosave_begin, __nosave_end;
> +
> +static uint32_t saved_status;
> +unsigned long
> +	saved_ra,
> +	saved_sp,
> +	saved_fp,
> +	saved_gp,
> +	saved_s0,
> +	saved_s1,
> +	saved_s2,
> +	saved_s3,
> +	saved_s4,
> +	saved_s5,
> +	saved_s6,
> +	saved_s7,
> +	saved_a0,
> +	saved_a1,
> +	saved_a2,
> +	saved_a3,
> +	saved_v0,
> +	saved_v1;

Instead of enumerating them, I would prefer something like "struct
pt_regs saved_regs" or "unsigned long saved_regs[32]".

> +void save_processor_state(void)
> +{
> +	saved_status = read_c0_status();
> +}

No need to save/restore floating point registers?

> +int pfn_is_nosave(unsigned long pfn)
> +{
> +	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
> +	unsigned long nosave_end_pfn = \
> +		PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;

Unneeded backslash concatenation.
PFN_UP(), PFN_DOWN() can be used.

> +LEAF(swsusp_arch_suspend)
> +	PTR_LA t0, saved_ra
> +	PTR_S ra, (t0)
> +	PTR_LA t0, saved_sp
> +	PTR_S sp, (t0)

The MIPS assembly language accepts symbol for PTR_S, i.e.:

	PTR_S ra, saved_ra

Or, if you converted saved_xxx into struct or array, you can do
something like this:

	PTR_LA t0, saved_regs
	PTR_S ra, PT_R31(t0)
	PTR_S sp, PT_R29(t0)
	...

> +	j swsusp_save
> +	nop

This nop is required?

---
Atsushi Nemoto
