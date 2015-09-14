Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:52:42 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:44370 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013629AbbINPwYdvtaM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:52:24 +0200
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO01T21C2TG520@mailout4.samsung.com>; Tue,
 15 Sep 2015 00:52:20 +0900 (KST)
X-AuditID: cbfee61b-f79d56d0000048c5-35-55f6ed34025e
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id 1F.94.18629.43DE6F55; Tue, 15 Sep 2015 00:52:20 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:52:20 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [RFT PATCH] mips: capcella_defconfig: convert to use libata PATA
 drivers
Date:   Mon, 14 Sep 2015 17:51:43 +0200
Message-id: <1442245918-27631-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42I5/e+xoK7J22+hBovWyVpsnLGe1eLYjkdM
        Fpd3zWGzmDB1ErvFpT0qDqweR1euZfLo27KK0ePzJrkA5igum5TUnMyy1CJ9uwSujEOHjjAX
        NHFX9L3YzdLAuIizi5GTQ0LARGJaQyc7hC0mceHeerYuRi4OIYFZjBK7ri1kBEkICfxilFj5
        gwnEZhOwkpjYvgosLiLgKDGx7yQziM0sEC5x7usVoBoODmGBYIkD09VAwiwCqhIvVp9jBbF5
        BTwkJs25zgKxS07i5LHJYHFOAU+JTy/fskKs8pC4f+0E0wRG3gWMDKsYJVILkguKk9JzjfJS
        y/WKE3OLS/PS9ZLzczcxgsPlmfQOxsO73A8xCnAwKvHwKt7/GirEmlhWXJl7iFGCg1lJhLf6
        9LdQId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryyK5+FCgmkJ5akZqemFqQWwWSZODilGhjbt/v+
        TL1zj2HjmeUndn+6vPFpmPXP3Gv/7H6t29605tuKVfMd3hzubZxRmZP7JuNOXd1VJbN9u2Zl
        vXH8bCfZ61Mzy/VdPwvLx+2+T6Z9Z/57VK+rQqlBbZnZwzmf79vHHbV8sCi2PD/E65WSarD8
        iRcyZ+ROOx35M7/1wsMUo1CWU18PR/vFKbEUZyQaajEXFScCAByP3PcTAgAA
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49182
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

This patch converts capcella_defconfig to use libata PATA
drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/capcella_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index 5135dc0..2924ba3 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -31,9 +31,9 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_IP_SCTP=m
 CONFIG_FW_LOADER=m
 CONFIG_BLK_DEV_RAM=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 CONFIG_PHYLIB=m
 CONFIG_MARVELL_PHY=m
-- 
1.9.1
