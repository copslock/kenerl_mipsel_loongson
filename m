Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2013 17:44:06 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3632 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819313Ab3IPPn5EKSAr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Sep 2013 17:43:57 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 16 Sep 2013 08:33:08 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 16 Sep 2013 08:43:41 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 16 Sep 2013 08:43:41 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1DEB41A48; Mon, 16
 Sep 2013 08:43:39 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, blogic@openwrt.org, james.hogan@imgtec.com,
        "Florian Fainelli" <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: ZBOOT: support LZ4 compression scheme
Date:   Mon, 16 Sep 2013 16:43:19 +0100
Message-ID: <1379346199-8462-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7E29FB3E2L885165147-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37816
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

- select the "lz4" compression tool to compress the vmlinux.bin
  payload
- memcpy() is also required for decompress_unlz4.c so we share the
  implementation between GZIP, XZ and now LZ4

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Ralf, John,

This applied to the previous patch that I sent for XZ.

 arch/mips/Kconfig                      | 1 +
 arch/mips/boot/compressed/Makefile     | 1 +
 arch/mips/boot/compressed/decompress.c | 7 ++++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a6ac9a9..ddf4fb0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1492,6 +1492,7 @@ config SYS_SUPPORTS_ZBOOT
 	bool
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
+	select HAVE_KERNEL_LZ4
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index c1f8f07..ca0c343 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -48,6 +48,7 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
 
 tool_$(CONFIG_KERNEL_GZIP)    = gzip
 tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
+tool_$(CONFIG_KERNEL_LZ4)     = lz4
 tool_$(CONFIG_KERNEL_LZMA)    = lzma
 tool_$(CONFIG_KERNEL_LZO)     = lzo
 tool_$(CONFIG_KERNEL_XZ)      = xzkern
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index cff7b7d..a8c6fd6 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -43,7 +43,8 @@ void error(char *x)
 /* activate the code for pre-boot environment */
 #define STATIC static
 
-#if defined(CONFIG_KERNEL_GZIP) || defined(CONFIG_KERNEL_XZ)
+#if defined(CONFIG_KERNEL_GZIP) || defined(CONFIG_KERNEL_XZ) || \
+	defined(CONFIG_KERNEL_LZ4)
 void *memcpy(void *dest, const void *src, size_t n)
 {
 	int i;
@@ -72,6 +73,10 @@ void *memset(void *s, int c, size_t n)
 #include "../../../../lib/decompress_bunzip2.c"
 #endif
 
+#ifdef CONFIG_KERNEL_LZ4
+#include "../../../../lib/decompress_unlz4.c"
+#endif
+
 #ifdef CONFIG_KERNEL_LZMA
 #include "../../../../lib/decompress_unlzma.c"
 #endif
-- 
1.8.1.2
