Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Mar 2016 18:29:21 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:38976 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013419AbcCSR3D6OJ1K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Mar 2016 18:29:03 +0100
Received: from hauke-desktop.fritz.box (p20030062465D04006DFE28B1EAF19207.dip0.t-ipconnect.de [IPv6:2003:62:465d:400:6dfe:28b1:eaf1:9207])
        by hauke-m.de (Postfix) with ESMTPSA id 883771001AE;
        Sat, 19 Mar 2016 18:29:03 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] MIPS: lantiq: make it possible to build in no device tree
Date:   Sat, 19 Mar 2016 18:28:52 +0100
Message-Id: <1458408532-9259-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458408532-9259-1-git-send-email-hauke@hauke-m.de>
References: <1458408532-9259-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Now it is possible to build in no device tree at all and depend on the
boot loader providing one or someone concatenating a device tree to the
end of the image.

This was copied from arch/mips/bmips/Kconfig

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/Kconfig | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index e10d333..177769d 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -25,7 +25,17 @@ config SOC_FALCON
 endchoice
 
 choice
-	prompt "Devicetree"
+	prompt "Built-in device tree"
+	help
+	  Legacy bootloaders do not pass a DTB pointer to the kernel, so
+	  if a "wrapper" is not being used, the kernel will need to include
+	  a device tree that matches the target board.
+
+	  The builtin DTB will only be used if the firmware does not supply
+	  a valid DTB.
+
+config LANTIQ_DT_NONE
+	bool "None"
 
 config DT_EASY50712
 	bool "Easy50712"
-- 
2.7.0
