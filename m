Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jan 2006 17:27:49 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:2509 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3458556AbWA1R07 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Jan 2006 17:26:59 +0000
Received: from localhost (p1217-ipad204funabasi.chiba.ocn.ne.jp [222.146.88.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E89F19C93; Sun, 29 Jan 2006 02:31:39 +0900 (JST)
Date:	Sun, 29 Jan 2006 02:31:17 +0900 (JST)
Message-Id: <20060129.023117.63742164.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] more CHECKFLAGS to fix sparse warnings
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add _MIPS_SZINT and _MIPS_ISA to CHECKFLAGS.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index bd459b5..b23ce12 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -53,14 +53,17 @@ CROSS_COMPILE		:= $(tool-prefix)
 endif
 
 CHECKFLAGS-y				+= -D__linux__ -D__mips__ \
+					   -D_MIPS_SZINT=32 \
 					   -D_ABIO32=1 \
 					   -D_ABIN32=2 \
 					   -D_ABI64=3
 CHECKFLAGS-$(CONFIG_32BIT)		+= -D_MIPS_SIM=_ABIO32 \
 					   -D_MIPS_SZLONG=32 \
+					   -D_MIPS_SZPTR=32 \
 					   -D__PTRDIFF_TYPE__=int
 CHECKFLAGS-$(CONFIG_64BIT)		+= -m64 -D_MIPS_SIM=_ABI64 \
 					   -D_MIPS_SZLONG=64 \
+					   -D_MIPS_SZPTR=64 \
 					   -D__PTRDIFF_TYPE__="long int"
 CHECKFLAGS-$(CONFIG_CPU_BIG_ENDIAN)	+= -D__MIPSEB__
 CHECKFLAGS-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -D__MIPSEL__
@@ -167,79 +170,98 @@ echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_
 #
 cflags-$(CONFIG_CPU_R3000)	+= \
 			$(call set_gccflags,r3000,mips1,r3000,mips1,mips1)
+CHECKFLAGS-$(CONFIG_CPU_R3000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS1
 
 cflags-$(CONFIG_CPU_TX39XX)	+= \
 			$(call set_gccflags,r3900,mips1,r3000,mips1,mips1)
+CHECKFLAGS-$(CONFIG_CPU_TX39XX)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS1
 
 cflags-$(CONFIG_CPU_R6000)	+= \
 			$(call set_gccflags,r6000,mips2,r6000,mips2,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_R6000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS2
 
 cflags-$(CONFIG_CPU_R4300)	+= \
 			$(call set_gccflags,r4300,mips3,r4300,mips3,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_R4300)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS3
 
 cflags-$(CONFIG_CPU_VR41XX)	+= \
 			$(call set_gccflags,r4100,mips3,r4600,mips3,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_VR41XX)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS3
 
 cflags-$(CONFIG_CPU_R4X00)	+= \
 			$(call set_gccflags,r4600,mips3,r4600,mips3,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_R4X00)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS3
 
 cflags-$(CONFIG_CPU_TX49XX)	+= \
 			$(call set_gccflags,r4600,mips3,r4600,mips3,mips2)  \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_TX49XX)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS3
 
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= \
 			$(call set_gccflags,mips32,mips32,r4600,mips3,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_MIPS32_R1)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS32
 
 cflags-$(CONFIG_CPU_MIPS32_R2)	+= \
 			$(call set_gccflags,mips32r2,mips32r2,r4600,mips3,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_MIPS32_R2)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS32
 
 cflags-$(CONFIG_CPU_MIPS64_R1)	+= \
 			$(call set_gccflags,mips64,mips64,r4600,mips3,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_MIPS64_R1)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS64
 
 cflags-$(CONFIG_CPU_MIPS64_R2)	+= \
 			$(call set_gccflags,mips64r2,mips64r2,r4600,mips3,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_MIPS64_R2)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS64
 
 cflags-$(CONFIG_CPU_R5000)	+= \
 			$(call set_gccflags,r5000,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_R5000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
 
 cflags-$(CONFIG_CPU_R5432)	+= \
 			$(call set_gccflags,r5400,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_R5432)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
 
 cflags-$(CONFIG_CPU_NEVADA)	+= \
 			$(call set_gccflags,rm5200,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
 #			$(call cc-option,-mmad)
+CHECKFLAGS-$(CONFIG_CPU_NEVADA)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
 
 cflags-$(CONFIG_CPU_RM7000)	+= \
 			$(call set_gccflags,rm7000,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_RM7000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
 
 cflags-$(CONFIG_CPU_RM9000)	+= \
 			$(call set_gccflags,rm9000,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_RM9000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
 
 
 cflags-$(CONFIG_CPU_SB1)	+= \
 			$(call set_gccflags,sb1,mips64,r5000,mips4,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_SB1)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS64
 
 cflags-$(CONFIG_CPU_R8000)	+= \
 			$(call set_gccflags,r8000,mips4,r8000,mips4,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_R8000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
 
 cflags-$(CONFIG_CPU_R10000)	+= \
 			$(call set_gccflags,r10000,mips4,r8000,mips4,mips2) \
 			-Wa,--trap
+CHECKFLAGS-$(CONFIG_CPU_R10000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
 
 ifdef CONFIG_CPU_SB1
 ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
