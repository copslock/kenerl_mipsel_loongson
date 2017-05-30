Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2017 13:21:16 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.24]:54200 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993960AbdE3LVFU0xBj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2017 13:21:05 +0200
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M4kN3-1e7L8s3Opx-00yuOt; Tue, 30 May 2017 13:20:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] bcm47xx: fix build regression
Date:   Tue, 30 May 2017 13:20:12 +0200
Message-Id: <20170530112027.3983554-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:X8Zzmi2Mh9KiCQEdMT8nwsleVnypOlefbFDQmQTcp1xw44sAQpZ
 Lwlpu87QW3ZOCtJJf0zZAgZk90IH5yUCTtMHXPxpOEh27eYStHRIG4Mg9FsWzAusrA2/HN3
 q1CeHTLa7rFxsBF0XTEpIDa+NCT0P6+Ic4mZx57kFDfsS0QCjSgw9q5yK9ypoEgAw/HA36J
 mhhTJubf/5AFdFpr9dtRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r5leIAc1lsM=:7vIXZwrE0D0iBYlqS9jtjM
 CPfngkctZKMJJeQaH0T1wGteIMbiyw2UCjcjNX8AEjogCUP7vvCxH1xo5mEvE9fVWei7vIaLm
 Qu843QTE0cwYep5wch7oWQOnJfXRiZ8B6yKdOa1gxIocRMDEyM+i6LpTQIkUZSwA5CAzRyFFa
 BdatfXjgDxIpTZsCIl2RZrr3Fp5PwoAgJEnSPkLWSEzjw5Cdt1Xu+fIly+iwPcvUcHz+nuElM
 vW5KfmEb1g6qU+/HgPfV0AmYNOqCLT5f1hfoeUFHWoOBo3xpezyOlBijVVtWwRad67dcjdz9a
 RLN4RI19cNPjnhPLLzmFg85SMj6qj/3oi/46R2d4mA5rzv4ZFE+wPEQib7JpzefPLcBozSyAa
 pBRk4LUPXJ2+ohri52awUeypFih2cknbPON9XSsX4iB+opCBUuWsBMrTdHag+k42uCNSYsGgn
 DMa4lb0A144wbxzOZYuSSKsxYm2E2MAisTI9rGAqHdmnhh8dIFbPQeZ2jiGdTaYLKU67wQ7HT
 OmCJmyH6886gC/p1Bjy8jIoYgcecOA2qjJuu2E4z1SWf229FPF4vOKYfDHqAxsPMBTfN7poqr
 7C8C22k/0Sd2mn31ocNbxKBo/z0GKn3mqbzLH6jyrFdDzgpUNWwUmoY65BhYFQ3mAggkNjW06
 f9gZpx0GJtM/syA9VO0hpz7+2liwdnOH0HtiKXlHgrv3PNzrU8qAeBzfj+MNd0A+dC7Q=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

An unknown change in the kernel headers caused a build regression
in an MTD partition driver:

In file included from drivers/mtd/bcm47xxpart.c:12:0:
include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first use in this function)

Clearly we want to include linux/errno.h here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/bcm47xx_nvram.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
index 2793652fbf66..a414a2b53e41 100644
--- a/include/linux/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -8,6 +8,7 @@
 #ifndef __BCM47XX_NVRAM_H
 #define __BCM47XX_NVRAM_H
 
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
-- 
2.9.0
