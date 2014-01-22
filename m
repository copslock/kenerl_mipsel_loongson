Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 17:21:43 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:21303 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827305AbaAVQUYe5nhs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jan 2014 17:20:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Robert Richter <rric@kernel.org>, <oprofile-list@lists.sf.net>
Subject: [PATCH v2 5/5] MIPS: OProfile: Add CPU_P5600 cases
Date:   Wed, 22 Jan 2014 16:19:41 +0000
Message-ID: <1390407581-24238-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1390407581-24238-1-git-send-email-james.hogan@imgtec.com>
References: <1390407581-24238-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2014_01_22_16_20_20
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39070
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

Add a CPU_P5600 cpu type case in oprofile_arch_init() to use the MIPS
model, and in mipsxx_init() to set the cpu_type string to "mips/P5600".

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Robert Richter <rric@kernel.org>
Cc: oprofile-list@lists.sf.net
---
 arch/mips/oprofile/common.c          | 1 +
 arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 2a86e38872a7..f177d86f267b 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -88,6 +88,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_74K:
 	case CPU_INTERAPTIV:
 	case CPU_PROAPTIV:
+	case CPU_P5600:
 	case CPU_LOONGSON1:
 	case CPU_SB1:
 	case CPU_SB1A:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 4d94d75ec6f9..89d34f763297 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -384,6 +384,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/proAptiv";
 		break;
 
+	case CPU_P5600:
+		op_model_mipsxx_ops.cpu_type = "mips/P5600";
+		break;
+
 	case CPU_5KC:
 		op_model_mipsxx_ops.cpu_type = "mips/5K";
 		break;
-- 
1.8.1.2
