Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 20:31:58 +0000 (GMT)
Received: from tango.eidologic.de ([IPv6:::ffff:217.172.179.146]:57748 "EHLO
	tango.eidologic.de") by linux-mips.org with ESMTP
	id <S8225546AbUASUb6>; Mon, 19 Jan 2004 20:31:58 +0000
Received: (from hero@localhost)
	by tango.eidologic.de (8.11.6/8.11.6/Slowlaris 9) id i0JKVsU26705
	for linux-mips@linux-mips.org; Mon, 19 Jan 2004 21:31:54 +0100
Date: Mon, 19 Jan 2004 21:31:54 +0100
From: Heiko Ronsdorf <hero@tango.eidologic.de>
To: linux-mips@linux-mips.org
Subject: [PATCH][2.4.24] Indy IP22 compile fixes
Message-ID: <20040119213154.A30538@tango.eidologic.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Return-Path: <hero@tango.eidologic.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hero@tango.eidologic.de
Precedence: bulk
X-list: linux-mips


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi list,

I was not able to compile 2.4.24 vanilla for my Indy IP22 without
these modifications. Please apply.

Please CC me, because I am not on the list.

bye,

	Heiko

--
To err is human, to forgive, beyond the scope of the (Operating) System.

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="elf.h.patch"

--- linux-2.4.24/include/asm-mips/elf.h.orig	Sat Jan 17 23:13:00 2004
+++ linux-2.4.24/include/asm-mips/elf.h	Sat Jan 17 23:16:56 2004
@@ -18,6 +18,11 @@
 #define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
 #define EF_MIPS_ARCH_32     0x50000000  /* MIPS32 code.  */
 #define EF_MIPS_ARCH_64     0x60000000  /* MIPS64 code.  */
+
+/* Flags in the e_flags field of the header */
+#define EF_MIPS_ABI2        0x00000020
+#define EF_MIPS_ABI         0x0000f000
+
 /* The ABI of a file. */
 #define EF_MIPS_ABI_O32     0x00001000  /* O32 ABI.  */
 #define EF_MIPS_ABI_O64     0x00002000  /* O32 extended for 64 bit.  */

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sgiseeq.c.patch"

--- linux-2.4.24/drivers/net/sgiseeq.c.orig	Sat Jan 17 22:13:21 2004
+++ linux-2.4.24/drivers/net/sgiseeq.c	Sat Jan 17 22:13:40 2004
@@ -31,8 +31,8 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
-#include <asm/sgi/sgihpc.h>
-#include <asm/sgi/sgint23.h>
+#include <asm/sgi/hpc3.h>
+#include <asm/sgi/ip22.h>
 #include <asm/sgialib.h>
 
 #include "sgiseeq.h"

--+QahgC5+KEYLbs62--
