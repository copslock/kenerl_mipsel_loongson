Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 17:55:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45790 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993971AbdGKPzwxiD3B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2017 17:55:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1CBADBB0E6681;
        Tue, 11 Jul 2017 16:55:43 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 11 Jul 2017 16:55:46 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        James Hartley <james.hartley@sondrel.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: pistachio: Enable Root FS on NFS in defconfig
Date:   Tue, 11 Jul 2017 16:55:40 +0100
Message-ID: <1499788540-20773-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

When the upstream kernel pistachio_defconfig is built & tested on the
ci40 platform the current lack of these options leads to essentially
false failures when the RFS fails to mount.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/configs/pistachio_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/configs/pistachio_defconfig b/arch/mips/configs/pistachio_defconfig
index 7d32fbbca962..3aa17c5ffed0 100644
--- a/arch/mips/configs/pistachio_defconfig
+++ b/arch/mips/configs/pistachio_defconfig
@@ -47,6 +47,8 @@ CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
@@ -292,7 +294,8 @@ CONFIG_SQUASHFS_LZO=y
 CONFIG_PSTORE=y
 CONFIG_PSTORE_CONSOLE=y
 CONFIG_PSTORE_RAM=y
-# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ASCII=m
-- 
2.7.4
