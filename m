Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 16:51:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40030 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029017AbcEKOuyXcxZz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 16:50:54 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id E90E45412730;
        Wed, 11 May 2016 15:50:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 15:50:48 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 15:50:47 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 1/6] MIPS: Avoid magic numbers probing kscratch_mask
Date:   Wed, 11 May 2016 15:50:27 +0100
Message-ID: <1462978232-10670-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462978232-10670-1-git-send-email-james.hogan@imgtec.com>
References: <1462978232-10670-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53375
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

The decode_config4() function reads kscratch_mask from
CP0_Config4.KScrExist using a hard coded shift and mask. We already have
a definition for the mask in mipsregs.h, so add a definition for the
shift and make use of them.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 3 ++-
 arch/mips/kernel/cpu-probe.c     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 08864cbbb27b..480d51550dc0 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -615,7 +615,8 @@
 #define MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT (_ULCAST_(1) << 14)
 #define MIPS_CONF4_MMUEXTDEF_FTLBSIZEEXT	(_ULCAST_(2) << 14)
 #define MIPS_CONF4_MMUEXTDEF_VTLBSIZEEXT	(_ULCAST_(3) << 14)
-#define MIPS_CONF4_KSCREXIST	(_ULCAST_(255) << 16)
+#define MIPS_CONF4_KSCREXIST_SHIFT	(16)
+#define MIPS_CONF4_KSCREXIST	(_ULCAST_(255) << MIPS_CONF4_KSCREXIST_SHIFT)
 #define MIPS_CONF4_VTLBSIZEEXT_SHIFT	(24)
 #define MIPS_CONF4_VTLBSIZEEXT	(_ULCAST_(15) << MIPS_CONF4_VTLBSIZEEXT_SHIFT)
 #define MIPS_CONF4_AE		(_ULCAST_(1) << 28)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 316c4d7dd7ae..6a9a55444f38 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -799,7 +799,8 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 		}
 	}
 
-	c->kscratch_mask = (config4 >> 16) & 0xff;
+	c->kscratch_mask = (config4 & MIPS_CONF4_KSCREXIST)
+				>> MIPS_CONF4_KSCREXIST_SHIFT;
 
 	asid_mask = MIPS_ENTRYHI_ASID;
 	if (config4 & MIPS_CONF4_AE)
-- 
2.4.10
