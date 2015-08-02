Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2015 10:45:07 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:24892 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010977AbbHBIot3Sqbo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Aug 2015 10:44:49 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t728ibKW016014
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 2 Aug 2015 08:44:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t728ibaV029924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sun, 2 Aug 2015 08:44:37 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t728iasB019066;
        Sun, 2 Aug 2015 08:44:36 GMT
Received: from yuval-net-srv-ca.us.oracle.com (/10.211.3.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Aug 2015 01:44:36 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     yuval.shaia@oracle.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org> # v4.0-, linux-mips@linux-mips.org,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 23/30] MIPS: Require O32 FP64 support for MIPS64 with O32 compat
Date:   Sun,  2 Aug 2015 01:34:19 -0700
Message-Id: <1438504466-21888-24-git-send-email-yuval.shaia@oracle.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1438504466-21888-1-git-send-email-yuval.shaia@oracle.com>
References: <1438504466-21888-1-git-send-email-yuval.shaia@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <yuval.shaia@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuval.shaia@oracle.com
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

From: Paul Burton <paul.burton@imgtec.com>

MIPS32r6 code requires FP64 (ie. FR=1) support. Building a kernel with
support for MIPS32r6 binaries but without support for O32 with FP64 is
therefore a problem which can lead to incorrectly executed userland.

CONFIG_MIPS_O32_FP64_SUPPORT is already selected when the kernel is
configured for MIPS32r6, but not when the kernel is configured for
MIPS64r6 with O32 compat support. Select CONFIG_MIPS_O32_FP64_SUPPORT in
such configurations to prevent building kernels which execute MIPS32r6
userland incorrectly.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: <stable@vger.kernel.org> # v4.0-
Cc: linux-mips@linux-mips.org
Cc: Matthew Fortune <matthew.fortune@imgtec.com>
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10674/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index aab7e46..66dc359 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1427,6 +1427,7 @@ config CPU_MIPS64_R6
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
 	select GENERIC_CSUM
+	select MIPS_O32_FP64_SUPPORT if MIPS32_O32
 	help
 	  Choose this option to build a kernel for release 6 or later of the
 	  MIPS64 architecture.  New MIPS processors, starting with the Warrior
-- 
1.7.1
