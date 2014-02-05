Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2014 21:06:23 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:53397 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825397AbaBEUGRpPtPS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Feb 2014 21:06:17 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 33B3D19C006;
        Wed,  5 Feb 2014 22:06:14 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id qX2z0bEyYU5P; Wed,  5 Feb 2014 22:06:09 +0200 (EET)
Received: from blackmetal.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 2A9D65BC007;
        Wed,  5 Feb 2014 22:06:09 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: fpu.h: fix build when CONFIG_BUG is not set
Date:   Wed,  5 Feb 2014 22:05:44 +0200
Message-Id: <1391630744-32648-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.5.3
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

__enable_fpu produces a build failure when CONFIG_BUG is not set:

In file included from arch/mips/kernel/cpu-probe.c:24:0:
arch/mips/include/asm/fpu.h: In function '__enable_fpu':
arch/mips/include/asm/fpu.h:77:1: error: control reaches end of non-void function [-Werror=return-type]

This is regression introduced in 3.14-rc1. Fix that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/asm/fpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index cfe092fc720d..6b9749540edf 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -74,6 +74,8 @@ static inline int __enable_fpu(enum fpu_mode mode)
 	default:
 		BUG();
 	}
+
+	return SIGFPE;
 }
 
 #define __disable_fpu()							\
-- 
1.8.5.3
