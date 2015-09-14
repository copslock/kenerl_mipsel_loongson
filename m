Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:53:35 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:37376 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013784AbbINPxCgjEFM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:53:02 +0200
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO035POC47BJ80@mailout2.samsung.com>; Tue,
 15 Sep 2015 00:52:55 +0900 (KST)
X-AuditID: cbfee61a-f79a06d000005c6f-2d-55f6ed575f24
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id 1F.8E.23663.75DE6F55; Tue, 15 Sep 2015 00:52:55 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:52:55 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Brian Murphy <brian@murphy.dk>
Subject: [RFT PATCH] mips: lasat_defconfig: convert to use libata PATA drivers
Date:   Mon, 14 Sep 2015 17:51:46 +0200
Message-id: <1442245918-27631-5-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42I5/e+xoG7422+hBtPuqFhsnLGe1WLe7X3s
        Fsd2PGKyuLxrDpvFhKmT2C0u7VFxYPM4unItk8fOM7/ZPfq2rGL0+LxJLoAlissmJTUnsyy1
        SN8ugSvjUIt+wR/uir+bLBsY+7m6GDk5JARMJN7tXsUMYYtJXLi3nq2LkYtDSGAWo8TRnaeZ
        IJxfjBL/Fu0Cq2ITsJKY2L6KEcQWEXCUmNh3EizOLFAu8f7iFFYQW1jAT+Lt7WtgNSwCqhI9
        /36ygNi8Ah4Sc39NY4fYJidx8thksHpOAU+JTy/fgtlCQDX3r51gmsDIu4CRYRWjRGpBckFx
        UnquYV5quV5xYm5xaV66XnJ+7iZGcAg9k9rBeHCX+yFGAQ5GJR5ehftfQ4VYE8uKK3MPMUpw
        MCuJ8Faf/hYqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFd25bNQIYH0xJLU7NTUgtQimCwTB6dU
        A+PilczpEXeEvs6Srnmz7cb5eHWj8rYp6RfMPOM/PNmSu+Zr1OfN7SZb37zMFtPQTmVd9VN0
        hv+jN7vut96xO3hIQOxYln8Oo/ECJ6Gfnp7rjj30TTllLC3dzFxzQ+KCwxGmS7IyUVGHvyy9
        rvPt4EVFxQtz61pD892Z5+5UuhQY+uD84Tt/Gp4osRRnJBpqMRcVJwIANRfXPh0CAAA=
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: b.zolnierkie@samsung.com
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

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.  However there are still
some users (mostly old or/and embedded non-x86 systems) that
have not converted from using IDE subsystem to libata PATA
drivers.  This doesn't seem to be good thing in the long-term
for Linux as while there is less and less PATA systems left
in use:

* testing efforts are divided between two subsystems

* having duplicate drivers for same hardware confuses users

This patch converts lasat_defconfig to use libata PATA
drivers.

Cc: Brian Murphy <brian@murphy.dk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/lasat_defconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/configs/lasat_defconfig b/arch/mips/configs/lasat_defconfig
index 0179c7f..e620a2c 100644
--- a/arch/mips/configs/lasat_defconfig
+++ b/arch/mips/configs/lasat_defconfig
@@ -35,11 +35,11 @@ CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_CMD64X=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_PATA_CMD64X=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
-- 
1.9.1
