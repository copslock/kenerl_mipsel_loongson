Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 12:52:14 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4252 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822429Ab3IKKwLFrozF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Sep 2013 12:52:11 +0200
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 11 Sep 2013 03:41:25 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 11 Sep 2013 03:51:53 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 11 Sep 2013 03:51:53 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 96F771A49; Wed, 11
 Sep 2013 03:51:52 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, blogic@openwrt.org, james.hogan@imgtec.com,
        "Florian Fainelli" <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: ZBOOT: support XZ compression scheme
Date:   Wed, 11 Sep 2013 11:51:41 +0100
Message-ID: <1378896701-28166-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7E2E975F2L883481142-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Add support for the XZ compression scheme in the ZBOOT decompression
stub, in order to support it we need to:

- select the "xzkern" compression tool to compress the vmlinux.bin
  payload
- link with ashldi3.o for xz_dec_run() to work
- memcpy() is also required for decompress_unxz.c so we share the
  implementation between GZIP and XZ

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kconfig                      | 1 +
 arch/mips/boot/compressed/Makefile     | 5 +++++
 arch/mips/boot/compressed/decompress.c | 8 +++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c291790..a6ac9a9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1494,6 +1494,7 @@ config SYS_SUPPORTS_ZBOOT
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
+	select HAVE_KERNEL_XZ
 
 config SYS_SUPPORTS_ZBOOT_UART16550
 	bool
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 0048c08..c1f8f07 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -37,6 +37,10 @@ vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
+ifdef CONFIG_KERNEL_XZ
+vmlinuzobjs-y += $(obj)/../../lib/ashldi3.o
+endif
+
 targets += vmlinux.bin
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
 $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
@@ -46,6 +50,7 @@ tool_$(CONFIG_KERNEL_GZIP)    = gzip
 tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
 tool_$(CONFIG_KERNEL_LZMA)    = lzma
 tool_$(CONFIG_KERNEL_LZO)     = lzo
+tool_$(CONFIG_KERNEL_XZ)      = xzkern
 
 targets += vmlinux.bin.z
 $(obj)/vmlinux.bin.z: $(obj)/vmlinux.bin FORCE
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 2c95730..cff7b7d 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -43,7 +43,7 @@ void error(char *x)
 /* activate the code for pre-boot environment */
 #define STATIC static
 
-#ifdef CONFIG_KERNEL_GZIP
+#if defined(CONFIG_KERNEL_GZIP) || defined(CONFIG_KERNEL_XZ)
 void *memcpy(void *dest, const void *src, size_t n)
 {
 	int i;
@@ -54,6 +54,8 @@ void *memcpy(void *dest, const void *src, size_t n)
 		d[i] = s[i];
 	return dest;
 }
+#endif
+#ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
@@ -78,6 +80,10 @@ void *memset(void *s, int c, size_t n)
 #include "../../../../lib/decompress_unlzo.c"
 #endif
 
+#ifdef CONFIG_KERNEL_XZ
+#include "../../../../lib/decompress_unxz.c"
+#endif
+
 void decompress_kernel(unsigned long boot_heap_start)
 {
 	unsigned long zimage_start, zimage_size;
-- 
1.8.1.2
