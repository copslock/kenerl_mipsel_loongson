Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 15:11:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23002 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859971AbaGONKcGq0rT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 15:10:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7F522ABD5C56D
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 14:10:22 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 15 Jul
 2014 14:10:25 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 15 Jul 2014 14:10:25 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 15 Jul 2014 14:10:24 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/3] MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions
Date:   Tue, 15 Jul 2014 14:09:57 +0100
Message-ID: <1405429797-18281-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com>
References: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Detect if the core supports unique exception codes for the
Read-Inhibit and Execute-Inhibit exceptions and set the
option accordingly. The RI/XI exception support is detected
by setting the 27th bit (IEC) of the PageGrain C0 register
and reading back the value of that register to verify the
bit is enabled.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h | 1 +
 arch/mips/kernel/cpu-probe.c     | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 417125548bde..9775c1aba4d3 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -265,6 +265,7 @@
 #define PG_XIE		(_ULCAST_(1) <<	 30)
 #define PG_ELPA		(_ULCAST_(1) <<	 29)
 #define PG_ESP		(_ULCAST_(1) <<	 28)
+#define PG_IEC		(_ULCAST_(1) <<  27)
 
 /*
  * R4x00 interrupt enable / cause bits
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index eb1920ccd263..5995b19fbd66 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -438,6 +438,15 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 	mips_probe_watch_registers(c);
 
+	if (cpu_has_rixi) {
+		/* Enable the RIXI exceptions */
+		write_c0_pagegrain(read_c0_pagegrain() | PG_IEC);
+		back_to_back_c0_hazard();
+		/* Verify the IEC bit is set */
+		if (read_c0_pagegrain() & PG_IEC)
+			c->options |= MIPS_CPU_RIXIEX;
+	}
+
 #ifndef CONFIG_MIPS_CPS
 	if (cpu_has_mips_r2) {
 		c->core = get_ebase_cpunum();
-- 
2.0.0
