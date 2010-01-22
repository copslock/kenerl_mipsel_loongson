Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 23:42:04 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16835 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491033Ab0AVWle (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2010 23:41:34 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b5a29a20003>; Fri, 22 Jan 2010 14:41:38 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 22 Jan 2010 14:41:22 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 22 Jan 2010 14:41:22 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o0MMfI4V005023;
        Fri, 22 Jan 2010 14:41:18 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o0MMfIZ0005022;
        Fri, 22 Jan 2010 14:41:18 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Decode c0_config4 for large TLBs.
Date:   Fri, 22 Jan 2010 14:41:15 -0800
Message-Id: <1264200075-4992-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1264200075-4992-1-git-send-email-ddaney@caviumnetworks.com>
References: <1264200075-4992-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 22 Jan 2010 22:41:22.0518 (UTC) FILETIME=[05ADDF60:01CA9BB4]
X-archive-position: 25640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15067

For processors that have more than 64 TLBs, we need to decode both
config1 and config4 to determine the total number TLBs.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |    3 +++
 arch/mips/kernel/cpu-probe.c     |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 5c192a0..298216e 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -564,6 +564,9 @@
 #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
 #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
 
+#define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
+#define MIPS_CONF4_MMUEXTDEF	(_ULCAST_(3) << 14)
+
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 80e202e..517c565 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -691,6 +691,18 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 	return config3 & MIPS_CONF_M;
 }
 
+static inline unsigned int decode_config4(struct cpuinfo_mips *c)
+{
+	unsigned int config4;
+
+	config4 = read_c0_config4();
+
+	if ((config4 & MIPS_CONF4_MMUEXTDEF) == 0x4000 && cpu_has_tlb)
+		c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
+
+	return config4 & MIPS_CONF_M;
+}
+
 static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 {
 	int ok;
@@ -709,6 +721,8 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 		ok = decode_config2(c);
 	if (ok)
 		ok = decode_config3(c);
+	if (ok)
+		ok = decode_config4(c);
 
 	mips_probe_watch_registers(c);
 }
-- 
1.6.0.6
