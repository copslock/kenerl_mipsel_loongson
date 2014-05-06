Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 15:00:30 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:36903 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816879AbaEFNA2N80o5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 May 2014 15:00:28 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s46D0MSa027843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 6 May 2014 13:00:22 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.45.49])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s46D0Kuf002474;
        Tue, 6 May 2014 15:00:21 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH RESEND] MIPS: Add __SANE_USERSPACE_TYPES__ to asm/types.h for LL64
Date:   Tue,  6 May 2014 15:55:43 +0300
Message-Id: <1399380943-22082-1-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 1.9.1
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1272
X-purgate-ID: 151667::1399381222-00001564-B1558E5E/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nsn.com
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

Allow 64-bit userspace programs to use ll64 types. The define name
comes from commit 2c9c6ce0199a4d252e20c531cfdc9d24e39235c0 (powerpc:
Add __SANE_USERSPACE_TYPES__ to asm/types.h for LL64).

The patch allows to compile perf on MIPS64 and eliminates the following
warnings:

tests/attr.c:74:4: error: format '%llu' expects argument of type 'long
long unsigned int', but argument 6 has type '__u64' [-Werror=format=]

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/include/uapi/asm/types.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/types.h b/arch/mips/include/uapi/asm/types.h
index 7ac9d0b..f3dd9ff 100644
--- a/arch/mips/include/uapi/asm/types.h
+++ b/arch/mips/include/uapi/asm/types.h
@@ -14,9 +14,12 @@
 /*
  * We don't use int-l64.h for the kernel anymore but still use it for
  * userspace to avoid code changes.
+ *
+ * However, some user programs (e.g. perf) may not want this. They can
+ * flag __SANE_USERSPACE_TYPES__ to get int-ll64.h here.
  */
 #ifndef __KERNEL__
-# if _MIPS_SZLONG == 64
+# if _MIPS_SZLONG == 64 && !defined(__SANE_USERSPACE_TYPES__)
 #  include <asm-generic/int-l64.h>
 # else
 #  include <asm-generic/int-ll64.h>
-- 
1.9.1
