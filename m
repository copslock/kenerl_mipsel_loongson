Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:31:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25383 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992247AbcIAQawfa-22 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:30:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6C956EA9AA0D7;
        Thu,  1 Sep 2016 17:30:33 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:30:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase 64bit
Date:   Thu, 1 Sep 2016 17:30:07 +0100
Message-ID: <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When reading the CP0_EBase register containing the WG (write gate) bit,
the ebase variable should be set to the full value of the register, i.e.
on a 64-bit kernel the full 64-bit width of the register via
read_cp0_ebase_64(), and on a 32-bit kernel the full 32-bit width
including bits 31:30 which may be writeable.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/traps.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 3de85be2486a..686903f62fa3 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2214,8 +2214,17 @@ void __init trap_init(void)
 	} else {
 		ebase = CAC_BASE;
 
-		if (cpu_has_mips_r2_r6)
-			ebase += (read_c0_ebase() & 0x3ffff000);
+		if (cpu_has_mips_r2_r6) {
+			if (cpu_has_ebase_wg) {
+#ifdef CONFIG_64BIT
+				ebase = (read_c0_ebase_64() & ~0xfff);
+#else
+				ebase = (read_c0_ebase() & ~0xfff);
+#endif
+			} else {
+				ebase += (read_c0_ebase() & 0x3ffff000);
+			}
+		}
 	}
 
 	if (cpu_has_mmips) {
-- 
git-series 0.8.10
