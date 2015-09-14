Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:53:00 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:60261 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013789AbbINPwjIpuRM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:52:39 +0200
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO035PGC3GBJ80@mailout2.samsung.com>; Tue,
 15 Sep 2015 00:52:32 +0900 (KST)
X-AuditID: cbfee61b-f79d56d0000048c5-3e-55f6ed3f4ad8
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id 30.A4.18629.F3DE6F55; Tue, 15 Sep 2015 00:52:32 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:52:31 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com,
        Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [RFT PATCH] mips: e55_defconfig: convert to use libata PATA drivers
Date:   Mon, 14 Sep 2015 17:51:44 +0200
Message-id: <1442245918-27631-3-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42I5/e+xoK7D22+hBoseMltsnLGe1eLYjkdM
        Fpd3zWGzmDB1ErvFpT0qFvvmNDE5sHkcXbmWyaNvyypGj6bLHewenzfJBbBEcdmkpOZklqUW
        6dslcGW8+H2aqWALb8XCN1NZGxhncncxcnJICJhInJiymx3CFpO4cG89G4gtJDCLUWLNSx4I
        +xejxIeDXiA2m4CVxMT2VYwgtoiAo8TEvpPMXYxcHMwCzYwSTzcuZgJJCAv4SLyc9pQVxGYR
        UJW4+GkmUJyDg1fAQ2JhmzbELjmJk8cmg5VwCnhKfHr5lhVil4fE/WsnmCYw8i5gZFjFKJFa
        kFxQnJSea5SXWq5XnJhbXJqXrpecn7uJERxCz6R3MB7e5X6IUYCDUYmHV/H+11Ah1sSy4src
        Q4wSHMxKIrzVp7+FCvGmJFZWpRblxxeV5qQWH2KU5mBREueVXfksVEggPbEkNTs1tSC1CCbL
        xMEp1cC48OVnp9fP5aaaBPkacb7OeDLxkWvt9dbKa8t7Ar+bXYh+ZNxkea5M6d/fxbMWOqn+
        THV9Lbhj9a4XXw76zLh5SCxA6aT2ObcFcsI7L9j95lrCaf6RP2HB/alblHnLGgKDDhWemhqa
        qR187n3JOe7kQzo3rfWNN8ddn88Ssz9m75aHHkckLI4cVmIpzkg01GIuKk4EAAifaPYdAgAA
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49183
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

This patch converts e55_defconfig to use libata PATA drivers.

PS This platform still uses "ide0=base[,ctl[,irq]]" hack in
its defconfig.  The hack itself has been removed in 2008 and
this platform should be converted to using PATA platform host
driver (pata_platform) instead.

Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/e55_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index 0126e66..e94d266 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -14,9 +14,9 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_BLK_DEV_RAM=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_PATA_LEGACY=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
-- 
1.9.1
