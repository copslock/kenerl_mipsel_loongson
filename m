Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jul 2015 05:05:27 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:47468 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007238AbbGDDFZBfKqU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Jul 2015 05:05:25 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t6435A83011354
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 4 Jul 2015 03:05:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t64358ZV003343
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 4 Jul 2015 03:05:08 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t643589Z017861;
        Sat, 4 Jul 2015 03:05:08 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.154.162.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jul 2015 20:05:08 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Fix KVM guest fixmap address
Date:   Fri,  3 Jul 2015 23:02:33 -0400
Message-Id: <1435978997-14393-104-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1435978997-14393-1-git-send-email-sasha.levin@oracle.com>
References: <1435978997-14393-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48062
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

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 8e748c8d09a9314eedb5c6367d9acfaacddcdc88 ]

KVM guest kernels for trap & emulate run in user mode, with a modified
set of kernel memory segments. However the fixmap address is still in
the normal KSeg3 region at 0xfffe0000 regardless, causing problems when
cache alias handling makes use of them when handling copy on write.

Therefore define FIXADDR_TOP as 0x7ffe0000 in the guest kernel mapped
region when CONFIG_KVM_GUEST is defined.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # v3.10+
Patchwork: https://patchwork.linux-mips.org/patch/9887/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/include/asm/mach-generic/spaces.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 9488fa5..afc96ec 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -94,7 +94,11 @@
 #endif
 
 #ifndef FIXADDR_TOP
+#ifdef CONFIG_KVM_GUEST
+#define FIXADDR_TOP		((unsigned long)(long)(int)0x7ffe0000)
+#else
 #define FIXADDR_TOP		((unsigned long)(long)(int)0xfffe0000)
 #endif
+#endif
 
 #endif /* __ASM_MACH_GENERIC_SPACES_H */
-- 
2.1.0
