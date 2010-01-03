Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 21:18:23 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:50138 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492667Ab0ACUR2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 21:17:28 +0100
Received: by mail-ew0-f223.google.com with SMTP id 23so416198ewy.24
        for <multiple recipients>; Sun, 03 Jan 2010 12:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=kX57BdFPQTXbW/keEsNrQH+alTpJGe7jMIFG1/seobQ=;
        b=H17V+m4iFridvPE2hR6ZVDIZ90ppcHqzv9FBRHIAURHlNhKtoCeGQPjv+eWWBL4tLK
         NhPPk+/RYk3cqBRfFVDVhSmZnmrXiXhfN34qy1GjNT7sQb6hP2FUX6wMj8s5WTUDwZSy
         Guvegs77fuej839CABSZPHz1bsy7jdqgmANZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=sY3k5wa9hqdyanCcHZ7ycUyuC7G4PCjEQEY4SXkkXpa3LvNlS/GujE3u3To06OChsj
         2ghwi1L5C1q5IdtffnSPOesby+kx/zoqpHuzYOV4C1mzhSSgCH2n30Ex+5a7n4X8OyEg
         VmA5V2Yo2ZSvpU7PIS6oMfvdhlh8Ep7+zavbU=
Received: by 10.213.109.148 with SMTP id j20mr23544715ebp.2.1262549848632;
        Sun, 03 Jan 2010 12:17:28 -0800 (PST)
Received: from lenovo.localnet (92.59.76-86.rev.gaoland.net [86.76.59.92])
        by mx.google.com with ESMTPS id 10sm28528342eyd.37.2010.01.03.12.17.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 12:17:27 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 3 Jan 2010 21:17:26 +0100
Subject: [PATCH 3/4] MIPS: deal with larger physical offset
MIME-Version: 1.0
X-Length: 2223
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201001032117.26581.florian@openwrt.org>
X-archive-position: 25488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1993

AR7 has a larger physical offset than other MIPS based
systems and therefore needs to setup handlers differently.
This version uses uasm instead of the hand crafted assembly
previously sent. This modification is also required for
running the kernel in mapped address space.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Eugene Konev <ejka@imfi.kspu.ru>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 308e434..dbf52ab 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -51,6 +51,8 @@
 #include <asm/stacktrace.h>
 #include <asm/irq.h>
 
+#include "../mm/uasm.h"
+
 extern void check_wait(void);
 extern asmlinkage void r4k_wait(void);
 extern asmlinkage void rollback_handle_int(void);
@@ -1283,9 +1285,18 @@ void *set_except_vector(int n, void *addr)
 
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
