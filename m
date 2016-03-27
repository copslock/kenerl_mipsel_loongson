Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2016 08:06:53 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34836 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006982AbcC0GGwHKJxP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Mar 2016 08:06:52 +0200
Received: by mail-pf0-f193.google.com with SMTP id u190so16517600pfb.2;
        Sat, 26 Mar 2016 23:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oJxn+gEEn9XTYAscPw3+K2JzkQbaDUTzADzmIT2LThk=;
        b=g3+96BJns/r3yu8k8EXF8SL83Lvf834lLjGVW+WF/v6bn6yEF+jYLyjzJOxCbYagBQ
         KqpzBa3jb+F6Opp1Y3taMJ3uWvNPIJV+Mk6R8QqKBXEkxQkgb5wRwZpdBjm7q+65+LUC
         bSfIaao5au1350Jyhb6mpydgJOOSoqfzHuhf8dexmDhIo9XH+Xqp48KbGra737cSIH1X
         R9VHIy3G4Z6D6aaZ+59pp7mEgwMIaxSgse6klg1btgbmKYcK8iS9dzlBwMBk17C5h5IA
         rPvW/dBAWGHxKa8LuBd+ekd971NURLjrBxnGKXeyFs996kFCYSdWabbtKA1Mdq4gxA3T
         GSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=oJxn+gEEn9XTYAscPw3+K2JzkQbaDUTzADzmIT2LThk=;
        b=WbVlUTDCgT4QKfZXUISxI/+NAZW/S0yrjHZp/n5Z13DTD9B8KeRwp1NNi8Fwvu1Hae
         GG/eJsP+xW0VEAgMbbYGY0EqsuCBm5tuH1xWyMT8ZAVJtL4aNZ1uhNw6i4YXXmx04Vuo
         IPo022SKKjQ+PNZoGafAkd8gjqTZVQbaTqwKcIPVSuBwHXWZxlg1AGv3cWgcfpRtCw4f
         PCOUW24WYw/wFWZwpwfGwfd8S7c+/y0k3L9IeO+8R9a7gltravqVxbMetf/8/thMGjUz
         k6fGeHvLDtiUrzb51aNvfncC5dKNy6iplTtpQz1AAu7lAnIL34fTEjGcMdyBspr7++s/
         kTQQ==
X-Gm-Message-State: AD7BkJKzIkRldPMIHWHnnHRGBKT3z0cvxfvcp8IEsTgcgpsrxKd1ccPO7ODdgTWKDn7t9A==
X-Received: by 10.98.74.200 with SMTP id c69mr32940753pfj.129.1459058806038;
        Sat, 26 Mar 2016 23:06:46 -0700 (PDT)
Received: from [0.0.0.0] (exit-01c.noisetor.net. [173.254.216.68])
        by smtp.googlemail.com with ESMTPSA id w27sm26620444pfa.67.2016.03.26.23.06.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Mar 2016 23:06:45 -0700 (PDT)
Subject: [PATCH 07/31] Add mips-specific parity functions
To:     Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
From:   "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Message-ID: <56F7785F.1090101@gmail.com>
Date:   Sun, 27 Mar 2016 14:06:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-Path: <zhaoxiu.zeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhaoxiu.zeng@gmail.com
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

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
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
2.5.5
