Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:56:45 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:49627 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013803AbbINPzNb1LyM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:55:13 +0200
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO00884C6NPZC0@mailout4.samsung.com>; Tue,
 15 Sep 2015 00:54:23 +0900 (KST)
X-AuditID: cbfee61a-f79a06d000005c6f-7b-55f6edaf4d4d
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id 87.9E.23663.FADE6F55; Tue, 15 Sep 2015 00:54:23 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:54:23 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [RFT PATCH] mips: maltaup_defconfig: convert to use libata PATA drivers
Date:   Mon, 14 Sep 2015 17:51:54 +0200
Message-id: <1442245918-27631-13-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsVy+t9jQd31b7+FGlzdqG2xccZ6VotjOx4x
        WVzeNYfNYsLUSewWn29vZ7W4v28ju8WlPSoWfe2X2B04PHp2nmH0OLpyLZNH35ZVjB6fN8kF
        sERx2aSk5mSWpRbp2yVwZaza1MdS0M1X8fTADJYGxh/cXYycHBICJhL3/nWzQdhiEhfurQey
        uTiEBGYxSjxeu5odwvnFKHG2+SArSBWbgJXExPZVjCC2iICjxMS+k8wgRcwCtxgl3u6fBNTB
        wSEsECCx6nc0SA2LgKpEx+WdYBt4BTwl+qfvYITYJidx8thksJmcQPFPL9+C2UICHhL3r51g
        msDIu4CRYRWjRGpBckFxUnquYV5quV5xYm5xaV66XnJ+7iZGcGg9k9rBeHCX+yFGAQ5GJR5e
        hftfQ4VYE8uKK3MPMUpwMCuJ8Faf/hYqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFd25bNQIYH0
        xJLU7NTUgtQimCwTB6dUA6PR52k2sQ9Wnj1QI7rWPvE9G9cyf13vv30LtTnbRFJmf+7Vj+l+
        7jPt19Rlx/msp60M4povyTAxrPmK3U3WTs1ta865HjL2sTTnqNJMmnP6x9H7PsH/eZlmGbXs
        3uyZfGbp+mMa755OUdzkGZiwdrND+dYnfnfnrDkmGafYyjJLSn8/y5+q0zOUWIozEg21mIuK
        EwGzr6lfKQIAAA==
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49195
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

This patch converts maltaup_defconfig to use libata PATA
drivers.

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/maltaup_defconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 6234464..9bbd221 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -80,15 +80,14 @@ CONFIG_NET_CLS_IND=y
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
