Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:56:20 +0200 (CEST)
Received: from mailout1.samsung.com ([203.254.224.24]:36992 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013800AbbINPzA1IdqM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:55:00 +0200
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO00AG9C7EJ6B0@mailout1.samsung.com>; Tue,
 15 Sep 2015 00:54:50 +0900 (KST)
X-AuditID: cbfee61b-f79d56d0000048c5-c1-55f6edcaf3c0
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id 09.B4.18629.ACDE6F55; Tue, 15 Sep 2015 00:54:50 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:54:50 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [RFT PATCH] mips: mpc30x_defconfig: convert to use libata PATA drivers
Date:   Mon, 14 Sep 2015 17:51:56 +0200
Message-id: <1442245918-27631-15-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsVy+t9jQd1Tb7+FGmx+aWGxccZ6VotjOx4x
        WVzeNYfNYsLUSewWl/aoOLB6HF25lsmjb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4Mro7X7EW
        /OGp2PQ7tIHxLVcXIweHhICJxL99eV2MnECmmMSFe+vZuhi5OIQEZjFKNK3fzQ7h/GKU2HDo
        MxtIFZuAlcTE9lWMILaIgKPExL6TzCA2s0C4xLmvV5hAbGEBf4ltz1rB4iwCqhJbOjaxgSzj
        FfCU6J/jDLFMTuLkscmsIDYnUPjTy7dgtpCAh8T9ayeYJjDyLmBkWMUokVqQXFCclJ5rlJda
        rlecmFtcmpeul5yfu4kRHCzPpHcwHt7lfohRgINRiYdX8f7XUCHWxLLiytxDjBIczEoivNWn
        v4UK8aYkVlalFuXHF5XmpBYfYpTmYFES55Vd+SxUSCA9sSQ1OzW1ILUIJsvEwSnVwCi32urE
        iZ7NCRPt9XLlvmQ2VxrOuabu+Oav2drJLcyTSq/vq5zwxb2o5U3CqT1yOYkzluxdfKd2ZeqG
        Z3p5ztbB7VOORT72XuszNX13ymz5t9vFZbZbPltovmfR9JqkJ5edtyuGyifs/Z3NbqjqeOO5
        8DWzPX1t285G60fvbpRualm43F/+1jwlluKMREMt5qLiRAABH/NCEgIAAA==
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49194
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

This patch converts mpc30x_defconfig to use libata PATA
drivers.

PS This platform still uses "ide0=base[,ctl[,irq]]" hack in
its defconfig.  The hack itself has been removed in 2008 and
this platform should be converted to using PATA platform host
driver (pata_platform) instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/mpc30x_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index 7a34660..a2c045f 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -27,9 +27,9 @@ CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_NETWORK_SECMARK=y
 CONFIG_CONNECTOR=m
 CONFIG_ATA_OVER_ETH=m
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
-- 
1.9.1
