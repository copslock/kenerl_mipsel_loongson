Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 11:48:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33880 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992211AbcIGJpstaAXS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 11:45:48 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E9D7F790BBF13;
        Wed,  7 Sep 2016 10:45:27 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 7 Sep 2016 10:45:30 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 07/12] MIPS: pm-cps: Use MIPS standard completion barrier
Date:   Wed, 7 Sep 2016 10:45:15 +0100
Message-ID: <1473241520-14917-8-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
References: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55053
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

SYNC type 0 is defined in the MIPS architecture as a completion barrier
where all loads/stores in the pipeline before the sync instruction must
complete before any loads/stores subsequent to the sync instruction.

In places where we require loads / stores be globally completed, use the
standard completion sync stype.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/kernel/pm-cps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index d7037fe00d1c..953ff0db9061 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -315,7 +315,7 @@ static int __init cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
 	}
 
 	/* Barrier ensuring previous cache invalidates are complete */
-	uasm_i_sync(pp, stype_memory);
+	uasm_i_sync(pp, STYPE_SYNC);
 	uasm_i_ehb(pp);
 
 	/* Check whether the pipeline stalled due to the FSB being full */
@@ -467,7 +467,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 			      Index_Writeback_Inv_D, lbl_flushdcache);
 
 	/* Barrier ensuring previous cache invalidates are complete */
-	uasm_i_sync(&p, stype_memory);
+	uasm_i_sync(&p, STYPE_SYNC);
 	uasm_i_ehb(&p);
 
 	/*
@@ -480,7 +480,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	uasm_i_lw(&p, t0, 0, r_pcohctl);
 
 	/* Barrier to ensure write to coherence control is complete */
-	uasm_i_sync(&p, stype_intervention);
+	uasm_i_sync(&p, STYPE_SYNC);
 	uasm_i_ehb(&p);
 
 	/* Disable coherence */
@@ -526,7 +526,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		}
 
 		/* Barrier to ensure write to CPC command is complete */
-		uasm_i_sync(&p, stype_memory);
+		uasm_i_sync(&p, STYPE_SYNC);
 		uasm_i_ehb(&p);
 	}
 
@@ -561,7 +561,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	uasm_i_lw(&p, t0, 0, r_pcohctl);
 
 	/* Barrier to ensure write to coherence control is complete */
-	uasm_i_sync(&p, stype_memory);
+	uasm_i_sync(&p, STYPE_SYNC);
 	uasm_i_ehb(&p);
 
 	if (coupled_coherence && (state == CPS_PM_NC_WAIT)) {
-- 
2.7.4
