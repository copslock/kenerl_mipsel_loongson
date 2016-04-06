Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 11:00:07 +0200 (CEST)
Received: from m50-133.163.com ([123.125.50.133]:48303 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006696AbcDFJAFdJfgG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Apr 2016 11:00:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=fCJOoWJHYSKtRIRxv1
        fqf5ubl0kZSApX0CeEYHt6W54=; b=DJQ3+iDlAkVja3G+KDqcFYf6StrELxt36E
        fYoZHfik1TS54GH7twM+HSeEayngvdwSGBUwlEfeUKICvfzVXxqzS316uYDerbSw
        L3GpfKPqxD/MEiZXvje5iXwRlSFDaVh1I7mA8yPdjpS6EVKmJSugrNoKBqyE5O4s
        HMjuPFypc=
Received: from zhaoxiuzeng-VirtualBox.spreadtrum.com (unknown [112.95.225.98])
        by smtp3 (Coremail) with SMTP id DdGowAAHRZLzzwRXcmCRAQ--.14759S2;
        Wed, 06 Apr 2016 16:59:35 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     ralf@linux-mips.org, Leonid.Yegoshin@imgtec.com,
        macro@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH v2 06/30] Add mips-specific parity functions
Date:   Wed,  6 Apr 2016 16:59:29 +0800
Message-Id: <1459933169-6749-1-git-send-email-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <57031D9D.801@gmail.com>
References: <57031D9D.801@gmail.com>
X-CM-TRANSID: DdGowAAHRZLzzwRXcmCRAQ--.14759S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4xCw13Cr43XryDZw45Awb_yoW8uFWkpa
        1kCrn5JrWvg34xAFWakFn2vF4ftrs5Wr1aqrWa9ryvvFy3tF1UJrnagr4DAr18KF4v9F48
        urZxGFyDWwsFvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAGYJUUUUU=
X-Originating-IP: [112.95.225.98]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiJRdDgFUL+7G4KQAAs0
Return-Path: <zengzhaoxiu@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52893
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
 arch/mips/include/asm/arch_parity.h | 44 +++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/bitops.h      |  3 +++
 2 files changed, 47 insertions(+)
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
+#include <asm-generic/bitops/arch_hweight.h>
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
