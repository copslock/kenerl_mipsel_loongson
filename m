Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 19:39:22 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:53030 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012354AbcBQSjTuLuY4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Feb 2016 19:39:19 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 17 Feb 2016 10:17:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,461,1449561600"; 
   d="scan'208";a="905287862"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.39.121])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2016 10:17:03 -0800
Subject: [PATCH] signals, ia64, mips: update arch-specific siginfos with pkeys field
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org, Dave Hansen <dave@sr71.net>,
        dave.hansen@linux.intel.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org
From:   Dave Hansen <dave@sr71.net>
Date:   Wed, 17 Feb 2016 10:17:03 -0800
Message-Id: <20160217181703.E99B6656@viggo.jf.intel.com>
Return-Path: <dave@sr71.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52107
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


This fixes a compile error that Ingo was hitting with MIPS when the
x86 pkeys patch set is applied.

ia64 and mips have separate definitions for siginfo from the
generic one.  Patch them to have the pkey fields.

Note that this is exactly what we did for MPX as well.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-mips@linux-mips.org
Cc: linux-ia64@vger.kernel.org
---

 b/arch/ia64/include/uapi/asm/siginfo.h |   13 +++++++++----
 b/arch/mips/include/uapi/asm/siginfo.h |   13 +++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff -puN arch/ia64/include/uapi/asm/siginfo.h~pkeys-09-1-siginfo-for-mips-ia64 arch/ia64/include/uapi/asm/siginfo.h
--- a/arch/ia64/include/uapi/asm/siginfo.h~pkeys-09-1-siginfo-for-mips-ia64	2016-02-17 09:32:06.001815266 -0800
+++ b/arch/ia64/include/uapi/asm/siginfo.h	2016-02-17 09:32:06.010815672 -0800
@@ -63,10 +63,15 @@ typedef struct siginfo {
 			unsigned int _flags;	/* see below */
 			unsigned long _isr;	/* isr */
 			short _addr_lsb;	/* lsb of faulting address */
-			struct {
-				void __user *_lower;
-				void __user *_upper;
-			} _addr_bnd;
+			union {
+				/* used when si_code=SEGV_BNDERR */
+				struct {
+					void __user *_lower;
+					void __user *_upper;
+				} _addr_bnd;
+				/* used when si_code=SEGV_PKUERR */
+				u64 _pkey;
+			};
 		} _sigfault;
 
 		/* SIGPOLL */
diff -puN arch/mips/include/uapi/asm/siginfo.h~pkeys-09-1-siginfo-for-mips-ia64 arch/mips/include/uapi/asm/siginfo.h
--- a/arch/mips/include/uapi/asm/siginfo.h~pkeys-09-1-siginfo-for-mips-ia64	2016-02-17 09:32:06.003815357 -0800
+++ b/arch/mips/include/uapi/asm/siginfo.h	2016-02-17 09:32:06.010815672 -0800
@@ -86,10 +86,15 @@ typedef struct siginfo {
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
 			short _addr_lsb;
-			struct {
-				void __user *_lower;
-				void __user *_upper;
-			} _addr_bnd;
+			union {
+				/* used when si_code=SEGV_BNDERR */
+				struct {
+					void __user *_lower;
+					void __user *_upper;
+				} _addr_bnd;
+				/* used when si_code=SEGV_PKUERR */
+				u64 _pkey;
+			};
 		} _sigfault;
 
 		/* SIGPOLL, SIGXFSZ (To do ...)	 */
_
