Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Mar 2016 01:38:23 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:39617 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006841AbcCIAiUeQORp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Mar 2016 01:38:20 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1adS8p-00041X-Ea; Wed, 09 Mar 2016 00:38:19 +0000
Received: from kamal by fourier with local (Exim 4.86)
        (envelope-from <kamal@whence.com>)
        id 1adS8m-0008Cj-PU; Tue, 08 Mar 2016 16:38:16 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>, blogic@openwrt.org,
        cernekee@gmail.com, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 194/196] MAINTAINERS: Remove stale entry for BCM33xx chips
Date:   Tue,  8 Mar 2016 16:30:52 -0800
Message-Id: <1457483454-30115-195-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457483454-30115-1-git-send-email-kamal@canonical.com>
References: <1457483454-30115-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt16 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 87bee0ecf01d2ed0d48bba1fb12c954f9476d243 upstream.

Commit 70371cef114ca ("MAINTAINERS: Add entry for BMIPS multiplatform
kernel") supersedes this entry for BCM33xx.

Fixes: 70371cef114ca ("MAINTAINERS: Add entry for BMIPS multiplatform kernel")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: blogic@openwrt.org
Cc: cernekee@gmail.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12301/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 052550c..af67971 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2108,14 +2108,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
 S:	Maintained
 N:	bcm2835
 
-BROADCOM BCM33XX MIPS ARCHITECTURE
-M:	Kevin Cernekee <cernekee@gmail.com>
-L:	linux-mips@linux-mips.org
-S:	Maintained
-F:	arch/mips/bcm3384/*
-F:	arch/mips/include/asm/mach-bcm3384/*
-F:	arch/mips/kernel/*bmips*
-
 BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	linux-arm-kernel@lists.infradead.org
-- 
2.7.0
