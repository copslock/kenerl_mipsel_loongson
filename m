Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:15:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26804 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009112AbbIVSPbXyVbU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:15:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D6A605B286A1C;
        Tue, 22 Sep 2015 19:15:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:15:25 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:15:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 10/10] MIPS: CM,CPC: ensure core-other GCRs reflect the correct core
Date:   Tue, 22 Sep 2015 11:12:18 -0700
Message-ID: <1442945538-26141-11-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
References: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49311
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

Ensure the update to which core the core-other GCR regions reflect has
taken place before any core-other GCRs are accessed by placing a memory
barrier (sync instruction) between the write to the core-other registers
and any such GCR accesses.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/mips-cm.c  | 6 ++++++
 arch/mips/kernel/mips-cpc.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index fef2647..485e441 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -278,6 +278,12 @@ void mips_cm_lock_other(unsigned int core, unsigned int vp)
 	}
 
 	write_gcr_cl_other(val);
+
+	/*
+	 * Ensure the core-other region reflects the appropriate core &
+	 * VP before any accesses to it occur.
+	 */
+	mb();
 }
 
 void mips_cm_unlock_other(void)
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 8af4d62..566b8d2 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -76,6 +76,12 @@ void mips_cpc_lock_other(unsigned int core)
 	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
 			  per_cpu(cpc_core_lock_flags, curr_core));
 	write_cpc_cl_other(core << CPC_Cx_OTHER_CORENUM_SHF);
+
+	/*
+	 * Ensure the core-other region reflects the appropriate core &
+	 * VP before any accesses to it occur.
+	 */
+	mb();
 }
 
 void mips_cpc_unlock_other(void)
-- 
2.5.3
