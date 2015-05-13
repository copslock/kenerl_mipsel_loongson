Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 12:51:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12374 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012407AbbEMKvKALyRP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 12:51:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9668AECE73184;
        Wed, 13 May 2015 11:51:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 11:51:06 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 13 May 2015 11:51:05 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/9] MIPS: hazards: Add hazard macros for tlb read
Date:   Wed, 13 May 2015 11:50:48 +0100
Message-ID: <1431514255-3030-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47360
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

Add hazard macros to <asm/hazards.h> for the following hazards around
tlbr (TLB read) instructions, which are used in TLB dumping code and
some KVM TLB management code:

- mtc0_tlbr_hazard
  Between mtc0 (Index) and tlbr. This is copied from mtc0_tlbw_hazard in
  all cases on the assumption that tlbr always has similar data user
  timings to tlbw.

- tlb_read_hazard
  Between tlbr and mfc0 (various TLB registers). This is copied from
  tlbw_use_hazard in all cases on the assumption that tlbr has similar
  data writer characteristics to tlbw, and mfc0 has similar data user
  characteristics to loads and stores.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Looking at r4000 manual, its tlbr had similar data user timings to tlbw,
and mfc0 had similar data writer timings to loads and stores. Are there
particular other cores that should be checked too?
---
 arch/mips/include/asm/hazards.h | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 4087b47ad1cb..7b99efd31074 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -31,9 +31,15 @@
 #define __mtc0_tlbw_hazard						\
 	___ehb
 
+#define __mtc0_tlbr_hazard						\
+	___ehb
+
 #define __tlbw_use_hazard						\
 	___ehb
 
+#define __tlb_read_hazard						\
+	___ehb
+
 #define __tlb_probe_hazard						\
 	___ehb
 
@@ -80,12 +86,23 @@ do {									\
 	___ssnop;							\
 	___ehb
 
+#define __mtc0_tlbr_hazard						\
+	___ssnop;							\
+	___ssnop;							\
+	___ehb
+
 #define __tlbw_use_hazard						\
 	___ssnop;							\
 	___ssnop;							\
 	___ssnop;							\
 	___ehb
 
+#define __tlb_read_hazard						\
+	___ssnop;							\
+	___ssnop;							\
+	___ssnop;							\
+	___ehb
+
 #define __tlb_probe_hazard						\
 	___ssnop;							\
 	___ssnop;							\
@@ -147,8 +164,12 @@ do {									\
 
 #define __mtc0_tlbw_hazard
 
+#define __mtc0_tlbr_hazard
+
 #define __tlbw_use_hazard
 
+#define __tlb_read_hazard
+
 #define __tlb_probe_hazard
 
 #define __irq_enable_hazard
@@ -166,8 +187,12 @@ do {									\
  */
 #define __mtc0_tlbw_hazard
 
+#define __mtc0_tlbr_hazard
+
 #define __tlbw_use_hazard
 
+#define __tlb_read_hazard
+
 #define __tlb_probe_hazard
 
 #define __irq_enable_hazard
@@ -196,11 +221,20 @@ do {									\
 	nop;								\
 	nop
 
+#define __mtc0_tlbr_hazard						\
+	nop;								\
+	nop
+
 #define __tlbw_use_hazard						\
 	nop;								\
 	nop;								\
 	nop
 
+#define __tlb_read_hazard						\
+	nop;								\
+	nop;								\
+	nop
+
 #define __tlb_probe_hazard						\
 	nop;								\
 	nop;								\
@@ -267,7 +301,9 @@ do {									\
 #define _ssnop ___ssnop
 #define	_ehb ___ehb
 #define mtc0_tlbw_hazard __mtc0_tlbw_hazard
+#define mtc0_tlbr_hazard __mtc0_tlbr_hazard
 #define tlbw_use_hazard __tlbw_use_hazard
+#define tlb_read_hazard __tlb_read_hazard
 #define tlb_probe_hazard __tlb_probe_hazard
 #define irq_enable_hazard __irq_enable_hazard
 #define irq_disable_hazard __irq_disable_hazard
@@ -300,6 +336,14 @@ do {									\
 } while (0)
 
 
+#define mtc0_tlbr_hazard()						\
+do {									\
+	__asm__ __volatile__(						\
+	__stringify(__mtc0_tlbr_hazard)					\
+	);								\
+} while (0)
+
+
 #define tlbw_use_hazard()						\
 do {									\
 	__asm__ __volatile__(						\
@@ -308,6 +352,14 @@ do {									\
 } while (0)
 
 
+#define tlb_read_hazard()						\
+do {									\
+	__asm__ __volatile__(						\
+	__stringify(__tlb_read_hazard)					\
+	);								\
+} while (0)
+
+
 #define tlb_probe_hazard()						\
 do {									\
 	__asm__ __volatile__(						\
-- 
2.3.6
