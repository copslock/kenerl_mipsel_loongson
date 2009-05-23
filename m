Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2009 09:07:15 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:40742 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021991AbZEWIHI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 May 2009 09:07:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 597BE340BD;
	Sat, 23 May 2009 16:02:06 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ah5YhwIcl85E; Sat, 23 May 2009 16:01:51 +0800 (CST)
Received: from [172.16.2.17] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 51C88340BC;
	Sat, 23 May 2009 16:01:51 +0800 (CST)
Subject: Re: [loongson-PATCH-v1 22/27] Hibernation Support in mips system
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, philippe@cowpig.ca, r0bertz@gentoo.org,
	zhangfx@lemote.com, apatard@mandriva.com,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	hofrat@hofr.at, liujl@lemote.com, erwan@thiscow.com
In-Reply-To: <20090522.220123.59650403.anemo@mba.ocn.ne.jp>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	 <817be0da759e19d781e98237cc70efeb33f10a40.1242855716.git.wuzhangjin@gmail.com>
	 <20090522.220123.59650403.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Date:	Sat, 23 May 2009 16:06:43 +0800
Message-Id: <1243066003.8509.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-22五的 22:01 +0900，Atsushi Nemoto写道：
> On Thu, 21 May 2009 06:11:11 +0800, wuzhangjin@gmail.com wrote:
> > --- /dev/null
> > +++ b/arch/mips/power/cpu.c
> > @@ -0,0 +1,51 @@
> > +/*
> > + * Suspend support specific for mips.
> > + *
> > + */
> > +#include <linux/mm.h>
> > +#include <asm/mipsregs.h>
> > +#include <asm/page.h>
> > +#include <linux/suspend.h>
> > +
> > +/* References to section boundaries */
> > +extern const void __nosave_begin, __nosave_end;
> > +
> > +static uint32_t saved_status;
> > +unsigned long
> > +	saved_ra,
> > +	saved_sp,
> > +	saved_fp,
> > +	saved_gp,
> > +	saved_s0,
> > +	saved_s1,
> > +	saved_s2,
> > +	saved_s3,
> > +	saved_s4,
> > +	saved_s5,
> > +	saved_s6,
> > +	saved_s7,
> > +	saved_a0,
> > +	saved_a1,
> > +	saved_a2,
> > +	saved_a3,
> > +	saved_v0,
> > +	saved_v1;
> 
> Instead of enumerating them, I would prefer something like "struct
> pt_regs saved_regs" or "unsigned long saved_regs[32]".
This implementation is referencing the x86 platform. 
Not all the 32 reigsters are needed to save. 
Maybe the whole registers needed to save can still be reduced.
> 
> > +void save_processor_state(void)
> > +{
> > +	saved_status = read_c0_status();
> > +}
> 
> No need to save/restore floating point registers?
the floating point registers are not used by kernel, for user part, they
are already saved while entering into kernel mode.
> 
> > +int pfn_is_nosave(unsigned long pfn)
> > +{
> > +	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
> > +	unsigned long nosave_end_pfn = \
> > +		PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
> 
> Unneeded backslash concatenation.
> PFN_UP(), PFN_DOWN() can be used.
> 
> > +LEAF(swsusp_arch_suspend)
> > +	PTR_LA t0, saved_ra
> > +	PTR_S ra, (t0)
> > +	PTR_LA t0, saved_sp
> > +	PTR_S sp, (t0)
> 
> The MIPS assembly language accepts symbol for PTR_S, i.e.:
> 
> 	PTR_S ra, saved_ra
> 
> Or, if you converted saved_xxx into struct or array, you can do
> something like this:
> 
> 	PTR_LA t0, saved_regs
> 	PTR_S ra, PT_R31(t0)
> 	PTR_S sp, PT_R29(t0)

> 	...
> 
> > +	j swsusp_save
> > +	nop
> 
> This nop is required?
> 
> ---
> Atsushi Nemoto
> 
