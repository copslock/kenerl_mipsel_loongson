Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 12:37:18 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:61659 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225305AbUATMhS>; Tue, 20 Jan 2004 12:37:18 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 0CD7B4C3A9; Tue, 20 Jan 2004 13:37:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 0138E4B4FE; Tue, 20 Jan 2004 13:37:16 +0100 (CET)
Date: Tue, 20 Jan 2004 13:37:16 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
In-Reply-To: <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl>
References: <20031223114644.GA5458@sonycom.com>
 <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 23 Dec 2003, Maciej W. Rozycki wrote:

> >   "cc1: warning: The -march option is incompatible to -mipsN and therefore
> > +ignored."
> > 
> >   when compiling. I have the CONFIG_CPU_VR41XX option set, which sets
> >   the c-flags to:
> > 
> >   "-I /home/dimitri/work/linux/include/asm/gcc -G 0 -mno-abicalls
> >   -fno-pic -pipe  -finline-limit=100000 -mabi=32 -march=r4100 -mips3
> >   -Wa,-32 -Wa,-march=r4100 -Wa,-mips3 -Wa,--trap"
> > 
> >   I suppose that for the newer gcc versions only -march= should be
> >   set (I'm using gcc-3.2.2) ?
> 
>  Thanks for the report -- I suppose we can remove "-mips" whenever
> "-mabi=" is supported by gcc.  I'll do an update in January after I am 
> back from vacation.

 It took a bit longer than I planned, sorry.  Anyway, here are two
functionally equivalent patches, for 2.4 and the head, that remove an ISA
specification if a tool supports "-march=" and "-mabi=" at the same time.  
Please try the appropriate one.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.23-20031209-mabi-2
diff -up --recursive --new-file linux-mips-2.4.23-20031209.macro/arch/mips/Makefile linux-mips-2.4.23-20031209/arch/mips/Makefile
--- linux-mips-2.4.23-20031209.macro/arch/mips/Makefile	2003-12-22 02:35:03.000000000 +0000
+++ linux-mips-2.4.23-20031209/arch/mips/Makefile	2004-01-20 08:13:20.000000000 +0000
@@ -98,6 +98,12 @@ while :; do \
 	gas_abi=; gas_opt=; gas_cpu=; gas_isa=; \
 	break; \
 done; \
+if test "$gcc_opt" = -march && test -n "$gcc_abi"; then \
+	gcc_isa=; \
+fi; \
+if test "$gas_opt" = -Wa,-march && test -n "$gas_abi"; then \
+	gas_isa=; \
+fi; \
 echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_abi $$gas_opt$$gas_cpu $$gas_isa)
 
 #
diff -up --recursive --new-file linux-mips-2.4.23-20031209.macro/arch/mips64/Makefile linux-mips-2.4.23-20031209/arch/mips64/Makefile
--- linux-mips-2.4.23-20031209.macro/arch/mips64/Makefile	2003-12-22 02:32:44.000000000 +0000
+++ linux-mips-2.4.23-20031209/arch/mips64/Makefile	2004-01-20 08:13:28.000000000 +0000
@@ -87,6 +87,12 @@ while :; do \
 	gas_opt=; gas_cpu=; gas_isa=; \
 	break; \
 done; \
+if test "$gcc_opt" = -march; then \
+	gcc_isa=; \
+fi; \
+if test "$gas_opt" = -Wa,-march; then \
+	gas_isa=; \
+fi; \
 echo $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_opt$$gas_cpu $$gas_isa)
 
 #

patch-mips-2.6.0-20040108-mabi-2
diff -up --recursive --new-file linux-mips-2.6.0-20040108.macro/arch/mips/Makefile linux-mips-2.6.0-20040108/arch/mips/Makefile
--- linux-mips-2.6.0-20040108.macro/arch/mips/Makefile	2004-01-07 04:56:39.000000000 +0000
+++ linux-mips-2.6.0-20040108/arch/mips/Makefile	2004-01-20 08:13:49.000000000 +0000
@@ -111,6 +111,12 @@ done; \
 if test x$(gcc-abi) != x$(gas-abi); then \
 	gas_abi="-Wa,-$(gas-abi) -Wa,-mgp$(gcc-abi)"; \
 fi; \
+if test "$gcc_opt" = -march && test -n "$gcc_abi"; then \
+	gcc_isa=; \
+fi; \
+if test "$gas_opt" = -Wa,-march && test -n "$gas_abi"; then \
+	gas_isa=; \
+fi; \
 echo $$gcc_abi $$gcc_opt$$gcc_cpu $$gcc_isa $$gas_abi $$gas_opt$$gas_cpu $$gas_isa)
 
 #
