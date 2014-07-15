Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 15:10:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2612 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860999AbaGONKYsYjNm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 15:10:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7CEBA3C7D10B5
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 14:10:15 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 15 Jul
 2014 14:10:18 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 15 Jul 2014 14:10:17 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 15 Jul 2014 14:10:17 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/3] MIPS: Add new option for unique RI/XI exceptions
Date:   Tue, 15 Jul 2014 14:09:55 +0100
Message-ID: <1405429797-18281-2-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 41193
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

MIPSr5 added support for unique exception codes for the Read-Inhibit
and Execute-Inhibit exceptions.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/include/asm/cpu.h          | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 3b9768e92e9e..eeb5400ed4ee 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -32,6 +32,9 @@
 #ifndef cpu_has_htw
 #define cpu_has_htw		(cpu_data[0].options & MIPS_CPU_HTW)
 #endif
+#ifndef cpu_has_rixiex
+#define cpu_has_rixiex		(cpu_data[0].options & MIPS_CPU_RIXIEX)
+#endif
 
 /*
  * For the moment we don't consider R6000 and R8000 so we can assume that
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 8219c0a5f77e..be13f2879c84 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -364,6 +364,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_SEGMENTS	0x04000000ull /* CPU supports Segmentation Control registers */
 #define MIPS_CPU_EVA		0x80000000ull /* CPU supports Enhanced Virtual Addressing */
 #define MIPS_CPU_HTW		0x100000000ull /* CPU support Hardware Page Table Walker */
+#define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
 
 /*
  * CPU ASE encodings
-- 
2.0.0
