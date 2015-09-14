Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:54:50 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:41925 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013797AbbINPxmq2bSM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:53:42 +0200
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO00DZ3C5CYN30@mailout3.samsung.com>; Tue,
 15 Sep 2015 00:53:36 +0900 (KST)
X-AuditID: cbfee61a-f79a06d000005c6f-4c-55f6ed80d0c7
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id 92.9E.23663.08DE6F55; Tue, 15 Sep 2015 00:53:36 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:53:36 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [RFT PATCH] mips: malta_kvm_guest_defconfig: convert to use libata
 PATA drivers
Date:   Mon, 14 Sep 2015 17:51:50 +0200
Message-id: <1442245918-27631-9-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t9jQd2Gt99CDXqOC1hsnLGe1eLYjkdM
        Fpd3zWGzmDB1ErvF59vbWS3u79vIbnFpj4rF68ez2R04PHp2nmH0OLniJ7PH0ZVrmTz6tqxi
        9Pi8SS6ANYrLJiU1J7MstUjfLoErY/L778wFm4Uqns+/xtbA+Ii/i5GTQ0LARGLS8m5GCFtM
        4sK99WxdjFwcQgKzGCW2rNnPDuH8YpTY8fUWM0gVm4CVxMT2VWAdIgKOEhP7TjKDFDELnGeU
        +LdyH1MXIweHsECUxO17ViA1LAKqEm+u9zCChHkFPCTeneeAWCYncfLYZFYQm1PAU+LTy7dg
        thBQyf1rJ5gmMPIuYGRYxSiRWpBcUJyUnmuYl1quV5yYW1yal66XnJ+7iREcYs+kdjAe3OV+
        iFGAg1GJh1fh/tdQIdbEsuLK3EOMEhzMSiK81ae/hQrxpiRWVqUW5ccXleakFh9ilOZgURLn
        lV35LFRIID2xJDU7NbUgtQgmy8TBKdXA2CSq2K+ocJHvhpEs68prJ941+N+bcjJK0kDCNsFy
        m4dJbkdXX6+pkMadHeHcJZW7v0gd3bFIa15Z+8vlvelL1xSJBCYdmMPi8ifN5cKD1lsRfqvr
        kry3y+qL8SYZPkjuPtS9Pl9vBV+J0cl5Znm/TcPip5zWibn5RiQxbX/ply8VJgeCZu9WYinO
        SDTUYi4qTgQAEHY0Yy0CAAA=
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49189
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

This patch converts malta_kvm_guest_defconfig to use libata
PATA drivers (tc86c001 IDE host driver has no corresponding
libata driver yet so it is not converted).

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Sanjay Lal <sanjayl@kymasys.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

BTW Does this platform really use tc86c001 chipset or has
this defconfig been derived from the one already using
tc86c001 driver?

 arch/mips/configs/malta_kvm_guest_defconfig | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index a7806e8..3b5d591 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -248,17 +248,12 @@ CONFIG_ATA_OVER_ETH=m
 CONFIG_VIRTIO_BLK=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_PIIX=y
-CONFIG_BLK_DEV_IT8213=m
 CONFIG_BLK_DEV_TC86C001=m
 CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=m
-CONFIG_BLK_DEV_SD=m
+CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_CHR_DEV_OSST=m
-CONFIG_BLK_DEV_SR=m
+CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_MULTI_LUN=y
@@ -274,6 +269,13 @@ CONFIG_SCSI_AACRAID=m
 CONFIG_SCSI_AIC7XXX=m
 CONFIG_AIC7XXX_RESET_DELAY_MS=15000
 # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
+CONFIG_ATA=y
+CONFIG_ATA_PIIX=y
+CONFIG_PATA_IT8213=m
+CONFIG_PATA_OLDPIIX=y
+CONFIG_PATA_MPIIX=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_LEGACY=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
 CONFIG_MD_LINEAR=m
-- 
1.9.1
