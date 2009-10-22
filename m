Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 19:48:21 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:38206 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492947AbZJVRsP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 19:48:15 +0200
Received: by fxm25 with SMTP id 25so9736935fxm.0
        for <multiple recipients>; Thu, 22 Oct 2009 10:48:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ghqiYSTSNIV6GgjmcEYAgLqHh/4z9XFHMHACVBAxpV8=;
        b=ha4iAFWDdO9vm2ShsAJ2up0weHNRUX6w9ojHVbULVTAYvgc1la1jInUiR2T06Bn7XE
         mWW6CDnCX8hijus9NiijQPXUf2jzJwe3TnUmK/67pH7dYGFtGIwW3I77Pa2CBkx6n9wA
         ah2j5x31G+i2c+/Dlyx6x+ED81oek2mVjj3LI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=bUxCEM37rtKuI561Bltzm9Q84WmUK8pWfn747lTfeHjaCIsLp/32CPATKuCLYNoJLl
         I8nHDaLJR2DfbM7AiFlIYKKtx5BZG4MvffjuFIBuiuKprDdFwmBOvkNEtPLrx9wAoOBe
         sZGgSA/r1yuIQ4M/sSO837IXfMv2XbLdYEVN0=
Received: by 10.204.5.194 with SMTP id 2mr1732871bkw.40.1256233689463;
        Thu, 22 Oct 2009 10:48:09 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 28sm2342842fkx.31.2009.10.22.10.48.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 10:48:08 -0700 (PDT)
Subject: Re: [PATCH -v4 4/9] tracing: add static function tracer support
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <1256138686.18347.3039.camel@gandalf.stny.rr.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 23 Oct 2009 01:47:59 +0800
Message-Id: <1256233679.23653.7.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-10-21 at 11:24 -0400, Steven Rostedt wrote:
> On Wed, 2009-10-21 at 22:34 +0800, Wu Zhangjin wrote:
> 
> > +++ b/arch/mips/kernel/mcount.S
> > @@ -0,0 +1,94 @@
> > +/*
> > + * the mips-specific _mcount implementation
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive for
> > + * more details.
> > + *
> > + * Copyright (C) 2009 DSLab, Lanzhou University, China
> > + * Author: Wu Zhangjin <wuzj@lemote.com>
> > + */
> > +
> > +#include <asm/regdef.h>
> > +#include <asm/stackframe.h>
> > +#include <asm/ftrace.h>
> > +
> > +	.text
> > +	.set noreorder
> > +	.set noat
> > +
> > +	/* since there is a "addiu sp,sp,-8" before "jal _mcount" in 32bit */
> > +	.macro RESTORE_SP_FOR_32BIT
> > +#ifdef CONFIG_32BIT
> > +	PTR_ADDIU	sp, 8
> > +#endif
> > +	.endm
> > +
> > +	.macro MCOUNT_SAVE_REGS
> > +	PTR_SUBU	sp, PT_SIZE
> > +	PTR_S	ra, PT_R31(sp)
> > +	PTR_S	AT, PT_R1(sp)
> > +	PTR_S	a0, PT_R4(sp)
> > +	PTR_S	a1, PT_R5(sp)
> > +	PTR_S	a2, PT_R6(sp)
> > +	PTR_S	a3, PT_R7(sp)
> > +#ifdef CONFIG_64BIT
> > +	PTR_S	a4, PT_R8(sp)
> > +	PTR_S	a5, PT_R9(sp)
> > +	PTR_S	a6, PT_R10(sp)
> > +	PTR_S	a7, PT_R11(sp)
> > +#endif
> > +	.endm
> > +
> > +	.macro MCOUNT_RESTORE_REGS
> > +	PTR_L	ra, PT_R31(sp)
> > +	PTR_L	AT, PT_R1(sp)
> > +	PTR_L	a0, PT_R4(sp)
> > +	PTR_L	a1, PT_R5(sp)
> > +	PTR_L	a2, PT_R6(sp)
> > +	PTR_L	a3, PT_R7(sp)
> > +#ifdef CONFIG_64BIT
> > +	PTR_L	a4, PT_R8(sp)
> > +	PTR_L	a5, PT_R9(sp)
> > +	PTR_L	a6, PT_R10(sp)
> > +	PTR_L	a7, PT_R11(sp)
> > +#endif
> > +	PTR_ADDIU	sp, PT_SIZE
> > +.endm
> > +
> > +	.macro MCOUNT_SET_ARGS
> > +	move	a0, ra		/* arg1: next ip, selfaddr */
> > +	move	a1, AT		/* arg2: the caller's next ip, parent */
> > +	PTR_SUBU a0, MCOUNT_INSN_SIZE
> > +	.endm
> > +
> > +	.macro RETURN_BACK
> > +	jr ra
> > +	move ra, AT 
> > +	.endm
> > +
> > +NESTED(_mcount, PT_SIZE, ra)
> > +	RESTORE_SP_FOR_32BIT
> > +	PTR_LA	t0, ftrace_stub
> > +	PTR_L	t1, ftrace_trace_function /* please don't use t1 later, safe? */
> 
> Is t0 and t1 safe for mcount to use? Remember, mcount does not follow
> the dynamics of C function ABI.

So, perhaps we can use the saved registers(a0,a1...) instead.

Regards!
