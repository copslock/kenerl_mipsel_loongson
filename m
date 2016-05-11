Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 11:11:11 +0200 (CEST)
Received: from m50-132.163.com ([123.125.50.132]:55215 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026721AbcEKJLGowcbB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 11:11:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=/0JbTOngN7z1Jdd3nN
        j2mm4Y35a7hmB0kmpA40RpoXg=; b=awUM+2Ra4pU26uF2LB0ViWm9eyTvlChMln
        mgVoWSypO56hz99xQopVmFe85/asqlPP41R/Nd5V4Sn5j5NA/ufsS1axJI7HDedu
        7lvW+AHolmLw5BJa4AGz9aEbceXdOnkY/8C/VoocSLMyeIO+qwZoTnmCPPKYGrnB
        hTkM7N9lw=
Received: from zhaoxiuzeng-VirtualBox.spreadtrum.com (unknown [112.95.225.98])
        by smtp2 (Coremail) with SMTP id DNGowAA3K5we9zJXRsBRAA--.15858S2;
        Wed, 11 May 2016 17:10:58 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     linux-kernel@vger.kernel.org
Cc:     Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [patch V4 06/31] bitops: Tile and MIPS (if has usable __builtin_popcount) use popcount parity functions
Date:   Wed, 11 May 2016 17:10:47 +0800
Message-Id: <1462957850-24540-1-git-send-email-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
X-CM-TRANSID: DNGowAA3K5we9zJXRsBRAA--.15858S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyDuFyfAr4kArWrJw4DXFb_yoW8WF45pF
        1DCF1kJrZ5K34UXFWjkrnFvF43twsxGF43trWY9asFyF17tw4jyFsY9F1DJw1kXayjqrW5
        Wr9rGryDJa1IvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bUxhJUUUUU=
X-Originating-IP: [112.95.225.98]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/xtbBDQJmgFaDm7EZ8AAAs-
Return-Path: <zengzhaoxiu@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zengzhaoxiu@163.com
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

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]
---
 arch/mips/include/asm/bitops.h | 7 +++++++
 arch/tile/include/asm/bitops.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index ce9666c..4192068 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -626,6 +626,13 @@ static inline int ffs(int word)
 #include <asm/arch_hweight.h>
 #include <asm-generic/bitops/const_hweight.h>
 
+#ifdef ARCH_HAS_USABLE_BUILTIN_POPCOUNT
+#include <asm-generic/bitops/popc-parity.h>
+#else
+#include <asm-generic/bitops/arch_parity.h>
+#endif
+#include <asm-generic/bitops/const_parity.h>
+
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 
diff --git a/arch/tile/include/asm/bitops.h b/arch/tile/include/asm/bitops.h
index 20caa34..4dd89d8 100644
--- a/arch/tile/include/asm/bitops.h
+++ b/arch/tile/include/asm/bitops.h
@@ -85,6 +85,8 @@ static inline unsigned long __arch_hweight64(__u64 w)
 #include <asm-generic/bitops/builtin-__fls.h>
 #include <asm-generic/bitops/builtin-ffs.h>
 #include <asm-generic/bitops/const_hweight.h>
+#include <asm-generic/bitops/popc-parity.h>
+#include <asm-generic/bitops/const_parity.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/sched.h>
-- 
2.7.4
