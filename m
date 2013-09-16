Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2013 17:56:01 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4491 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822318Ab3IPPzzVCCCL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Sep 2013 17:55:55 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 16 Sep 2013 08:49:16 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 16 Sep 2013 08:55:40 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 16 Sep 2013 08:55:40 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 03FA21A48; Mon, 16
 Sep 2013 08:55:38 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, blogic@openwrt.org, james.hogan@imgtec.com,
        "Florian Fainelli" <f.fainelli@gmail.com>
Subject: [PATCH v2] MIPS: ZBOOT: support LZ4 compression scheme
Date:   Mon, 16 Sep 2013 16:55:20 +0100
Message-ID: <1379346920-8569-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7E29F7F61R091350747-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37818
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

Add support for the LZ4 compression scheme in the ZBOOT decompression
stub, in order to support it we need to:

- select the "lz4" compression tool to compress the vmlinux.bin
  payload
- memcpy() is also required for decompress_unlz4.c so we share the
  implementation between GZIP, XZ and now LZ4

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Ralf, John,

This applied to the previous patch that I sent for XZ.
Changes since v1:
- s/XZ/LZ4/ in the commit message

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
