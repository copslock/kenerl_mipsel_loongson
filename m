Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:27:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51624 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008688AbbIVR1Z2MvsU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:27:25 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 320C9C9BF85E7;
        Tue, 22 Sep 2015 18:27:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:27:19 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:27:18 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/5] MIPS: clarify mips_cm_is64 documentation
Date:   Tue, 22 Sep 2015 10:26:37 -0700
Message-ID: <1442942801-2883-2-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 49285
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

The documentation for mips_cm_is64 implied that the width of the CM GCRs
would change depending upon the CPU, which is not true. Reword the
explanation to be clearer that the GCR width is purely dependent upon
the version of the CM.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mips-cm.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index d75b75e..2a70b76 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -36,12 +36,12 @@ extern phys_addr_t __mips_cm_phys_base(void);
 /*
  * mips_cm_is64 - determine CM register width
  *
- * The CM register width is processor and CM specific. A 64-bit processor
- * usually has a 64-bit CM and a 32-bit one has a 32-bit CM but a 64-bit
- * processor could come with a 32-bit CM. Moreover, accesses on 64-bit CMs
- * can be done either using regular 64-bit load/store instructions, or 32-bit
- * load/store instruction on 32-bit register pairs. We opt for using 64-bit
- * accesses on 64-bit CMs and kernels and 32-bit in any other case.
+ * The CM register width is determined by the version of the CM, with CM3
+ * introducing 64 bit GCRs and all prior CM versions having 32 bit GCRs.
+ * However we may run a kernel built for MIPS32 on a system with 64 bit GCRs,
+ * or vice-versa. This variable indicates the width of the memory accesses
+ * that the kernel will perform to GCRs, which may differ from the actual
+ * width of the GCRs.
  *
  * It's set to 0 for 32-bit accesses and 1 for 64-bit accesses.
  */
-- 
2.5.3
