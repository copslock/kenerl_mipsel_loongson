Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 16:10:26 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:23523 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225379AbUAVQKZ>; Thu, 22 Jan 2004 16:10:25 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 79BAC478A5; Thu, 22 Jan 2004 17:10:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 661DC47626; Thu, 22 Jan 2004 17:10:23 +0100 (CET)
Date: Thu, 22 Jan 2004 17:10:23 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
In-Reply-To: <20040121183551.GA21411@sonycom.com>
Message-ID: <Pine.LNX.4.55.0401221700510.16353@jurand.ds.pg.gda.pl>
References: <20031223114644.GA5458@sonycom.com>
 <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl> <20040120204026.GA9470@sonycom.com>
 <Pine.LNX.4.55.0401211449170.11137@jurand.ds.pg.gda.pl> <20040121145120.GA14288@sonycom.com>
 <20040121183551.GA21411@sonycom.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 21 Jan 2004, Dimitri Torfs wrote:

> Compiler choked on the first file it tries to compile: gcc added
> -mips1 automatically to the as command line which conflicts with the
> -Wa,--trap option:
> 
> /usr/local/lib/gcc-lib/mips-linux/3.2.2/../../../../mips-linux/bin/as
>  -G 0 -O2 -g0 -32 -march=r4100 -v -mips1 -non_shared -32 -march=r4100
>  --trap -o scripts/.tmp_empty.o -
> Assembler messages:
> Error: trap exception not supported at ISA 1
> 
> Removing the line which unsets the gas_isa option makes it work again:
> /usr/local/lib/gcc-lib/mips-linux/3.2.2/../../../../mips-linux/bin/as
> -G 0 -O2 -g0 -32 -march=r4100 -v -mips1 -non_shared -32 -march=r4100
> -mips3 --trap -o scripts/.tmp_empty.o

 Thanks for digging into it.  Actually after fixing the typos I've noticed
gcc 2.95.4 always implies the ISA from the ABI unless overridden and
-mabi=64 implies -mips4, so it bails out with -march/-mcpu set to
something like r4600.  This also proves the uncertainity about what's
passed to gas and so far including an ISA specification in gas settings is
tolerable if carefully chosen.  So here's a set of new updates -- now the
ISA specifier is removed from gcc flags only if it actually works and the
ISA specifier for gas is untouched.

 Hopefully this is the last attempt.  Please try it.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.23-20031209-mabi-8
diff -up --recursive --new-file linux-mips-2.4.23-20031209.macro/arch/mips/Makefile linux-mips-2.4.23-20031209/arch/mips/Makefile
--- linux-mips-2.4.23-20031209.macro/arch/mips/Makefile	2003-12-22 02:35:03.000000000 +0000
+++ linux-mips-2.4.23-20031209/arch/mips/Makefile	2004-01-21 23:53:31.000000000 +0000
@@ -98,6 +98,11 @@ while :; do \
 	gas_abi=; gas_opt=; gas_cpu=; gas_isa=; \
 	break; \
 done; \
+if test "$$gcc_opt" = -march= && test -n "$$gcc_abi"; then \
+	$(CC) $$gcc_abi $$gcc_opt$$gcc_cpu -S -o /dev/null \
+		-xc /dev/null > /dev/null 2>&1 && \
+		gcc_isa=; \
+fi; \
 echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_abi $$gas_opt$$gas_cpu $$gas_isa)
 
 #
diff -up --recursive --new-file linux-mips-2.4.23-20031209.macro/arch/mips64/Makefile linux-mips-2.4.23-20031209/arch/mips64/Makefile
--- linux-mips-2.4.23-20031209.macro/arch/mips64/Makefile	2003-12-22 02:32:44.000000000 +0000
+++ linux-mips-2.4.23-20031209/arch/mips64/Makefile	2004-01-21 23:53:25.000000000 +0000
@@ -37,7 +37,7 @@ endif
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
 GCCFLAGS	:= -I $(TOPDIR)/include/asm/gcc
-GCCFLAGS	+= -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe
+GCCFLAGS	+= -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe
 GCCFLAGS	+= $(call check_gcc, -finline-limit=100000,)
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
@@ -76,6 +76,7 @@ while :; do \
 	done; \
 	break; \
 done; \
+gcc_abi=-mabi=64; \
 gcc_cpu=$$cpu; gcc_isa=$$isa; \
 gas_cpu=$$cpu; gas_isa=-Wa,$$isa; \
 while :; do \
@@ -87,7 +88,12 @@ while :; do \
 	gas_opt=; gas_cpu=; gas_isa=; \
 	break; \
 done; \
-echo $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_opt$$gas_cpu $$gas_isa)
+if test "$$gcc_opt" = -march=; then \
+	$(CC) $$gcc_abi $$gcc_opt$$gcc_cpu -S -o /dev/null \
+		-xc /dev/null > /dev/null 2>&1 && \
+		gcc_isa=; \
+fi; \
+echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_opt$$gas_cpu $$gas_isa)
 
 #
 # CPU-dependent compiler/assembler options for optimization.

patch-mips-2.6.0-20040108-mabi-8
diff -up --recursive --new-file linux-mips-2.6.0-20040108.macro/arch/mips/Makefile linux-mips-2.6.0-20040108/arch/mips/Makefile
--- linux-mips-2.6.0-20040108.macro/arch/mips/Makefile	2004-01-07 04:56:39.000000000 +0000
+++ linux-mips-2.6.0-20040108/arch/mips/Makefile	2004-01-21 23:53:58.000000000 +0000
@@ -108,9 +108,14 @@ while :; do \
 	gas_abi=; gas_opt=; gas_cpu=; gas_isa=; \
 	break; \
 done; \
-if test x$(gcc-abi) != x$(gas-abi); then \
+if test "$(gcc-abi)" != "$(gas-abi)"; then \
 	gas_abi="-Wa,-$(gas-abi) -Wa,-mgp$(gcc-abi)"; \
 fi; \
+if test "$$gcc_opt" = -march= && test -n "$$gcc_abi"; then \
+	$(CC) $$gcc_abi $$gcc_opt$$gcc_cpu -S -o /dev/null \
+		-xc /dev/null > /dev/null 2>&1 && \
+		gcc_isa=; \
+fi; \
 echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_abi $$gas_opt$$gas_cpu $$gas_isa)
 
 #
