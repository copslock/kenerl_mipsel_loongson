Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:27:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25927 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007574AbcBCD1bM0VsQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:27:31 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 81DC1A10A9E10;
        Wed,  3 Feb 2016 03:27:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:27:10 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:27:09 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/3] MIPS: Add P6600 PRID & cpu_type_enum values
Date:   Wed, 3 Feb 2016 03:26:37 +0000
Message-ID: <1454469999-17818-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454469999-17818-1-git-send-email-paul.burton@imgtec.com>
References: <1454469999-17818-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51645
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

Define the processor ID for the P6600 core and add a value to the enum
cpu_type_enum for the core.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index a97ca97..7908dc2 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -118,6 +118,7 @@
 #define PRID_IMP_INTERAPTIV_MP	0xa100
 #define PRID_IMP_PROAPTIV_UP	0xa200
 #define PRID_IMP_PROAPTIV_MP	0xa300
+#define PRID_IMP_P6600		0xa400
 #define PRID_IMP_M5150		0xa700
 #define PRID_IMP_P5600		0xa800
 #define PRID_IMP_I6400		0xa900
@@ -308,7 +309,7 @@ enum cpu_type_enum {
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
 	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_LOONGSON1, CPU_M14KC,
 	CPU_M14KEC, CPU_INTERAPTIV, CPU_P5600, CPU_PROAPTIV, CPU_1074K, CPU_M5150,
-	CPU_I6400,
+	CPU_I6400, CPU_P6600,
 
 	/*
 	 * MIPS64 class processors
-- 
2.7.0
