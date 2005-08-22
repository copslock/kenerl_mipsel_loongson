Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2005 22:03:28 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:13960
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8225373AbVHVVDN>; Mon, 22 Aug 2005 22:03:13 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP
	id 55D6F149734; Mon, 22 Aug 2005 17:08:20 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17162.16068.212165.340275@cortez.sw.starentnetworks.com>
Date:	Mon, 22 Aug 2005 17:08:20 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	Daniel Jacobowitz <dan@debian.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: gdb gets confused with o32 core files, WANT_COMPAT_REG_H needed?
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


I've been trying to fix core file support for 64bit kernel with o32
userspace (working against 2.6.12 cvs tag).

After applying the patch posted on 13 Feb 2005 from Daniel Jacobowitz
to fix binfmt_elfo32.c (any reason this didn't make it into CVS?),
I still ran into trouble with gdb not understanding the NT_PRSTATUS
header in the core file.

While Dan's fix makes the kernel use elf32 definitions, gdb was still
getting confused by pr_reg contained in the core file.

Dan's definition of ELF_CORE_COPY_REGS in binfmt_elfo32.c is copying
the registers using EF_R0 as 0 not 6 producing results into offset 0
through 37 not 6 through 43 as gdb expects for 32bit core files.

Below patch (applied after Dan's patch) writes the registers at offset
6 making gdb much happier.

-- 
Dave Johnson
Starent Networks


=======================

Fix o32 core files under 64bit kernel to use correct register
offset in NT_PRSTATUS

Signed-off-by: Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>

===== arch/mips/kernel/binfmt_elfo32.c 1.7 vs edited =====
--- 1.7/arch/mips/kernel/binfmt_elfo32.c	2005-08-20 12:30:12 -04:00
+++ edited/arch/mips/kernel/binfmt_elfo32.c	2005-08-22 16:09:59 -04:00
@@ -51,6 +51,7 @@
 #define TASK32_SIZE		0x7fff8000UL
 #undef ELF_ET_DYN_BASE
 #define ELF_ET_DYN_BASE         (TASK32_SIZE / 3 * 2)
+#define WANT_COMPAT_REG_H
 
 #include <asm/processor.h>
 #include <linux/module.h>
===== include/asm-mips/reg.h 1.1 vs edited =====
--- 1.1/include/asm-mips/reg.h	2005-02-02 11:39:14 -05:00
+++ edited/include/asm-mips/reg.h	2005-08-22 15:55:04 -04:00
@@ -70,7 +70,7 @@
 
 #endif
 
-#if CONFIG_MIPS64
+#if defined(CONFIG_MIPS64) && !defined(WANT_COMPAT_REG_H)
 
 #define EF_R0			 0
 #define EF_R1			 1
