Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 06:40:58 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:60563 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225005AbUKNGkw>; Sun, 14 Nov 2004 06:40:52 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (sccrmhc11) with ESMTP
          id <20041114064044011006rd02e>; Sun, 14 Nov 2004 06:40:45 +0000
Message-ID: <4196FE7C.9040309@gentoo.org>
Date: Sun, 14 Nov 2004 01:43:08 -0500
From: Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Rewrite of arch/mips/ramdisk/
Content-Type: multipart/mixed;
 boundary="------------000407090604080206050501"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000407090604080206050501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a patch for 2.6 that rewrites how embedded mips ramdisks are 
merged into the kernel.  It basically replicates the method used by 2.6's 
initramfs (for linking in config.gz and such into the kernel, see the files in 
usr/ in the source tree).

The upside of this is the resulting ramdisk.o file has all the correct ELF 
flags, which is needed for the few o64 targets used (IP32, IP22), and it gets 
built to the right ABI (avoiding the binutils error about mixing 32/64bit code).

Tested on Indy R5K, O2 R5K and Cobalt RaQ2.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond

--------------000407090604080206050501
Content-Type: text/plain;
 name="mips-new-way-of-doing-ramdisks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips-new-way-of-doing-ramdisks.patch"

diff -Naurp linux-2.6.10-rc1.mips.orig/arch/mips/ramdisk/Makefile linux-2.6.10-rc1.mips.mod/arch/mips/ramdisk/Makefile
--- linux-2.6.10-rc1.mips.orig/arch/mips/ramdisk/Makefile	2004-06-08 16:41:55.000000000 -0400
+++ linux-2.6.10-rc1.mips.mod/arch/mips/ramdisk/Makefile	2004-11-13 17:16:59.124686128 -0500
@@ -2,19 +2,12 @@
 # Makefile for a ramdisk image
 #
 
+# Builds from ramdisk.S using .incbin
 obj-y += ramdisk.o
 
-
-O_FORMAT = $(shell $(OBJDUMP) -i | head -n 2 | grep elf32)
+# Set the path accordingly
 img := $(subst ",,$(CONFIG_EMBEDDED_RAMDISK_IMAGE))
-# add $(src) when $(img) is relative
 img := $(subst $(src)//,/,$(src)/$(img))
 
-quiet_cmd_ramdisk = LD      $@
-define cmd_ramdisk
-	$(LD) $(LDFLAGS) -T $(src)/ld.script -b binary --oformat $(O_FORMAT) -o $@ $(img)
-endef
-
-$(obj)/ramdisk.o: $(img) $(src)/ld.script
-	$(call cmd,ramdisk)
-
+# Pass the filename to ${AS}
+EXTRA_AFLAGS="-DMIPS_EMBEDDED_RAMDISK=\"$(img)\""
diff -Naurp linux-2.6.10-rc1.mips.orig/arch/mips/ramdisk/ld.script linux-2.6.10-rc1.mips.mod/arch/mips/ramdisk/ld.script
--- linux-2.6.10-rc1.mips.orig/arch/mips/ramdisk/ld.script	2001-11-13 00:35:54.000000000 -0500
+++ linux-2.6.10-rc1.mips.mod/arch/mips/ramdisk/ld.script	1969-12-31 19:00:00.000000000 -0500
@@ -1,9 +0,0 @@
-OUTPUT_ARCH(mips)
-SECTIONS
-{
-  .initrd :
-  {
-       *(.data)
-  }
-}
-
diff -Naurp linux-2.6.10-rc1.mips.orig/arch/mips/ramdisk/ramdisk.S linux-2.6.10-rc1.mips.mod/arch/mips/ramdisk/ramdisk.S
--- linux-2.6.10-rc1.mips.orig/arch/mips/ramdisk/ramdisk.S	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-rc1.mips.mod/arch/mips/ramdisk/ramdisk.S	2004-11-13 17:17:59.825458208 -0500
@@ -0,0 +1,9 @@
+/*
+ * For a detailed explanation of this file and the 
+ * commands, see usr/initramfs_data.S in the root 
+ * of this source tree.
+ */
+
+.section .initrd,"a"
+.incbin MIPS_EMBEDDED_RAMDISK
+

--------------000407090604080206050501--
