Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 14:40:14 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.203]:27876 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133421AbWA0Ojz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 14:39:55 +0000
Received: by zproxy.gmail.com with SMTP id l8so624629nzf
        for <linux-mips@linux-mips.org>; Fri, 27 Jan 2006 06:44:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+JrN3rsEOTHebNHvEYPxKDodU7qyEivw73v39yTd88+MK9vAORXu3LScX5U5jWLubr00Xey+UT+HfiOJwe04nkX9R2RNIIDAoc3rvguu6Dcm416F9YcH4nLsXl9eE7jS+khO0pWS7XX1H2C2b+p0tMmtGjQPOMZsbL8cP68TFo=
Received: by 10.36.109.13 with SMTP id h13mr2429303nzc;
        Fri, 27 Jan 2006 06:44:31 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Fri, 27 Jan 2006 06:44:31 -0800 (PST)
Message-ID: <cda58cb80601270644sfff5c43i@mail.gmail.com>
Date:	Fri, 27 Jan 2006 15:44:31 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <001d01c62340$be267bb0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <43D8F000.9010106@mips.com>
	 <cda58cb80601260831i61167787g@mail.gmail.com>
	 <43D8FF16.40107@mips.com>
	 <cda58cb80601261002w6eb02249k@mail.gmail.com>
	 <43D93025.9040800@mips.com>
	 <cda58cb80601270103t1419117cq@mail.gmail.com>
	 <000b01c6232a$5ea81470$10eca8c0@grendel>
	 <cda58cb80601270245g6273ce04k@mail.gmail.com>
	 <001d01c62340$be267bb0$10eca8c0@grendel>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/27, Kevin D. Kissell <kevink@mips.com>:
> > > Configuration hacks that are specific to a single core create cruft and
> > > maintenence problems.  As I said yesterday, I think we'd be much better
> > > off to have a CONFIG_CPU_MIPS_SMALL or some such option
> > > that could cause -Os to be used, allow branch-likelies, etc. The optimizations
> > > under discussion aren't at all specific to the 4KSd,
> >
> > no some are. As we said previously:
> >
> >         1/ sizeof(vmlinux-mips32r2-Os) > sizeof(vmlinux-4ksd-Os)
> >         2/ with -march=4ksd can do (slightly) better optimizations.
>
> This is very possibly due to the compiler knowing about the SmartMIPS
> scaled, indexed load instructions, which were added to improve virtual
> machine performance, but which also save on address calculation instructions.
> If -march=mips32r2 combined with -msmartmips and -Os don't produce
> pretty much the same result as -march=4ksd, I'd be interested in knowing
> why.

well, Nigel gave us some answers here, no ? I'm not sure it's a good
idea to use -march=mips32r2 whatever the mips32r2 cpu is used. Even if
the gain is small, we should use a specific cpu description. If the
configuration makes it hard, it should be reworked, isn't it ?

> Regardless, if this is what's going on, there really is no other core
> in production today that will run that code.  But that doesn't mean
> that there won't be others in the future.
>
> All I'm really trying to do here is to get away from core-specific config
> cruft.  If the best result under-the-hood for 4KSd is obtained by using
> -march=4ksd, that's what people should get, but I'd rather that users
> and maintainers saw that as a choice of MIPS32R2+SmartMIPS rather
> than a choice of 4KSd as a one-off.
>

Ok what about this patch. It allows to choose a specific cpu when
MIPS32R2 architecture is selected ?

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8b9002a..a6d168c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1290,6 +1302,30 @@ config SYS_HAS_CPU_RM9000
 config SYS_HAS_CPU_SB1
 	bool

+#
+# CPU model tuning.
+#
+choice
+	prompt "CPU model"
+	default CPU_GENERIC
+	help
+	  When configuring kernel building to MIPS32 architecture,
+	  whatever the release number, it can be interesting to narrow
+	  your choice for speed and size optimizations.
+
+config CPU_GENERIC
+	bool "Generic"
+	help
+	  It's safe to select this if your CPU model doesn't appear in the list.
+
+config CPU_4KSD
+	bool "4KSD"
+	depends on SYS_HAS_CPU_MIPS32_R2
+	help
+	  MIPS Technologies 4KSd-series processors.
+
+endchoice
+
 endmenu

 #
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index bc99c2d..c11df11 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -165,82 +167,92 @@ echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_
 #
 # CPU-dependent compiler/assembler options for optimization.
 #
-cflags-$(CONFIG_CPU_R3000)	+= \
+
+__cflags-$(CONFIG_CPU_R3000)	+= \
 			$(call set_gccflags,r3000,mips1,r3000,mips1,mips1)

-cflags-$(CONFIG_CPU_TX39XX)	+= \
+__cflags-$(CONFIG_CPU_TX39XX)	+= \
 			$(call set_gccflags,r3900,mips1,r3000,mips1,mips1)

-cflags-$(CONFIG_CPU_R6000)	+= \
+__cflags-$(CONFIG_CPU_R6000)	+= \
 			$(call set_gccflags,r6000,mips2,r6000,mips2,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_R4300)	+= \
+__cflags-$(CONFIG_CPU_R4300)	+= \
 			$(call set_gccflags,r4300,mips3,r4300,mips3,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_VR41XX)	+= \
+__cflags-$(CONFIG_CPU_VR41XX)	+= \
 			$(call set_gccflags,r4100,mips3,r4600,mips3,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_R4X00)	+= \
+__cflags-$(CONFIG_CPU_R4X00)	+= \
 			$(call set_gccflags,r4600,mips3,r4600,mips3,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_TX49XX)	+= \
+__cflags-$(CONFIG_CPU_TX49XX)	+= \
 			$(call set_gccflags,r4600,mips3,r4600,mips3,mips2)  \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_MIPS32_R1)	+= \
-			$(call set_gccflags,mips32,mips32,r4600,mips3,mips2) \
-			-Wa,--trap
-
-cflags-$(CONFIG_CPU_MIPS32_R2)	+= \
-			$(call set_gccflags,mips32r2,mips32r2,r4600,mips3,mips2) \
-			-Wa,--trap
-
-cflags-$(CONFIG_CPU_MIPS64_R1)	+= \
-			$(call set_gccflags,mips64,mips64,r4600,mips3,mips2) \
-			-Wa,--trap
-
-cflags-$(CONFIG_CPU_MIPS64_R2)	+= \
-			$(call set_gccflags,mips64r2,mips64r2,r4600,mips3,mips2) \
-			-Wa,--trap
-
-cflags-$(CONFIG_CPU_R5000)	+= \
+__cflags-$(CONFIG_CPU_R5000)	+= \
 			$(call set_gccflags,r5000,mips4,r5000,mips4,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_R5432)	+= \
+__cflags-$(CONFIG_CPU_R5432)	+= \
 			$(call set_gccflags,r5400,mips4,r5000,mips4,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_NEVADA)	+= \
+__cflags-$(CONFIG_CPU_NEVADA)	+= \
 			$(call set_gccflags,rm5200,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
 #			$(call cc-option,-mmad)

-cflags-$(CONFIG_CPU_RM7000)	+= \
+__cflags-$(CONFIG_CPU_RM7000)	+= \
 			$(call set_gccflags,rm7000,mips4,r5000,mips4,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_RM9000)	+= \
+__cflags-$(CONFIG_CPU_RM9000)	+= \
 			$(call set_gccflags,rm9000,mips4,r5000,mips4,mips2) \
 			-Wa,--trap


-cflags-$(CONFIG_CPU_SB1)	+= \
+__cflags-$(CONFIG_CPU_SB1)	+= \
 			$(call set_gccflags,sb1,mips64,r5000,mips4,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_R8000)	+= \
+__cflags-$(CONFIG_CPU_R8000)	+= \
 			$(call set_gccflags,r8000,mips4,r8000,mips4,mips2) \
 			-Wa,--trap

-cflags-$(CONFIG_CPU_R10000)	+= \
+__cflags-$(CONFIG_CPU_R10000)	+= \
 			$(call set_gccflags,r10000,mips4,r8000,mips4,mips2) \
 			-Wa,--trap

+__cflags-$(CONFIG_CPU_4KSD)	+= \
+			$(call set_gccflags,4ksd,mips32r2,4kec,mips32r2) \
+			-Wa,--trap
+
+# Fallback options for MIPS32 architectures
+ifndef __cflags-y
+__cflags-$(CONFIG_CPU_MIPS32_R1)	+= \
+			$(call set_gccflags,mips32,mips32,r4600,mips3,mips2) \
+			-Wa,--trap
+
+__cflags-$(CONFIG_CPU_MIPS32_R2)	+= \
+			$(call set_gccflags,mips32r2,mips32r2,r4600,mips3,mips2) \
+			-Wa,--trap
+
+__cflags-$(CONFIG_CPU_MIPS64_R1)	+= \
+			$(call set_gccflags,mips64,mips64,r4600,mips3,mips2) \
+			-Wa,--trap
+
+__cflags-$(CONFIG_CPU_MIPS64_R2)	+= \
+			$(call set_gccflags,mips64r2,mips64r2,r4600,mips3,mips2) \
+			-Wa,--trap
+endif
+
+cflags-y	+= $(__cflags-y)
+
 ifdef CONFIG_CPU_SB1
 ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
 MODFLAGS	+= -msb1-pass1-workarounds
