Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Apr 2015 12:26:29 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41272 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014489AbbDLKZdYHFd7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Apr 2015 12:25:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A554928BC81;
        Sun, 12 Apr 2015 12:24:42 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-015-232.088.073.pools.vodafone-ip.de [88.73.15.232])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 498FC28C10B;
        Sun, 12 Apr 2015 12:24:32 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>
Subject: [PATCH RFC v3 4/4] MIPS: BMIPS: accept UHI interface for passing a dtb
Date:   Sun, 12 Apr 2015 12:25:01 +0200
Message-Id: <1428834301-12721-5-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
References: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Detect and use passed dtb address using the UHI interface. This allows for
booting with a vmlinux.bin appended dtb instead of using a built-in one.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bmips/setup.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index fae800e..526ec27 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -149,6 +149,8 @@ void __init plat_mem_setup(void)
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
+	else if (fw_arg0 == -2) /* UHI interface */
+		dtb = (void *)fw_arg1;
 	else if (__dtb_start != __dtb_end)
 		dtb = (void *)__dtb_start;
 	else
-- 
1.7.10.4
