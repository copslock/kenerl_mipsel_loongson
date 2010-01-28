Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 15:23:16 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:62462 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492316Ab0A1OXG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2010 15:23:06 +0100
Received: by ewy23 with SMTP id 23so439513ewy.24
        for <multiple recipients>; Thu, 28 Jan 2010 06:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:organization:content-type
         :content-transfer-encoding:message-id;
        bh=D7lneYihwT8Lys5Fv+J3hSWJAlJNF9iwpvscT7msd6U=;
        b=iCpxcsbkTj1QSk4puQV8l664sQEufas9jdZoCi2mS4Ff2Q8K5A72VkOyAXScZ9bVrF
         QzC8bekCgV5IMnHeuxUcDQmGaJ8zG/Y/L1hIFQLCHzVJczRwk/6kJr82xTxgl+8JcWn7
         YxR2WaemSU+ZEOlUv6VXJQb51ftPPUBXFBnvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :organization:content-type:content-transfer-encoding:message-id;
        b=mtcEtGEXwj/w+i1UDv93LIgbEI8VtpwSLQtuvFdBIgXU4GLjmCdLqhrMyPOHSJ7F0/
         zN6zk8y6+9OYykUHH2d90pag7vQqhbPAHyHIjaU87kFmx4g+jFjeDAWVUPmTM/ajJhOx
         /DoF2alugElVrCGXLtcJi3cnuEKDBTntmpy78=
Received: by 10.213.41.210 with SMTP id p18mr2486648ebe.97.1264688580614;
        Thu, 28 Jan 2010 06:23:00 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 14sm649612ewy.11.2010.01.28.06.22.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 06:22:58 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 28 Jan 2010 15:22:37 +0100
Subject: [PATCH 3/3] MIPS: deal with larger physical offsets
MIME-Version: 1.0
X-Length: 2667
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Organization: OpenWrt
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201001281522.37939.florian@openwrt.org>
X-archive-position: 25719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18236

AR7 has a larger physical offset than other MIPS based
systems and therefore needs to setup its handlers beyond
the usual KSEG0 range. When running the kernel in mapped
mode this modification is also required. Remove function
comment which is now incorrect.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 574608e..14d515f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -50,6 +50,7 @@
 #include <asm/types.h>
 #include <asm/stacktrace.h>
 #include <asm/irq.h>
+#include <asm/uasm.h>
 
 extern void check_wait(void);
 extern asmlinkage void r4k_wait(void);
@@ -1271,11 +1272,6 @@ unsigned long ebase;
 unsigned long exception_handlers[32];
 unsigned long vi_handlers[64];
 
-/*
- * As a side effect of the way this is implemented we're limited
- * to interrupt handlers in the address range from
- * KSEG0 <= x < KSEG0 + 256mb on the Nevada.  Oh well ...
- */
 void __init *set_except_vector(int n, void *addr)
 {
 	unsigned long handler = (unsigned long) addr;
@@ -1283,9 +1279,18 @@ void __init *set_except_vector(int n, void *addr)
 
 	exception_handlers[n] = handler;
 	if (n == 0 && cpu_has_divec) {
-		*(u32 *)(ebase + 0x200) = 0x08000000 |
-					  (0x03ffffff & (handler >> 2));
-		local_flush_icache_range(ebase + 0x200, ebase + 0x204);
+		unsigned long jump_mask = ~((1 << 28) - 1);
+		u32 *buf = (u32 *)(ebase + 0x200);
+		unsigned int k0 = 26;
+		if((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
+			uasm_i_j(&buf, handler & jump_mask);
+			uasm_i_nop(&buf);
+		} else {
+			UASM_i_LA(&buf, k0, handler);
+			uasm_i_jr(&buf, k0);
+			uasm_i_nop(&buf);
+		}
+		local_flush_icache_range(ebase + 0x200, (unsigned long)buf);
 	}
 	return (void *)old_handler;
 }
