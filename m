Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 23:41:20 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:23345 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042098AbcFCVi7OY7H4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 23:38:59 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u53Lcmwe027056
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u53Lckbt024446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:47 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u53Lcj6f023032;
        Fri, 3 Jun 2016 21:38:46 GMT
Received: from lappy.us.oracle.com (/10.154.190.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jun 2016 14:38:45 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>, Petr Malat <oss@malat.biz>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: Fix uapi include in exported asm/siginfo.h
Date:   Fri,  3 Jun 2016 17:36:27 -0400
Message-Id: <1464989831-16666-92-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
References: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 987e5b834467c9251ca584febda65ef8f66351a9 ]

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
Cc: <stable@vger.kernel.org> # 4.0-
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
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
2.5.0
