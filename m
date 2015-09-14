Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:54:11 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:32946 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013790AbbINPxSz0xuM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:53:18 +0200
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO01T2IC4OG520@mailout4.samsung.com>; Tue,
 15 Sep 2015 00:53:12 +0900 (KST)
X-AuditID: cbfee61a-f79a06d000005c6f-36-55f6ed68da1e
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id CF.8E.23663.86DE6F55; Tue, 15 Sep 2015 00:53:12 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:53:12 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [RFT PATCH] mips: malta_defconfig: convert to use libata PATA drivers
Date:   Mon, 14 Sep 2015 17:51:48 +0200
Message-id: <1442245918-27631-7-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsVy+t9jQd2Mt99CDT7+l7XYOGM9q8WxHY+Y
        LC7vmsNmMWHqJHaLz7e3s1rc37eR3eLSHhUHdo+enWcYPY6uXMvk0bdlFaPH501yASxRXDYp
        qTmZZalF+nYJXBkvjtxkLPjFW3Gp+SJ7A+Mb7i5GTg4JAROJfZfeMkHYYhIX7q1nA7GFBGYx
        Svy4ktLFyAVk/2KU6Pxwlh0kwSZgJTGxfRUjiC0i4Cgxse8kM4jNLLCWUWLx4nwQW1jAT+Ln
        vilgg1gEVCV+vloEtoBXwENi5ZZD7BDL5CROHpvMCmJzCnhKfHr5lhVisYfE/WsnmCYw8i5g
        ZFjFKJFakFxQnJSea5iXWq5XnJhbXJqXrpecn7uJERxOz6R2MB7c5X6IUYCDUYmHV+H+11Ah
        1sSy4srcQ4wSHMxKIrzVp7+FCvGmJFZWpRblxxeV5qQWH2KU5mBREueVXfksVEggPbEkNTs1
        tSC1CCbLxMEp1cAoz/8mfL3w0ZuLrxUrzm9SSKxX5ms9/9TrxK8rkjMD/p1xkn123z8zfv4h
        RWuP9R+vW8+/H/Dd6FaNnubWDSs8nrru+3l2pk2A/vMd03t45qUvYlVezcF0R6Nfb7emj8r0
        sEOL0v7f/OnHnxkgOS+EZULh9cWMrXEblk79tyKvxts7VPuJjJCMEktxRqKhFnNRcSIAVj0C
        XiMCAAA=
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49187
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

This patch converts malta_defconfig to use libata PATA
drivers.

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/malta_defconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 61a4460..5afb484 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -241,14 +241,11 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_GENERIC=y
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_CHR_DEV_OSST=m
-CONFIG_BLK_DEV_SR=m
+CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_CONSTANTS=y
@@ -265,6 +262,7 @@ CONFIG_AIC7XXX_RESET_DELAY_MS=15000
 # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
 CONFIG_ATA=y
 CONFIG_ATA_PIIX=y
+CONFIG_PATA_LEGACY=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
 CONFIG_MD_LINEAR=m
-- 
1.9.1
