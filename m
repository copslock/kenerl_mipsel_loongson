Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 12:24:01 +0200 (CEST)
Received: from m50-132.163.com ([123.125.50.132]:53750 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009086AbcDFKX7vqn6F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Apr 2016 12:23:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=RdQdNT6g+oJsWp9QaO
        QSPp71zsW5y1i0soaEJ+sb+X8=; b=KJGNmO7xfcAr6JDPlRRzdldxisacY0qLf5
        9sWKp79mi2RzLT/n13P5co/DluLMr757O1xoll+Ls/5rv8bBbAczGlUo1eseJQQ0
        EVQZKRZJdJJpc+npGjsFf0zbtDsTlxi2HPw1IK7V72Z3Zd2AyAMAF4iFXQy56cpc
        vR6b9ELVQ=
Received: from zhaoxiuzeng-VirtualBox.spreadtrum.com (unknown [112.95.225.98])
        by smtp2 (Coremail) with SMTP id DNGowABnnv2s4wRXdD+MAQ--.18711S2;
        Wed, 06 Apr 2016 18:23:44 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     ralf@linux-mips.org, Leonid.Yegoshin@imgtec.com,
        macro@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH v2 06/30] Add mips-specific parity functions
Date:   Wed,  6 Apr 2016 18:23:24 +0800
Message-Id: <1459938204-8761-1-git-send-email-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459933169-6749-1-git-send-email-zengzhaoxiu@163.com>
References: <1459933169-6749-1-git-send-email-zengzhaoxiu@163.com>
X-CM-TRANSID: DNGowABnnv2s4wRXdD+MAQ--.18711S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4xCw4UZFyrKr15JF43KFg_yoW8urWxpa
        1kCrn5JrWvg34xAFWakFn2vF4ftrs5Wr1YqrWa9ryvyFy3tF1UJrnagw1DAr18KF409F48
        urZxGF1DWwsFvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVUDAUUUUU=
X-Originating-IP: [112.95.225.98]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/xtbBDRFDgFaDmOfV0wAAsz
Return-Path: <zengzhaoxiu@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52895
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

Lifted from arch_hweight.h

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 arch/mips/include/asm/arch_parity.h | 43 +++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/bitops.h      |  3 +++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/mips/include/asm/arch_parity.h

diff --git a/arch/mips/include/asm/arch_parity.h b/arch/mips/include/asm/arch_parity.h
new file mode 100644
index 0000000..23b3c23
--- /dev/null
+++ b/arch/mips/include/asm/arch_parity.h
@@ -0,0 +1,44 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+#ifndef _ASM_ARCH_PARITY_H
+#define _ASM_ARCH_PARITY_H
+
+#ifdef ARCH_HAS_USABLE_BUILTIN_POPCOUNT
+
+#include <asm/types.h>
+
+static inline unsigned int __arch_parity32(unsigned int w)
+{
+	return __builtin_popcount(w) & 1;
+}
+
+static inline unsigned int __arch_parity16(unsigned int w)
+{
+	return __arch_parity32(w & 0xffff);
+}
+
+static inline unsigned int __arch_parity8(unsigned int w)
+{
+	return __arch_parity32(w & 0xff);
+}
+
+static inline unsigned int __arch_parity4(unsigned int w)
+{
+	return __arch_parity32(w & 0xf);
+}
+
+static inline unsigned int __arch_parity64(__u64 w)
+{
+	return (unsigned int)__builtin_popcountll(w) & 1;
+}
+
+#else
+#include <asm-generic/bitops/arch_parity.h>
+#endif
+
+#endif /* _ASM_ARCH_PARITY_H */
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index ce9666c..0b87734 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -626,6 +626,9 @@ static inline int ffs(int word)
 #include <asm/arch_hweight.h>
 #include <asm-generic/bitops/const_hweight.h>
 
+#include <asm/arch_parity.h>
+#include <asm-generic/bitops/const_parity.h>
+
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 
-- 
2.5.0
