Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 02:25:22 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10289 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab1EMAZR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 02:25:17 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dcc7aa70000>; Thu, 12 May 2011 17:26:15 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 12 May 2011 17:25:12 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 12 May 2011 17:25:12 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p4D0P7Tr007550;
        Thu, 12 May 2011 17:25:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p4D0P5xv007549;
        Thu, 12 May 2011 17:25:05 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix build breakage in cpu-probe.c
Date:   Thu, 12 May 2011 17:24:59 -0700
Message-Id: <1305246299-7517-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 13 May 2011 00:25:12.0631 (UTC) FILETIME=[3954EC70:01CC1104]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Move set_elf_platform() above all its uses.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

linux-queue is currently broken, this fixes it.

 arch/mips/kernel/cpu-probe.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 054a640..bb133d1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -291,6 +291,12 @@ static inline int cpu_has_confreg(void)
 #endif
 }
 
+static inline void set_elf_platform(int cpu, const char *plat)
+{
+	if (cpu == 0)
+		__elf_platform = plat;
+}
+
 /*
  * Get the FPU Implementation/Revision.
  */
@@ -781,12 +787,6 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 		c->core = read_c0_ebase() & 0x3ff;
 }
 
-static inline void set_elf_platform(int cpu, const char *plat)
-{
-	if (cpu == 0)
-		__elf_platform = plat;
-}
-
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
-- 
1.7.2.3
