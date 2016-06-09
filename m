Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:21:32 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34873 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041462AbcFIVS5rZhLE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:18:57 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7Ls-0005Lf-5F; Thu, 09 Jun 2016 21:18:56 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7Lp-0006C8-FI; Thu, 09 Jun 2016 14:18:53 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>, Petr Malat <oss@malat.biz>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 100/206] MIPS: Fix uapi include in exported asm/siginfo.h
Date:   Thu,  9 Jun 2016 14:15:09 -0700
Message-Id: <1465507015-23052-101-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: James Hogan <james.hogan@imgtec.com>

commit 987e5b834467c9251ca584febda65ef8f66351a9 upstream.

Since commit 8cb48fe169dd ("MIPS: Provide correct siginfo_t.si_stime"),
MIPS' uapi/asm/siginfo.h has included uapi/asm-generic/siginfo.h
directly before defining MIPS' struct siginfo, in order to get the
necessary definitions needed for the siginfo struct without the generic
copy_siginfo() hitting compiler errors due to struct siginfo not yet
being defined.

Now that the generic copy_siginfo() is moved out to linux/signal.h we
can safely include asm-generic/siginfo.h before defining the MIPS
specific struct siginfo, which avoids the uapi/ include as well as
breakage due to generic copy_siginfo() being defined before struct
siginfo.

Reported-by: Christopher Ferris <cferris@google.com>
Fixes: 8cb48fe169dd ("MIPS: Provide correct siginfo_t.si_stime")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Petr Malat <oss@malat.biz>
Cc: linux-mips@linux-mips.org
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/uapi/asm/siginfo.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
index 03ec109..e2b5337 100644
--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -28,7 +28,7 @@
 
 #define __ARCH_SIGSYS
 
-#include <uapi/asm-generic/siginfo.h>
+#include <asm-generic/siginfo.h>
 
 /* We can't use generic siginfo_t, because our si_code and si_errno are swapped */
 typedef struct siginfo {
@@ -118,6 +118,4 @@ typedef struct siginfo {
 #define SI_TIMER __SI_CODE(__SI_TIMER, -3) /* sent by timer expiration */
 #define SI_MESGQ __SI_CODE(__SI_MESGQ, -4) /* sent by real time mesq state change */
 
-#include <asm-generic/siginfo.h>
-
 #endif /* _UAPI_ASM_SIGINFO_H */
-- 
2.7.4
