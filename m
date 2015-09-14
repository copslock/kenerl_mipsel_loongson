Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:55:07 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:49877 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013798AbbINPyHKzHVM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:54:07 +0200
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO0087VC5ZPZC0@mailout4.samsung.com>; Tue,
 15 Sep 2015 00:53:59 +0900 (KST)
X-AuditID: cbfee61a-f79a06d000005c6f-63-55f6ed9651a4
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id 45.9E.23663.69DE6F55; Tue, 15 Sep 2015 00:53:59 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:53:58 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [RFT PATCH] mips: maltaaprp_defconfig: convert to use libata PATA
 drivers
Date:   Mon, 14 Sep 2015 17:51:52 +0200
Message-id: <1442245918-27631-11-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsVy+t9jQd3pb7+FGjTMZLPYOGM9q8WxHY+Y
        LC7vmsNmMWHqJHaLz7e3s1rc37eR3eLSHhWLvvZL7A4cHj07zzB6HF25lsmjb8sqRo/Pm+QC
        WKK4bFJSczLLUov07RK4Mh6/OM5SMJ2vYtrtP8wNjC08XYycHBICJhLLV99mh7DFJC7cW8/W
        xcjFISQwi1HiyJI+KOcXo8T0W9dYQarYBKwkJravYgSxRQQcJSb2nWQGKWIWuMUo8Xb/JLBR
        wgIhEn2Lp4PZLAKqEos2rQRq5uDgFfCUuLo6HGKbnMTJY5PBZnIChT+9fAtmCwl4SNy/doJp
        AiPvAkaGVYwSqQXJBcVJ6bmGeanlesWJucWleel6yfm5mxjBofVMagfjwV3uhxgFOBiVeHgV
        7n8NFWJNLCuuzD3EKMHBrCTCW336W6gQb0piZVVqUX58UWlOavEhRmkOFiVxXtmVz0KFBNIT
        S1KzU1MLUotgskwcnFINjDMN3+WtiYxZdKVPSPD+tLL0FSJ5L5/9sXhv28w7RW6Kd9g8Addz
        HKHOU/UP2Vz4aFTcvTJzXdLrKCMeHZ1Z9mFf43f/ct7FWRul93n2+cLDmmEt0snZRvz3XSYs
        Pl+vuvRLQt02e75+I8mrIk0P24zrwoQizUMUVmZKSV/otr5gIKyzxe+TEktxRqKhFnNRcSIA
        caHt8SkCAAA=
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49190
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

This patch converts maltaaprp_defconfig to use libata PATA
drivers.

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/maltaaprp_defconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index fb042ce..a9d433a 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -81,15 +81,14 @@ CONFIG_NET_CLS_IND=y
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
-CONFIG_IDE=y
-# CONFIG_IDE_PROC_FS is not set
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_PIIX=y
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_ATA_PIIX=y
+CONFIG_PATA_OLDPIIX=y
+CONFIG_PATA_MPIIX=y
+CONFIG_ATA_GENERIC=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_NET_VENDOR_ADAPTEC is not set
-- 
1.9.1
