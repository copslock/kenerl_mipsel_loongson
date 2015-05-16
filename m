Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:35:39 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:27828 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011947AbbEPOed2SjmS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:33 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEYPNk004203
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYPm8022335
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:25 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYOTa024954;
        Sat, 16 May 2015 14:34:24 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:24 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Kconfig: Disable SMP/CPS for 64-bit
Date:   Sat, 16 May 2015 10:33:22 -0400
Message-Id: <1431786833-25487-14-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47440
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

From: Markos Chandras <markos.chandras@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 6ca716f2e5571d25a3899c6c5c91ff72ea6d6f5e ]

A 64-bit build for Malta produces far too many build problems
when SMP/CPS is selected. Moreover, there is currently no 64-bit
product with SMP/CPS so we disable SMP/CPS when building for
64-bit until it is properly supported.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8573/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9536ef9..155bb7f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2048,7 +2048,7 @@ config MIPS_CMP
 
 config MIPS_CPS
 	bool "MIPS Coherent Processing System support"
-	depends on SYS_SUPPORTS_MIPS_CPS
+	depends on SYS_SUPPORTS_MIPS_CPS && !64BIT
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-- 
2.1.0
