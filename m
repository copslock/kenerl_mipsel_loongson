Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:27:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51637 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008556AbbIVR1ljpC5U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:27:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3E6E3B3BB7663;
        Tue, 22 Sep 2015 18:27:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:27:35 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:27:34 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] MIPS: don't read GCRs when a CM is not present
Date:   Tue, 22 Sep 2015 10:26:38 -0700
Message-ID: <1442942801-2883-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442942801-2883-1-git-send-email-paul.burton@imgtec.com>
References: <1442942801-2883-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49286
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

Commit 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache
errors") leads to Malta boards unconditionally reading CM GCRs upon bus
errors, regardless of whether a CM is present. This is incorrect & will
lead to further exceptions. Fix by moving the GCR reads to after the
check for whether a CM is present.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/mips-cm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index b8ceee5..10524ce 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -252,7 +252,6 @@ int mips_cm_probe(void)
 
 void mips_cm_error_report(void)
 {
-	unsigned long revision = mips_cm_revision();
 	/*
 	 * CM3 has a 64-bit Error cause register with 0:57 containing the error
 	 * info and 63:58 the error type. For old CMs, everything is contained
@@ -260,17 +259,21 @@ void mips_cm_error_report(void)
 	 * though the cm_error is u64, we will simply ignore the upper word
 	 * for CM2.
 	 */
-	u64 cm_error = read_gcr_error_cause();
-	int cm_error_cause_sft = CM_GCR_ERROR_CAUSE_ERRTYPE_SHF +
-				 ((revision >= CM_REV_CM3) ? 31 : 0);
-	unsigned long cm_addr = read_gcr_error_addr();
-	unsigned long cm_other = read_gcr_error_mult();
-	int ocause, cause;
+	u64 cm_error;
+	unsigned long revision, cm_addr, cm_other;
+	int ocause, cause, cm_error_cause_sft;
 	char buf[256];
 
 	if (!mips_cm_present())
 		return;
 
+	revision = mips_cm_revision();
+	cm_error = read_gcr_error_cause();
+	cm_addr = read_gcr_error_addr();
+	cm_other = read_gcr_error_mult();
+
+	cm_error_cause_sft = CM_GCR_ERROR_CAUSE_ERRTYPE_SHF +
+				 ((revision >= CM_REV_CM3) ? 31 : 0);
 	cause = cm_error >> cm_error_cause_sft;
 
 	if (!cause)
-- 
2.5.3
