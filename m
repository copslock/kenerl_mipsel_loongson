Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 15:26:34 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60915 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904253Ab1KJO00 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 15:26:26 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: lantiq: Fix compile error in arch/mips/lantiq/xway/dma.c
Date:   Thu, 10 Nov 2011 16:26:02 +0100
Message-Id: <1320938762-3472-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 31500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9339

include/export.h needs to be included by arch/mips/lantiq/xway/dma.c.
Without this include we see the following errors.

arch/mips/lantiq/xway/dma.c:76:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:76:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:76:1: error: parameter names (without types) in function declaration
arch/mips/lantiq/xway/dma.c:88:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:88:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:88:1: error: parameter names (without types) in function declaration
arch/mips/lantiq/xway/dma.c:100:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:100:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:100:1: error: parameter names (without types) in function declaration
arch/mips/lantiq/xway/dma.c:113:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:113:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:113:1: error: parameter names (without types) in function declaration
arch/mips/lantiq/xway/dma.c:126:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:126:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:126:1: error: parameter names (without types) in function declaration
arch/mips/lantiq/xway/dma.c:164:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:164:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:164:1: error: parameter names (without types) in function declaration
arch/mips/lantiq/xway/dma.c:179:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:179:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:179:1: error: parameter names (without types) in function declaration
arch/mips/lantiq/xway/dma.c:190:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:190:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:190:1: error: parameter names (without types) in function declaration
arch/mips/lantiq/xway/dma.c:215:1: error: data definition has no type or storage class
arch/mips/lantiq/xway/dma.c:215:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/mips/lantiq/xway/dma.c:215:1: error: parameter names (without types) in function declaration

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org

---
 arch/mips/lantiq/xway/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 4278a45..cbb6ae5 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/export.h>
 
 #include <lantiq_soc.h>
 #include <xway_dma.h>
-- 
1.7.5.4
