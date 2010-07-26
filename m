Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2010 23:29:53 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10236 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492375Ab0GZV3r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jul 2010 23:29:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4dfe640000>; Mon, 26 Jul 2010 14:30:12 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 14:29:44 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Jul 2010 14:29:44 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6QLTdeg013475;
        Mon, 26 Jul 2010 14:29:39 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6QLTcnn013474;
        Mon, 26 Jul 2010 14:29:38 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Decode core number for R2 CPUs.
Date:   Mon, 26 Jul 2010 14:29:37 -0700
Message-Id: <1280179777-13442-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 26 Jul 2010 21:29:44.0565 (UTC) FILETIME=[AA520A50:01CB2D09]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The struct cpuinfo_mips.core field should be populated with the
physical core number.  For R2 CPUs, this is carried in the low 10 bits
of Ebase.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/cpu-probe.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 9b66331..b1b304e 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -761,6 +761,9 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 		ok = decode_config4(c);
 
 	mips_probe_watch_registers(c);
+
+	if (cpu_has_mips_r2)
+		c->core = read_c0_ebase() & 0x3ff;
 }
 
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
-- 
1.7.1.1
