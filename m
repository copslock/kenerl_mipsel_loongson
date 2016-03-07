Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 23:56:12 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:51902 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011443AbcCGW4LJv0ia (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 23:56:11 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ad44Q-0000de-08; Mon, 07 Mar 2016 22:56:10 +0000
Received: from kamal by fourier with local (Exim 4.86)
        (envelope-from <kamal@whence.com>)
        id 1ad44N-0002CU-BB; Mon, 07 Mar 2016 14:56:07 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>, blogic@openwrt.org,
        cernekee@gmail.com, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 261/273] MAINTAINERS: Remove stale entry for BCM33xx chips
Date:   Mon,  7 Mar 2016 14:50:52 -0800
Message-Id: <1457391064-6660-262-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457391064-6660-1-git-send-email-kamal@canonical.com>
References: <1457391064-6660-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
X-Extended-Stable: 4.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52548
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

4.2.8-ckt5 -stable review patch.  If anyone has any objections, please let me know.

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
index 66a6649..4be1334 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2223,14 +2223,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
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
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
-- 
2.7.0
