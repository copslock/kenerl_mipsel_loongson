Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 01:33:53 +0100 (CET)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58122 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009241AbaLTAdRfJaGr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 01:33:17 +0100
Received: by mail-ie0-f172.google.com with SMTP id tr6so1721026ieb.17;
        Fri, 19 Dec 2014 16:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NGNeJLUGftDg8GjsxqEt3xgYLhkUhBewWSE8ui2oBiQ=;
        b=kTI9FkbasvT6nM3mDU3GcyhhShbb4RGdeK8KcUyjaupoADl3dWZ9ci392bUDF1Rz1X
         M/iEtlIJHk4EVTazF6PBRGeFFAxBZNyzORDHBXQ/bo2268JoNls2yZfLas9r8/F1afEU
         Hxfs+bQibnISGvSq/WWV8RWu7fSG5ejQjIKlNwrobbNLD/KyLc9bOhxhRaaz8ip0xH3y
         KtuefyVx9p+TnPKSfERaefc/KPSq9MFXAsOSpT6dBNbDezk70t0/OObarmGZ2lqRmY/L
         1r0UtlS0cE674hFFJpX3cjbrYzZU5ZCL9g8M3wn0LXcz7CkwpWQnRe/78OLVbWbohNS6
         B23A==
X-Received: by 10.42.39.6 with SMTP id f6mr9130129ice.14.1419035592059;
        Fri, 19 Dec 2014 16:33:12 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id d1sm1613395igz.13.2014.12.19.16.33.11
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 16:33:11 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK0XAhm021716;
        Fri, 19 Dec 2014 16:33:10 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK0XAWr021715;
        Fri, 19 Dec 2014 16:33:10 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] Revert "MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions"
Date:   Fri, 19 Dec 2014 16:33:05 -0800
Message-Id: <1419035585-21671-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com>
References: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

This reverts commit 6575b1d4173eaeff6742a2c6dcbd835bb052952b.

It sets PG_IEC in cpu-probe.  But this value is clobbered in
tlb_init() so the system is never configured to take the RIXI specific
exceptions.  Caos ensues.

Cc: <stable@vger.kernel.org>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mipsregs.h | 1 -
 arch/mips/kernel/cpu-probe.c     | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 5e4aef3..dfdca76 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -265,7 +265,6 @@
 #define PG_XIE		(_ULCAST_(1) <<	 30)
 #define PG_ELPA		(_ULCAST_(1) <<	 29)
 #define PG_ESP		(_ULCAST_(1) <<	 28)
-#define PG_IEC		(_ULCAST_(1) <<  27)
 
 /*
  * R4x00 interrupt enable / cause bits
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5342674..63ace78 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -531,15 +531,6 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 	mips_probe_watch_registers(c);
 
-	if (cpu_has_rixi) {
-		/* Enable the RIXI exceptions */
-		write_c0_pagegrain(read_c0_pagegrain() | PG_IEC);
-		back_to_back_c0_hazard();
-		/* Verify the IEC bit is set */
-		if (read_c0_pagegrain() & PG_IEC)
-			c->options |= MIPS_CPU_RIXIEX;
-	}
-
 #ifndef CONFIG_MIPS_CPS
 	if (cpu_has_mips_r2) {
 		c->core = get_ebase_cpunum();
-- 
1.7.11.7
