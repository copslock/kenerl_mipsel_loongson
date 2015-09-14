Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:53:53 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:57868 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013794AbbINPxJO0VCM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:53:09 +0200
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO01T2GC4EG520@mailout4.samsung.com>; Tue,
 15 Sep 2015 00:53:02 +0900 (KST)
X-AuditID: cbfee61b-f79d56d0000048c5-58-55f6ed5e3cf0
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id 13.A4.18629.E5DE6F55; Tue, 15 Sep 2015 00:53:02 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:53:02 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Huacai Chen <chenhc@lemote.com>
Subject: [RFT PATCH] mips: lemote2f_defconfig: convert to use libata PATA
 drivers
Date:   Mon, 14 Sep 2015 17:51:47 +0200
Message-id: <1442245918-27631-6-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42I5/e+xoG7c22+hBm97uC02zljPajG/aQOb
        xbEdj5gsLu+aw2YxYeokdotLe1Qc2DxmnzvH5nF05Vomj74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mr48529oJW/4vfi/WwNjNd4uhg5OCQETCTmvnHsYuQEMsUkLtxbz9bFyMUhJDCLUeLM
        7n/sEM4vRol526YxglSxCVhJTGxfBWaLCDhKTOw7yQxiMwtUSMzd9YgVZKiwQLDEq7fJICaL
        gKrE+juxIBW8Ah4Sj/+cY4HYJSdx8thkVhCbU8BT4tPLt2C2EFDN/WsnmCYw8i5gZFjFKJFa
        kFxQnJSea5SXWq5XnJhbXJqXrpecn7uJERw+z6R3MB7e5X6IUYCDUYmHV/H+11Ah1sSy4src
        Q4wSHMxKIrzVp7+FCvGmJFZWpRblxxeV5qQWH2KU5mBREueVXfksVEggPbEkNTs1tSC1CCbL
        xMEp1cA4f6GHkhTH28sCm77dWibPd+lAyn7riCVW03ZHhm5befqat9wmwYSXT+P27UjdHMHY
        72E7O9TM4qtqB291xb+Ni/Yvi6x7ynh89b6HWzW2nbd6/2ZefGFX/8xvM9dP26VewSuaXViv
        p/7LYenG2S8PdU9892bpiSZz/cxTivptBZkPz97mtb9Wo8RSnJFoqMVcVJwIAMyFFQ8bAgAA
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49186
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

This patch converts lemote2f_defconfig to use libata PATA
drivers.

PS This platform uses CS5536 chipset which (due to historical
reasons) has basic support in AMD/nVidia PATA host driver and
full support in a newer CS5536 PATA one (pata_cs5536).  Thus
most likely this platform should switch to using the latter
host driver.

Cc: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/lemote2f_defconfig | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 54cc385..004cf52 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -108,16 +108,11 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_IDE_TASK_IOCTL=y
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
-CONFIG_BLK_DEV_AMD74XX=y
-CONFIG_SCSI=m
-CONFIG_BLK_DEV_SD=m
+CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_PATA_AMD=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
 CONFIG_MD_LINEAR=m
-- 
1.9.1
