Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56LtaK13334
	for linux-mips-outgoing; Wed, 6 Jun 2001 14:55:36 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56Ltah13330
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 14:55:36 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 1A6AD125BC; Wed,  6 Jun 2001 14:55:34 -0700 (PDT)
Date: Wed, 6 Jun 2001 14:55:34 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: gcc-patches@gcc.gnu.org
Cc: linux-mips@oss.sgi.com
Subject: A patch for linux/mips libgcc
Message-ID: <20010606145534.A28021@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This patch is against gcc 2.86-85. But it is trivial to convert it for
gcc 3.0. The problem is

# gcc gcc/testsuite/gcc.c-torture/execute/ieee/fp-cmp-4.c  -w -O0  -ffloat-store  -lm 
 /tmp/ccaUWHSO.o: In function `test_isunordered':
gcc/testsuite/gcc.c-torture/execute/ieee/fp-cmp-4.c(.text+0x44): undefined reference to `__unorddf2'

I copied it from IRIX 6.

H.J.
---
2001-06-06  H.J. Lu <hjl@gnu.org>

	* config/mips/t-linux: New.

	* configure.in: Add mips/t-linux to tmake_file.

--- gcc/config/mips/t-linux.fp	Tue Jun  5 22:14:03 2001
+++ gcc/config/mips/t-linux	Tue Jun  5 22:24:33 2001
@@ -0,0 +1,20 @@
+# We want fine grained libraries, so use the new code to build the
+# floating point emulation libraries.
+FPBIT = fp-bit.c
+DPBIT = dp-bit.c
+
+dp-bit.c: $(srcdir)/config/fp-bit.c
+	echo '#ifdef __MIPSEL__' > dp-bit.c
+	echo '#define FLOAT_BIT_ORDER_MISMATCH' >> dp-bit.c
+	echo '#endif' >> dp-bit.c
+	echo '#undef US_SOFTWARE_GOFAST' >> dp-bit.c
+	echo '#undef FLOAT' >> dp-bit.c
+	cat $(srcdir)/config/fp-bit.c >> dp-bit.c
+
+fp-bit.c: $(srcdir)/config/fp-bit.c
+	echo '#ifdef __MIPSEL__' > fp-bit.c
+	echo '#define FLOAT_BIT_ORDER_MISMATCH' >> fp-bit.c
+	echo '#endif' >> fp-bit.c
+	echo '#undef US_SOFTWARE_GOFAST' >> fp-bit.c
+	echo '#define FLOAT' >> fp-bit.c
+	cat $(srcdir)/config/fp-bit.c >> fp-bit.c
--- gcc/configure.in.fp	Tue Jun  5 22:14:03 2001
+++ gcc/configure.in	Tue Jun  5 22:14:03 2001
@@ -2747,7 +2747,7 @@ changequote([,])dnl
 		       mips*el-*)  tm_file="elfos.h mips/elfl.h mips/linux.h" ;;
 		       *)	  tm_file="elfos.h mips/elf.h mips/linux.h" ;;
 		esac
-		tmake_file=t-linux
+		tmake_file="t-linux mips/t-linux"
 		extra_parts="crtbegin.o crtbeginS.o crtend.o crtendS.o"
 		gnu_ld=yes
 		gas=yes
