Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:55:45 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:50817 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013801AbbINPyQxPXUM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:54:16 +0200
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO00DZEC66YN30@mailout3.samsung.com>; Tue,
 15 Sep 2015 00:54:10 +0900 (KST)
X-AuditID: cbfee61b-f79d56d0000048c5-94-55f6eda210a9
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id AA.A4.18629.2ADE6F55; Tue, 15 Sep 2015 00:54:10 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:54:10 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [RFT PATCH] mips: maltasmvp_eva_defconfig: convert to use libata PATA
 drivers
Date:   Mon, 14 Sep 2015 17:51:53 +0200
Message-id: <1442245918-27631-12-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsVy+t9jQd1Fb7+FGnxtkrbYOGM9q8WxHY+Y
        LC7vmsNmMWHqJHaLz7e3s1rc37eR3eLSHhWLvvZL7A4cHj07zzB6HF25lsmjb8sqRo/Pm+QC
        WKK4bFJSczLLUov07RK4MtZO+8ResIyv4vjRG+wNjFN5uhg5OSQETCR6zr1khrDFJC7cW8/W
        xcjFISQwi1Fi9Yx/rBDOL0aJ82s2MIFUsQlYSUxsX8UIYosIOEpM7DvJDFLELHCLUeLt/kns
        IAlhgQiJc7+3sILYLAKqEjeu3mADsXkFPCWO9fxhgVgnJ3Hy2GSwGk6g+KeXb8FsIQEPifvX
        TjBNYORdwMiwilEitSC5oDgpPdcoL7Vcrzgxt7g0L10vOT93EyM4uJ5J72A8vMv9EKMAB6MS
        D6/i/a+hQqyJZcWVuYcYJTiYlUR4q09/CxXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK7vyWaiQ
        QHpiSWp2ampBahFMlomDU6qBcV3id6/Iw6aBXzt5z+sYPnK913hYiMvb6tTHP9/ip7K+9S4J
        +HX7aOOJj3du26wodWNav+pMyZeP5ou+/9gVPclg/RGr0GpPl/P6OyVfpuxZxDf14AQV+TDW
        y5v3F+pvid0XLCds1uK17vx+jofRh1WWnHafvvmJUbLGp8cu/P1l52cEueY0TFNiKc5INNRi
        LipOBAASWVBiKgIAAA==
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49192
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

This patch converts maltasmvp_eva_defconfig to use libata PATA
drivers.

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Untested.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/maltasmvp_eva_defconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index c83338a..2774ef0 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -85,15 +85,14 @@ CONFIG_NET_CLS_IND=y
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
