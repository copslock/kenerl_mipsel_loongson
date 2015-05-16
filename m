Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:35:22 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:40131 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012783AbbEPOe2UAsUK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:28 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEYEcF007040
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYDf5012001
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:14 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYD3u024945;
        Sat, 16 May 2015 14:34:13 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:13 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: OCTEON: fix PCI interrupt mapping for D-Link DSR-1000N
Date:   Sat, 16 May 2015 10:33:15 -0400
Message-Id: <1431786833-25487-7-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47439
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

From: Aaro Koskinen <aaro.koskinen@iki.fi>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit b083518c52ab75a345d668ca7fa41e530df08d51 ]

Fix PCI interrupt mapping for DSR1000N. This will get the PCI slot
interrupts working. The mapping is based on D-Link GPL tarball.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9593/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/pci/pci-octeon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 1fa13ee..14d3351 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -214,6 +214,8 @@ const char *octeon_get_pci_interrupts(void)
 		return "AAABAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
 	case CVMX_BOARD_TYPE_BBGW_REF:
 		return "AABCD";
+	case CVMX_BOARD_TYPE_CUST_DSR1000N:
+		return "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC";
 	case CVMX_BOARD_TYPE_THUNDER:
 	case CVMX_BOARD_TYPE_EBH3000:
 	default:
-- 
2.1.0
