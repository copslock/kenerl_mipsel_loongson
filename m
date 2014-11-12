Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 18:11:15 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:63615 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013534AbaKLRLKt81ts (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Nov 2014 18:11:10 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 12 Nov 2014 09:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,370,1413270000"; 
   d="scan'208";a="621313775"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.23.232.122])
  by fmsmga001.fm.intel.com with ESMTP; 12 Nov 2014 09:04:59 -0800
Subject: [PATCH 05/11] x86, mpx: add MPX to disaabled features
To:     hpa@zytor.com
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, Dave Hansen <dave@sr71.net>,
        dave.hansen@linux.intel.com
From:   Dave Hansen <dave@sr71.net>
Date:   Wed, 12 Nov 2014 09:04:59 -0800
References: <20141112170443.B4BD0899@viggo.jf.intel.com>
In-Reply-To: <20141112170443.B4BD0899@viggo.jf.intel.com>
Message-Id: <20141112170459.096F1B2E@viggo.jf.intel.com>
Return-Path: <dave@sr71.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@sr71.net
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


From: Dave Hansen <dave.hansen@linux.intel.com>

This allows us to use cpu_feature_enabled(X86_FEATURE_MPX) as
both a runtime and compile-time check.

When CONFIG_X86_INTEL_MPX is disabled,
cpu_feature_enabled(X86_FEATURE_MPX) will evaluate at
compile-time to 0. If CONFIG_X86_INTEL_MPX=y, then the cpuid
flag will be checked at runtime.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
---

 b/arch/x86/include/asm/disabled-features.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff -puN arch/x86/include/asm/disabled-features.h~2014-10-14-04_12-x86-mpx-add-MPX-to-disaabled-features arch/x86/include/asm/disabled-features.h
--- a/arch/x86/include/asm/disabled-features.h~2014-10-14-04_12-x86-mpx-add-MPX-to-disaabled-features	2014-11-12 08:49:24.951846882 -0800
+++ b/arch/x86/include/asm/disabled-features.h	2014-11-12 08:49:24.954847017 -0800
@@ -10,6 +10,12 @@
  * cpu_feature_enabled().
  */
 
+#ifdef CONFIG_X86_INTEL_MPX
+# define DISABLE_MPX	0
+#else
+# define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
+#endif
+
 #ifdef CONFIG_X86_64
 # define DISABLE_VME		(1<<(X86_FEATURE_VME & 31))
 # define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
@@ -34,6 +40,6 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	0
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	0
+#define DISABLED_MASK9	(DISABLE_MPX)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
_
