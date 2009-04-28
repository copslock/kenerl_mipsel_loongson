Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 00:00:39 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.158]:8666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025817AbZD1XAd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2009 00:00:33 +0100
Received: by fg-out-1718.google.com with SMTP id d23so1071965fga.9
        for <multiple recipients>; Tue, 28 Apr 2009 16:00:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:cc
         :message-id:from:date;
        bh=3EOyk/4Wu9xL/SqfvY0iu09WnNf3tza0sNasVPeOLtg=;
        b=ZSq7EeA0+psKM6T1EMaw3TCbGtOJvFWAFNMnqyRN2igy5wBK3KmZFQLHtVf2pgToAu
         NjqqBLfFyIdIFWqJaLfDrOD/582x/03aiuHSOdIy0jUrWxivvytTlymSx7z7irU8wecA
         IAjCmJmhfGKe2lG6DG22eh4pCMU3U6MK/tDGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:cc:message-id:from:date;
        b=k6BiePRz68BjtE/GXEDs0820z4R+cNEDv2w/qfBbEUKe9IwYsH/Ouqxst+sZoLFWfc
         F/wYtO3GISZW6QVEXh46mt7DDgUp1NsYnK3k51m9AXDD/ZmVm5OK45i/zzyClfyYar6H
         yCTV1ZMxsXlJsOTw+YRJcU/shMHU76IOYCf4o=
Received: by 10.86.98.10 with SMTP id v10mr36754fgb.76.1240959632302;
        Tue, 28 Apr 2009 16:00:32 -0700 (PDT)
Received: from localhost (207-47-250-185.sktn.hsdb.sasknet.sk.ca [207.47.250.185])
        by mx.google.com with ESMTPS id l12sm315613fgb.29.2009.04.28.16.00.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 16:00:31 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1LywHr-0006MX-S3; Tue, 28 Apr 2009 17:00:27 -0600
To:	linux-mips@linux-mips.org
Subject: [MIPS] Remove the RAMROOT function for msp71xx
Cc:	ralf@linux-mips.org
Message-Id: <E1LywHr-0006MX-S3@localhost>
From:	Shane McDonald <mcdonald.shane@gmail.com>
Date:	Tue, 28 Apr 2009 17:00:27 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

The RAMROOT function was a successful but non-portable attempt to append
the root filesystem to the end of the kernel image.  The preferred and
portable solution is to use an initramfs instead.  This patch removes
the RAMROOT functionality.

This patch has been compile-tested against the current HEAD.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/pmc-sierra/Kconfig            |   12 ------
 arch/mips/pmc-sierra/msp71xx/msp_prom.c |   60 +------------------------------
 2 files changed, 1 insertions(+), 71 deletions(-)

diff --git a/arch/mips/pmc-sierra/Kconfig b/arch/mips/pmc-sierra/Kconfig
index 90261b8..c139988 100644
--- a/arch/mips/pmc-sierra/Kconfig
+++ b/arch/mips/pmc-sierra/Kconfig
@@ -36,18 +36,6 @@ config PMC_MSP7120_FPGA
 
 endchoice
 
-menu "Options for PMC-Sierra MSP chipsets"
-	depends on PMC_MSP
-
-config PMC_MSP_EMBEDDED_ROOTFS
-	bool "Root filesystem embedded in kernel image"
-	select MTD
-	select MTD_BLOCK
-	select MTD_PMC_MSP_RAMROOT
-	select MTD_RAM
-
-endmenu
-
 config HYPERTRANSPORT
 	bool "Hypertransport Support for PMC-Sierra Yosemite"
 	depends on PMC_YOSEMITE
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
index e5bd548..c317a36 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
@@ -40,12 +40,6 @@
 #include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
-#ifdef CONFIG_CRAMFS
-#include <linux/cramfs_fs.h>
-#endif
-#ifdef CONFIG_SQUASHFS
-#include <linux/squashfs_fs.h>
-#endif
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -435,10 +429,6 @@ struct prom_pmemblock *__init prom_getmdesc(void)
 	char		*str;
 	unsigned int	memsize;
 	unsigned int	heaptop;
-#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
-	void		*ramroot_start;
-	unsigned long	ramroot_size;
-#endif
 	int i;
 
 	str = prom_getenv(memsz_env);
@@ -506,19 +496,7 @@ struct prom_pmemblock *__init prom_getmdesc(void)
 	i++;			/* 3 */
 	mdesc[i].type = BOOT_MEM_RESERVED;
 	mdesc[i].base = CPHYSADDR((u32)_text);
-#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
-	if (get_ramroot(&ramroot_start, &ramroot_size)) {
-		/*
-		 * Rootfs in RAM -- follows kernel
-		 * Combine rootfs image with kernel block so a
-		 * page (4k) isn't wasted between memory blocks
-		 */
-		mdesc[i].size = CPHYSADDR(PAGE_ALIGN(
-			(u32)ramroot_start + ramroot_size)) - mdesc[i].base;
-	} else
-#endif
-		mdesc[i].size = CPHYSADDR(PAGE_ALIGN(
-			(u32)_end)) - mdesc[i].base;
+	mdesc[i].size = CPHYSADDR(PAGE_ALIGN((u32)_end)) - mdesc[i].base;
 
 	/* Remainder of RAM -- under memsize */
 	i++;			/* 5 */
@@ -528,39 +506,3 @@ struct prom_pmemblock *__init prom_getmdesc(void)
 
 	return &mdesc[0];
 }
-
-/* rootfs functions */
-#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
-bool get_ramroot(void **start, unsigned long *size)
-{
-	extern char _end[];
-
-	/* Check for start following the end of the kernel */
-	void *check_start = (void *)_end;
-
-	/* Check for supported rootfs types */
-#ifdef CONFIG_CRAMFS
-	if (*(__u32 *)check_start == CRAMFS_MAGIC) {
-		/* Get CRAMFS size */
-		*start = check_start;
-		*size = PAGE_ALIGN(((struct cramfs_super *)
-				   check_start)->size);
-
-		return true;
-	}
-#endif
-#ifdef CONFIG_SQUASHFS
-	if (*((unsigned int *)check_start) == SQUASHFS_MAGIC) {
-		/* Get SQUASHFS size */
-		*start = check_start;
-		*size = PAGE_ALIGN(((struct squashfs_super_block *)
-				   check_start)->bytes_used);
-
-		return true;
-	}
-#endif
-
-	return false;
-}
-EXPORT_SYMBOL(get_ramroot);
-#endif
-- 
1.6.2.4
