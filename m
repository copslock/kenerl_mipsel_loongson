Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 12:48:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36674 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992247AbcHaKpHGDGMD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 12:45:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6DE4BA3044242;
        Wed, 31 Aug 2016 11:44:48 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 Aug 2016 11:44:50 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Tony Wu <tung7970@gmail.com>,
        Nikolay Martynov <mar.kolya@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/10] MIPS: pm-cps: Support CM3 changes to Coherence Enable Register
Date:   Wed, 31 Aug 2016 11:44:37 +0100
Message-ID: <1472640279-26593-9-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

MIPS CM3 changed the management of coherence. Instead of a coherence
control register with a bitmask of coherent domains, CM3 simply has a
coherence enable register with a single bit to enable coherence of the
local core. Support this by clearing and setting this single bit to
disable / enable coherence.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mips-cm.h |  1 +
 arch/mips/kernel/pm-cps.c       | 31 ++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 58e7874e9347..ac30981a8360 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -359,6 +359,7 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 /* GCR_Cx_COHERENCE register fields */
 #define CM_GCR_Cx_COHERENCE_COHDOMAINEN_SHF	0
 #define CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK	(_ULCAST_(0xff) << 0)
+#define CM3_GCR_Cx_COHERENCE_COHEN_MSK		(_ULCAST_(0x1) << 0)
 
 /* GCR_Cx_CONFIG register fields */
 #define CM_GCR_Cx_CONFIG_IOCUTYPE_SHF		10
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 11c951f4f0b9..9def81cd4f63 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -485,18 +485,20 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	uasm_i_sync(&p, stype_memory);
 	uasm_i_ehb(&p);
 
-	/*
-	 * Disable all but self interventions. The load from COHCTL is defined
-	 * by the interAptiv & proAptiv SUMs as ensuring that the operation
-	 * resulting from the preceding store is complete.
-	 */
-	uasm_i_addiu(&p, t0, zero, 1 << cpu_data[cpu].core);
-	uasm_i_sw(&p, t0, 0, r_pcohctl);
-	uasm_i_lw(&p, t0, 0, r_pcohctl);
-
-	/* Sync to ensure previous interventions are complete */
-	uasm_i_sync(&p, stype_intervention);
-	uasm_i_ehb(&p);
+	if (mips_cm_revision() < CM_REV_CM3) {
+		/*
+		* Disable all but self interventions. The load from COHCTL is
+		* defined by the interAptiv & proAptiv SUMs as ensuring that the
+		*  operation resulting from the preceding store is complete.
+		*/
+		uasm_i_addiu(&p, t0, zero, 1 << cpu_data[cpu].core);
+		uasm_i_sw(&p, t0, 0, r_pcohctl);
+		uasm_i_lw(&p, t0, 0, r_pcohctl);
+
+		/* Sync to ensure previous interventions are complete */
+		uasm_i_sync(&p, stype_intervention);
+		uasm_i_ehb(&p);
+	}
 
 	/* Disable coherence */
 	uasm_i_sw(&p, zero, 0, r_pcohctl);
@@ -571,7 +573,10 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	 * will run this. The first will actually re-enable coherence & the
 	 * rest will just be performing a rather unusual nop.
 	 */
-	uasm_i_addiu(&p, t0, zero, CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK);
+	uasm_i_addiu(&p, t0, zero, mips_cm_revision() < CM_REV_CM3
+				? CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK
+				: CM3_GCR_Cx_COHERENCE_COHEN_MSK);
+
 	uasm_i_sw(&p, t0, 0, r_pcohctl);
 	uasm_i_lw(&p, t0, 0, r_pcohctl);
 
-- 
2.7.4
