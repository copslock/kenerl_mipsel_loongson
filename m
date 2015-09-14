Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:52:25 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:44370 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013616AbbINPwXdr9VM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:52:23 +0200
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO01T21C2TG520@mailout4.samsung.com>; Tue,
 15 Sep 2015 00:52:16 +0900 (KST)
X-AuditID: cbfee61b-f79d56d0000048c5-2d-55f6ed30ff45
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id BD.94.18629.03DE6F55; Tue, 15 Sep 2015 00:52:16 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:52:16 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [RFT PATCH] mips: bigsur_defconfig: convert to use libata PATA drivers
Date:   Mon, 14 Sep 2015 17:51:42 +0200
Message-id: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJMWRmVeSWpSXmKPExsVy+t9jQV2Dt99CDY5N5LHYOGM9q8WxHY+Y
        LC7vmsNmMWHqJHaLS3tUHFg9jq5cy+TRt2UVo8fnTXIBzFFcNimpOZllqUX6dglcGUd71jAW
        rOSrWHFvCnMD40yeLkZODgkBE4lFlz4wQthiEhfurWfrYuTiEBKYxSjRemszO4Tzi1HixMH5
        bCBVbAJWEhPbV4F1iAg4SkzsO8kMYjMLhEuc+3qFqYuRg0NYwF9i2YlskDCLgKrEmkUnwEp4
        BTwkDv/rYYJYJidx8thk1gmM3AsYGVYxSqQWJBcUJ6XnGuWllusVJ+YWl+al6yXn525iBAfA
        M+kdjId3uR9iFOBgVOLhVbz/NVSINbGsuDL3EKMEB7OSCG/16W+hQrwpiZVVqUX58UWlOanF
        hxilOViUxHllVz4LFRJITyxJzU5NLUgtgskycXBKNTDqebL/tG8pj3Gxdj+45GLuKa2k1vvb
        HjyzX6nbPcVC78d1D9OFsmtPh3YqsMTfEGl6xHtp2pRXLX3JfK/sjsycE2po/2d7VMPr2iYV
        11e7eRdN+3lzxjH2GR7V04seR+Zf62e/N0Fpp0Loh4nOmmu/fZ4xv81K7ukKu0BNk0/XXRUt
        /HYJGvErsRRnJBpqMRcVJwIApQPqf/wBAAA=
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49181
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

This patch converts bigsur_defconfig to use libata PATA
drivers (tc86c001 IDE host driver has no corresponding libata
driver yet so it is not converted).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/bigsur_defconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 1cdff6b..b3e7a1b 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -122,20 +122,20 @@ CONFIG_EEPROM_MAX6875=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
 CONFIG_BLK_DEV_IDETAPE=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_BLK_DEV_IT8213=m
 CONFIG_BLK_DEV_TC86C001=m
 CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=m
-CONFIG_BLK_DEV_SR=m
+CONFIG_CHR_DEV_ST=y
+CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_CHR_DEV_SCH=m
 CONFIG_ATA=y
 CONFIG_SATA_SIL24=y
+CONFIG_PATA_CMD64X=y
+CONFIG_PATA_IT8213=m
 CONFIG_PATA_SIL680=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-- 
1.9.1
