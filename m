Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 17:18:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57136 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012047AbcBCQSQsVCuQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 17:18:16 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id AC81FD26C6FD5;
        Wed,  3 Feb 2016 16:18:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 16:18:10 +0000
Received: from localhost (10.100.200.164) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 16:18:10 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/3] MIPS: Add M6250 PRID & cpu_type_enum values
Date:   Wed, 3 Feb 2016 16:17:28 +0000
Message-ID: <1454516250-9395-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454516250-9395-1-git-send-email-paul.burton@imgtec.com>
References: <1454516250-9395-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.164]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51701
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

Define the processor ID for the M6250 CPU and add a value to the enum
cpu_type_enum for the core.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 7908dc2..96b7dd1 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -122,6 +122,7 @@
 #define PRID_IMP_M5150		0xa700
 #define PRID_IMP_P5600		0xa800
 #define PRID_IMP_I6400		0xa900
+#define PRID_IMP_M6250		0xab00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -309,7 +310,7 @@ enum cpu_type_enum {
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
 	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_LOONGSON1, CPU_M14KC,
 	CPU_M14KEC, CPU_INTERAPTIV, CPU_P5600, CPU_PROAPTIV, CPU_1074K, CPU_M5150,
-	CPU_I6400, CPU_P6600,
+	CPU_I6400, CPU_P6600, CPU_M6250,
 
 	/*
 	 * MIPS64 class processors
-- 
2.7.0
