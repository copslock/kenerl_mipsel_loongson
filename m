Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 11:47:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2340 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992149AbcIGJpotHHdS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 11:45:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 89530C6EE1826;
        Wed,  7 Sep 2016 10:45:25 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 7 Sep 2016 10:45:28 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 04/12] MIPS: pm-cps: Update comments on barrier instructions
Date:   Wed, 7 Sep 2016 10:45:12 +0100
Message-ID: <1473241520-14917-5-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 55049
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

This code makes large use of barriers, which had quite vague
descriptions. Update the comments to make the choice of barrier and
reason for it more clear.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
Update comments on barriers

 arch/mips/kernel/pm-cps.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 2faa227a032e..7e8d4aa22233 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -315,7 +315,7 @@ static int __init cps_gen_flush_fsb(u32 **pp, struct uasm_label **pl,
 			     i * line_size * line_stride, t0);
 	}
 
-	/* Completion barrier */
+	/* Barrier ensuring previous cache invalidates are complete */
 	uasm_i_sync(pp, stype_memory);
 	uasm_i_ehb(pp);
 
@@ -414,7 +414,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		uasm_il_beqz(&p, &r, t2, lbl_incready);
 		uasm_i_addiu(&p, t1, t1, 1);
 
-		/* Ordering barrier */
+		/* Barrier ensuring all CPUs see the updated r_nc_count value */
 		uasm_i_sync(&p, stype_ordering);
 
 		/*
@@ -467,7 +467,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	cps_gen_cache_routine(&p, &l, &r, &cpu_data[cpu].dcache,
 			      Index_Writeback_Inv_D, lbl_flushdcache);
 
-	/* Completion barrier */
+	/* Barrier ensuring previous cache invalidates are complete */
 	uasm_i_sync(&p, stype_memory);
 	uasm_i_ehb(&p);
 
@@ -480,7 +480,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	uasm_i_sw(&p, t0, 0, r_pcohctl);
 	uasm_i_lw(&p, t0, 0, r_pcohctl);
 
-	/* Sync to ensure previous interventions are complete */
+	/* Barrier to ensure write to coherence control is complete */
 	uasm_i_sync(&p, stype_intervention);
 	uasm_i_ehb(&p);
 
@@ -526,7 +526,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 			goto gen_done;
 		}
 
-		/* Completion barrier */
+		/* Barrier to ensure write to CPC command is complete */
 		uasm_i_sync(&p, stype_memory);
 		uasm_i_ehb(&p);
 	}
@@ -561,7 +561,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	uasm_i_sw(&p, t0, 0, r_pcohctl);
 	uasm_i_lw(&p, t0, 0, r_pcohctl);
 
-	/* Completion barrier */
+	/* Barrier to ensure write to coherence control is complete */
 	uasm_i_sync(&p, stype_memory);
 	uasm_i_ehb(&p);
 
@@ -575,7 +575,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		uasm_il_beqz(&p, &r, t2, lbl_decready);
 		uasm_i_andi(&p, v0, t1, (1 << fls(smp_num_siblings)) - 1);
 
-		/* Ordering barrier */
+		/* Barrier ensuring all CPUs see the updated r_nc_count value */
 		uasm_i_sync(&p, stype_ordering);
 	}
 
@@ -597,7 +597,7 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		 */
 		uasm_build_label(&l, p, lbl_secondary_cont);
 
-		/* Ordering barrier */
+		/* Barrier ensuring all CPUs see the updated r_nc_count value */
 		uasm_i_sync(&p, stype_ordering);
 	}
 
-- 
2.7.4
