Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 18:03:33 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:4344 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854780AbaEIQCazKg4e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 18:02:30 +0200
X-IronPort-AV: E=Sophos;i="4.97,1019,1389772800"; 
   d="scan'208";a="28568756"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 09 May 2014 09:29:09 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 May 2014 09:02:23 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 May 2014 09:02:24 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 D90C35D81D;    Fri,  9 May 2014 09:02:22 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 4/5] MIPS: Compress MAPPED kernels
Date:   Fri, 9 May 2014 21:39:23 +0530
Message-ID: <1399651764-14202-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399651764-14202-1-git-send-email-jchandra@broadcom.com>
References: <1399649304-25856-1-git-send-email-jchandra@broadcom.com>
 <1399651764-14202-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add code to build the wrapper in KSEG0, which in turn loads the
mapped kernel.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |    9 +++++++++
 arch/mips/boot/compressed/decompress.c             |    6 +++++-
 arch/mips/boot/compressed/head.S                   |    5 +++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
index 37fe58c..9791e39 100644
--- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -51,6 +51,15 @@ int main(int argc, char *argv[])
 
 	vmlinuz_load_addr += (16 - vmlinux_size % 16);
 
+	/* handle 32/64 bit mapped addresses */
+	if (vmlinuz_load_addr >= 0xffffffffc0000000ULL)
+		vmlinuz_load_addr = 0xffffffff80000000ull |
+					(vmlinuz_load_addr & 0x1fffffff);
+	if (vmlinuz_load_addr >= 0xc0000000ULL &&
+				vmlinuz_load_addr < 0xffffffffULL)
+		vmlinuz_load_addr = 0x80000000ull |
+					(vmlinuz_load_addr & 0x1fffffff);
+
 	printf("0x%llx\n", vmlinuz_load_addr);
 
 	return EXIT_SUCCESS;
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index c00c4dd..8321c86 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -70,6 +70,7 @@ void error(char *x)
 void decompress_kernel(unsigned long boot_heap_start)
 {
 	unsigned long zimage_start, zimage_size;
+	unsigned long long loadaddr = VMLINUX_LOAD_ADDRESS_ULL;
 
 	zimage_start = (unsigned long)(&__image_begin);
 	zimage_size = (unsigned long)(&__image_end) -
@@ -90,9 +91,12 @@ void decompress_kernel(unsigned long boot_heap_start)
 	puthex(VMLINUX_LOAD_ADDRESS_ULL);
 	puts("\n");
 
+#ifdef CONFIG_MAPPED_KERNEL
+	loadaddr = CKSEG0ADDR(loadaddr);
+#endif
 	/* Decompress the kernel with according algorithm */
 	decompress((char *)zimage_start, zimage_size, 0, 0,
-		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, error);
+		   (void *)(unsigned long)loadaddr, 0, error);
 
 	/* FIXME: should we flush cache here? */
 	puts("Now, booting the kernel...\n");
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 409cb48..47ab26f 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -14,6 +14,7 @@
 
 #include <asm/asm.h>
 #include <asm/regdef.h>
+#include <asm/addrspace.h>
 
 	.set noreorder
 	.cprestore
@@ -44,7 +45,11 @@ start:
 	move	a1, s1
 	move	a2, s2
 	move	a3, s3
+#ifdef CONFIG_MAPPED_KERNEL
+	PTR_LI	k0, CKSEG0ADDR(KERNEL_ENTRY)
+#else
 	PTR_LI	k0, KERNEL_ENTRY
+#endif
 	jr	k0
 	 nop
 3:
-- 
1.7.9.5
