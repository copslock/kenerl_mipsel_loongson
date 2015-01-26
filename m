Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 10:41:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4826 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010725AbbAZJlUFuheK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 10:41:20 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BA137DB9D8EFF;
        Mon, 26 Jan 2015 09:41:12 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 26 Jan 2015 09:41:14 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 26 Jan 2015 09:41:12 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/3] MIPS: asm: pgtable: Add c0 hazards on HTW start/stop sequences
Date:   Mon, 26 Jan 2015 09:40:34 +0000
Message-ID: <1422265236-29290-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422265236-29290-1-git-send-email-markos.chandras@imgtec.com>
References: <1422265236-29290-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45473
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

When we use htw_{start,stop}() outside of htw_reset(), we need
to ensure that c0 changes have been propagated properly before
we attempt to continue with subsequence memory operations.

Cc: <stable@vger.kernel.org> # 3.17+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/pgtable.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index d6d1928539b1..7f7c558de9fc 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -99,16 +99,20 @@ extern void paging_init(void);
 
 #define htw_stop()							\
 do {									\
-	if (cpu_has_htw)						\
+	if (cpu_has_htw) {						\
 		write_c0_pwctl(read_c0_pwctl() &			\
 			       ~(1 << MIPS_PWCTL_PWEN_SHIFT));		\
+		back_to_back_c0_hazard();				\
+	}								\
 } while(0)
 
 #define htw_start()							\
 do {									\
-	if (cpu_has_htw)						\
+	if (cpu_has_htw) {						\
 		write_c0_pwctl(read_c0_pwctl() |			\
 			       (1 << MIPS_PWCTL_PWEN_SHIFT));		\
+		back_to_back_c0_hazard();				\
+	}								\
 } while(0)
 
 
@@ -116,9 +120,7 @@ do {									\
 do {									\
 	if (cpu_has_htw) {						\
 		htw_stop();						\
-		back_to_back_c0_hazard();				\
 		htw_start();						\
-		back_to_back_c0_hazard();				\
 	}								\
 } while(0)
 
-- 
2.2.2
