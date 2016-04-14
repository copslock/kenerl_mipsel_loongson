Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 05:06:30 +0200 (CEST)
Received: from m50-135.163.com ([123.125.50.135]:49058 "EHLO m50-135.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006657AbcDNDG1BKFNW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Apr 2016 05:06:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VadeU7cruCenVwpSpH
        x9mLokMywRq4NhJxZ2lh9IhDs=; b=MUtMqZmWicb2Mq4lGEgUcqyum0NIrWNMgB
        O+iP9NXOfz5G/pqMPvOcEjcu7FvUa3MhlmjsooMkwRdWGDNiLpIAYeBB9d0DY1Zl
        c6MpcnyF5Gtiio2S51yH9AIMU4h5hXprBw9rK/884vZoESipYhXa7o6pGhGQyHI+
        8+74OiH+s=
Received: from zhaoxiuzeng-VirtualBox.spreadtrum.com (unknown [112.95.225.98])
        by smtp5 (Coremail) with SMTP id D9GowAB3f6sbCQ9XeSLcCQ--.24885S2;
        Thu, 14 Apr 2016 11:06:07 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     linux-kernel@vger.kernel.org
Cc:     Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH V3 06/29] Tile and MIPS (if has usable __builtin_popcount) use popcount parity functions
Date:   Thu, 14 Apr 2016 11:05:59 +0800
Message-Id: <1460603162-4670-1-git-send-email-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
X-CM-TRANSID: D9GowAB3f6sbCQ9XeSLcCQ--.24885S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1rCF1ktrWxXFWftFWfuFg_yoW8Xw4kpF
        1DCF1kJrZ5G34UXFWjkrnFvF43twsxGF43trWY9asFyF17ta1jyFsY9F1DJw1kXayjqrW5
        Wr9rGryUJa1IvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b5Wl9UUUUU=
X-Originating-IP: [112.95.225.98]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiMB9LgFWBVYMT3wAAsq
Return-Path: <zengzhaoxiu@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52978
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
2.5.0
