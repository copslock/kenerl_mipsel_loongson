Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jan 2014 22:30:52 +0100 (CET)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:37257 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870553AbaALV3w5qkaq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jan 2014 22:29:52 +0100
Received: by mail-ob0-f173.google.com with SMTP id gq1so6974329obb.18
        for <multiple recipients>; Sun, 12 Jan 2014 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mV0/RMf9i1csG2CS39VxOLlxm/dVp9GoP1362c3wAdA=;
        b=PHG+j5Rhshn8++HRCh2E9jBSzxTN+RdVCw7zeJpZGk+GAxvEXIAOwse0opNga/xYlu
         u3y38QRttIg9arMQgPV6grnf0Ed9lLV2k/+thBrUPcJL3XIJ5e9t7orIFWLsR1osh2LK
         Tc8i3tnArE7g5B1Uhk2JT/vUbUehVCUJFN7kqRVZWn3ILrGdIJgoB3DFkBCwRgXUJjeN
         DvA7Vozsf+4ACfjNCCazLGcxEPHU87ui9kSXvNQVBcfu6i15efgdn8cRlR+cNPLvwy+J
         g0yVgW3Ag/mT/WneZJxcX6m2PM0KsVy/+HE03tCkR5icusj8jXCjuY93b0P1j9Udiy+6
         NPhw==
X-Received: by 10.182.213.166 with SMTP id nt6mr84372obc.53.1389562186907;
        Sun, 12 Jan 2014 13:29:46 -0800 (PST)
Received: from localhost.localdomain (ip68-5-18-231.oc.oc.cox.net. [68.5.18.231])
        by mx.google.com with ESMTPSA id m4sm21274968oen.7.2014.01.12.13.29.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 13:29:46 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        mbizon@freebox.fr, cernekee@gmail.com, dgcbueu@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v2 3/3] MIPS: BCM63XX: select correct MIPS_L1_CACHE_SHIFT value
Date:   Sun, 12 Jan 2014 13:29:32 -0800
Message-Id: <1389562172-13242-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1389562172-13242-1-git-send-email-florian@openwrt.org>
References: <1389562172-13242-1-git-send-email-florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Broadcom BCM63xx DSL SoCs have a L1-cache line size of 16 bytes (shift
value of 4) instead of the currently configured 32 bytes L1-cache line
size.

Reported-by: Daniel Gonzalez <dgcbueu@gmail.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- rebased

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 68969d9..beb3766 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -139,6 +139,7 @@ config BCM63XX
 	select SWAP_IO_SPACE
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
+	select MIPS_L1_CACHE_SHIFT_4
 	help
 	 Support for BCM63XX based boards
 
-- 
1.8.3.2
