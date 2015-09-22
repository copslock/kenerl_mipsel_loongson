Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:15:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41381 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008747AbbIVRPqHsN4r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:15:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C4D41B3730543;
        Tue, 22 Sep 2015 18:15:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:15:40 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:15:39 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: traps: tidy up ebase calculation
Date:   Tue, 22 Sep 2015 10:15:22 -0700
Message-ID: <1442942122-32230-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Rather than #ifdef on CONFIG_KVM_GUEST & redefine the guest kseg0 base
locally, make use of the CAC_BASE macro which has the correct value in
both cases.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
---

 arch/mips/kernel/traps.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index fdb392b..4e106d5 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -37,6 +37,7 @@
 #include <linux/irq.h>
 #include <linux/perf_event.h>
 
+#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/break.h>
@@ -2204,12 +2205,8 @@ void __init trap_init(void)
 		ebase = (unsigned long)
 			__alloc_bootmem(size, 1 << fls(size), 0);
 	} else {
-#ifdef CONFIG_KVM_GUEST
-#define KVM_GUEST_KSEG0     0x40000000
-        ebase = KVM_GUEST_KSEG0;
-#else
-        ebase = CKSEG0;
-#endif
+		ebase = CAC_BASE;
+
 		if (cpu_has_mips_r2_r6)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
-- 
2.5.3
