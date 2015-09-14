Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:53:17 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:54738 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013785AbbINPwyr3VnM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:52:54 +0200
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO02O2VC3YQW90@mailout3.samsung.com>; Tue,
 15 Sep 2015 00:52:46 +0900 (KST)
X-AuditID: cbfee61b-f79d56d0000048c5-4c-55f6ed4e8016
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id F1.A4.18629.E4DE6F55; Tue, 15 Sep 2015 00:52:46 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:52:46 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [RFT PATCH] mips: fuloong2e_defconfig: convert to use libata PATA
 drivers
Date:   Mon, 14 Sep 2015 17:51:45 +0200
Message-id: <1442245918-27631-4-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xoK7f22+hBo/u81lsnLGe1eLYjkdM
        Fpd3zWGzmDB1ErvFpT0qFnOeT2V3YPPYOesuu8fRlWuZPPq2rGL0+LxJLoAlissmJTUnsyy1
        SN8ugSvj0KY+5oLr/BUvb65ga2DcwNvFyMkhIWAi0drzkw3CFpO4cG89kM3FISQwi1Fi9q0p
        zBDOL0aJ5xuXM4FUsQlYSUxsX8UIYosIOEpM7DvJDGIzC1RL9E49C1YjLBAisaL3KVgNi4Cq
        RPPWCWA1vAIeEj9+fWGH2CYncfLYZFYQm1PAU+LTy7dgthBQzf1rJ5gmMPIuYGRYxSiRWpBc
        UJyUnmuUl1quV5yYW1yal66XnJ+7iREcRs+kdzAe3uV+iFGAg1GJh1fx/tdQIdbEsuLK3EOM
        EhzMSiK81ae/hQrxpiRWVqUW5ccXleakFh9ilOZgURLnlV35LFRIID2xJDU7NbUgtQgmy8TB
        KdXAmCq8wYaD5S//0lkcXssKaqeoPeQ5orWt8ceebaJdfK/fZRhv+HCyL85M9b1035WQWsU5
        mwzNbLx89yzYFn+NR0diskz01F1mdguDRfmrdh4yc2WU3nPi76YZz/8UbZj7vcH8hY8EQ7/w
        e4WYta3PuxUCGh9U7P88rcG7sYGxb1ZaUF/o+xh1JZbijERDLeai4kQA/2oE+h8CAAA=
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49184
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

This patch converts fuloong2e_defconfig to use libata PATA
drivers.

Cc: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/fuloong2e_defconfig | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index a75c65d..8743589 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -34,7 +34,7 @@ CONFIG_MIPS32_N32=y
 CONFIG_PM=y
 # CONFIG_SUSPEND is not set
 CONFIG_HIBERNATION=y
-CONFIG_PM_STD_PARTITION="/dev/hda3"
+CONFIG_PM_STD_PARTITION="/dev/sda3"
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -114,20 +114,16 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_TASK_IOCTL=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_VIA82CXXX=y
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_PATA_VIA=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 CONFIG_MACVLAN=m
 CONFIG_VETH=m
-- 
1.9.1
