Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:19:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43956 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010012AbcBCDShznoo0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:18:37 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id A860AD5C82077;
        Wed,  3 Feb 2016 03:18:28 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:18:29 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:18:28 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 09/15] MIPS: smp-cps: Ensure our VP ident calculation is correct
Date:   Wed, 3 Feb 2016 03:15:29 +0000
Message-ID: <1454469335-14778-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51637
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

When bringing up a CPU, ensure that its local ID as provided by the GIC
matches up with our calculation of it. This is vital, since if the
condition doesn't hold then we won't have configured interrupts
correctly for the VP.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/smp-cps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 2ad4e4c..7b35dec 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -307,6 +307,17 @@ static void cps_init_secondary(void)
 	if (cpu_has_mipsmt)
 		dmt();
 
+	if (mips_cm_revision() >= CM_REV_CM3) {
+		unsigned ident = gic_read_local_vp_id();
+
+		/*
+		 * Ensure that our calculation of the VP ID matches up with
+		 * what the GIC reports, otherwise we'll have configured
+		 * interrupts incorrectly.
+		 */
+		BUG_ON(ident != mips_cm_vp_id(smp_processor_id()));
+	}
+
 	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
 				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
 }
-- 
2.7.0
