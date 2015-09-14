Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:57:17 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:49627 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013806AbbINPzPg1jmM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:55:15 +0200
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO01T3PC7JG520@mailout4.samsung.com>; Tue,
 15 Sep 2015 00:55:09 +0900 (KST)
X-AuditID: cbfee61a-f79a06d000005c6f-9f-55f6eddd7057
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id EE.9E.23663.DDDE6F55; Tue, 15 Sep 2015 00:55:09 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:55:09 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [RFT PATCH] mips: workpad_defconfig: convert to use libata PATA drivers
Date:   Mon, 14 Sep 2015 17:51:58 +0200
Message-id: <1442245918-27631-17-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42I5/e+xoO7dt99CDVb8kbXYOGM9q8WxHY+Y
        LC7vmsNmMWHqJHaLS3tUHFg9jq5cy+TRt2UVo8fnTXIBzFFcNimpOZllqUX6dglcGTdffWcv
        uM5dsfSgYwPjc84uRg4OCQETiefP5LoYOYFMMYkL99azdTFycQgJzGKUeLT3NSuE84tR4v6i
        CawgVWwCVhIT21cxgtgiAo4SE/tOMoPYzALhEue+XmECsYUFAiT6Hq9kAbFZBFQlHi3sA6vh
        FfCU6Dz7ixlim5zEyWOTwWZyAsU/vXwLZgsJeEjcv3aCaQIj7wJGhlWMEqkFyQXFSem5hnmp
        5XrFibnFpXnpesn5uZsYweHyTGoH48Fd7ocYBTgYlXh4Fe5/DRViTSwrrsw9xCjBwawkwlt9
        +luoEG9KYmVValF+fFFpTmrxIUZpDhYlcV7Zlc9ChQTSE0tSs1NTC1KLYLJMHJxSDYzyleoP
        9+hwKV7JblLdFsbeMluqcp04t4EgB9/DrI130gKuzblj7WPJ1Wq7+LPx9T+PtGZWbdgVpmg5
        +/OC3KyOybovvhwWe3Tx2exZzz5/fOzTU+j/IfXT1MfXzVYVH5t4oCR01dZmhUcs07jl3oiY
        lmlmn312y91PN6fzkO+eEwEV/UZ/dUqUWIozEg21mIuKEwE07iLMEwIAAA==
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49197
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

This patch converts workpad_defconfig to use libata PATA
drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/workpad_defconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index ee4b2be..1b556cd 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -28,10 +28,10 @@ CONFIG_IP_MULTICAST=y
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_BLK_DEV_RAM=m
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=m
-CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_PATA_PCMCIA=m
+CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
-- 
1.9.1
