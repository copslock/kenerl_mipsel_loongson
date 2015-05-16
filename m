Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:36:28 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:27836 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026208AbbEPOehCah0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:37 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEYLJt004177
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYJGp006261
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:20 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYJnd012211;
        Sat, 16 May 2015 14:34:19 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:19 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Adrien Schildknecht <adrien+dev@schischi.me>, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] SSB: fix Kconfig dependencies
Date:   Sat, 16 May 2015 10:33:19 -0400
Message-Id: <1431786833-25487-11-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47443
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

From: Adrien Schildknecht <adrien+dev@schischi.me>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 179fa46fb666c8f2aa2bbb1f3114d5d826d59d3d ]

The commit 21400f252a97 ("MIPS: BCM47XX: Make ssb init NVRAM instead of
bcm47xx polling it") introduces a dependency to SSB_SFLASH but did not
add it to the Kconfig.

drivers/ssb/driver_mipscore.c:216:36: error: 'struct ssb_mipscore' has no
member named 'sflash'
  struct ssb_sflash *sflash = &mcore->sflash;
                                    ^
drivers/ssb/driver_mipscore.c:249:12: error: dereferencing pointer to
incomplete type
  if (sflash->present) {
            ^

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
Cc: m@bues.ch
Cc: zajec5@gmail.com
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9598/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/ssb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 75b3603..f0d22cd 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -130,6 +130,7 @@ config SSB_DRIVER_MIPS
 	bool "SSB Broadcom MIPS core driver"
 	depends on SSB && MIPS
 	select SSB_SERIAL
+	select SSB_SFLASH
 	help
 	  Driver for the Sonics Silicon Backplane attached
 	  Broadcom MIPS core.
-- 
2.1.0
