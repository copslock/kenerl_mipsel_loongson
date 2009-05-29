Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 07:12:22 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:47002 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021820AbZE2GMQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 07:12:16 +0100
Received: by pxi17 with SMTP id 17so5306615pxi.22
        for <multiple recipients>; Thu, 28 May 2009 23:12:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=uVwIwPhLLcTgSbYAbdgKBcK72kLTD3oh6/k9VmG3URI=;
        b=FJGgtPYb1Gj+n2RwJ45R2DsePasrUIaXE11vgwJieIMPSBPm/Yjn15E0V0LSOJIC48
         VF6vvJROVpAhstDgtZgyelOxUgxqZRb+lHq4st78JdyZZHg8oKy1hS7OlOGq1OTFM5VY
         SxYTkHEcXi0mkDkc14Oe+kX1r8pw3zmVcTEeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=mssU9x8yxRLTg1Knqu7RlZiCFov4DgMT2CTPJA9m1DIZDmBw1Ze6N1qdx/JH6HAcMu
         3+uUff5uVX34AMFrRH49lWuQ78UIv7+g8zK1jZKCXTa0fTrNDmDE6Y1VqF9Sftprc0+N
         kkbFGNltI3G3Ja9IKb1kTlxgVDSLQBZGG9lII=
Received: by 10.115.110.15 with SMTP id n15mr4396487wam.16.1243577528421;
        Thu, 28 May 2009 23:12:08 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id l28sm1306864waf.19.2009.05.28.23.12.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 23:12:07 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] mips static function tracer support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <alpine.DEB.2.00.0905281713260.11238@gandalf.stny.rr.com>
References: <cover.1243543471.git.wuzj@lemote.com>
	 <4c501e9dec76ac317021c9d7dd62a8a5ed13812c.1243543471.git.wuzj@lemote.com>
	 <alpine.DEB.2.00.0905281713260.11238@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 29 May 2009 14:11:53 +0800
Message-Id: <1243577513.12679.0.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-05-28 at 21:13 -0400, Steven Rostedt wrote:
> 
> On Fri, 29 May 2009, wuzhangjin@gmail.com wrote:
> 
> > From: Wu Zhangjin <wuzj@lemote.com>
> > 
> > if -pg of gcc is enabled. a calling to _mcount will be inserted to each
> > kernel function. so, there is a possibility to trace the functions in
> > _mcount.
> > 
> > here is the implementation of mips specific _mcount for static function
> > tracer.
> > 
> > -ffunction-sections option not works with -pg, so disable it if enables
> > FUNCTION_TRACER.
> > 
> > Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
> > ---
> >  arch/mips/Kconfig              |    2 +
> >  arch/mips/Makefile             |    2 +
> >  arch/mips/include/asm/ftrace.h |   25 ++++++++++-
> >  arch/mips/kernel/Makefile      |    8 +++
> >  arch/mips/kernel/mcount.S      |   98 ++++++++++++++++++++++++++++++++++++++++
> >  arch/mips/kernel/mips_ksyms.c  |    5 ++
> >  6 files changed, 139 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/mips/kernel/mcount.S
> > 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 09b1287..d5c01ca 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -4,6 +4,8 @@ config MIPS
> >  	select HAVE_IDE
> >  	select HAVE_OPROFILE
> >  	select HAVE_ARCH_KGDB
> > +	select HAVE_FUNCTION_TRACER
> > +	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
> >  	# Horrible source of confusion.  Die, die, die ...
> >  	select EMBEDDED
> >  	select RTC_LIB
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index c4cae9e..f86fb15 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -48,7 +48,9 @@ ifneq ($(SUBARCH),$(ARCH))
> >    endif
> >  endif
> >  
> > +ifndef CONFIG_FUNCTION_TRACER
> >  cflags-y := -ffunction-sections
> > +endif
> >  cflags-y += $(call cc-option, -mno-check-zero-division)
> >  
> >  ifdef CONFIG_32BIT
> > diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
> > index 40a8c17..5f8ebcf 100644
> > --- a/arch/mips/include/asm/ftrace.h
> > +++ b/arch/mips/include/asm/ftrace.h
> > @@ -1 +1,24 @@
> > -/* empty */
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive for
> > + * more details.
> > + *
> > + * Copyright (C) 2009 DSLab, Lanzhou University, China
> > + * Author: Wu Zhangjin <wuzj@lemote.com>
> > + */
> > +
> > +#ifndef _ASM_MIPS_FTRACE_H
> > +#define _ASM_MIPS_FTRACE_H
> > +
> > +#ifdef CONFIG_FUNCTION_TRACER
> > +
> > +#define MCOUNT_ADDR ((unsigned long)(_mcount))
> > +#define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
> > +
> > +#ifndef __ASSEMBLY__
> > +extern void _mcount(void);
> > +#define mcount _mcount
> > +
> > +#endif /* __ASSEMBLY__ */
> > +#endif /* CONFIG_FUNCTION_TRACER */
> > +#endif /* _ASM_MIPS_FTRACE_H */
> > diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> > index e961221..d167dde 100644
> > --- a/arch/mips/kernel/Makefile
> > +++ b/arch/mips/kernel/Makefile
> > @@ -8,6 +8,12 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
> >  		   ptrace.o reset.o setup.o signal.o syscall.o \
> >  		   time.o topology.o traps.o unaligned.o watch.o
> >  
> > +ifdef CONFIG_FUNCTION_TRACER
> > +# Do not profile debug and lowlevel utilities
> > +CFLAGS_REMOVE_mcount.o = -pg
> 
> mcount.S is an assembly file, the above is for C files. So it is not 
> needed.

Removed, thanks!

> 
> -- Steve
> 
> > +CFLAGS_REMOVE_early_printk.o = -pg
> > +endif
> > +
> >  obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
> >  obj-$(CONFIG_CEVT_R4K_LIB)	+= cevt-r4k.o
> >  obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
> > @@ -24,6 +30,8 @@ obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
> >  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
> >  obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
> >  
> > +obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
> > +
> >  obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
> >  obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
> >  obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
> > diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> > new file mode 100644
> > index 0000000..268724e
> > --- /dev/null
