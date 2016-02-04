Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 03:15:35 +0100 (CET)
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36545 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012518AbcBDCPE3Oxyx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 03:15:04 +0100
Received: by mail-pf0-f180.google.com with SMTP id n128so26676236pfn.3;
        Wed, 03 Feb 2016 18:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EQOSbe2COP9o2ZKjn/yX/nzbKNV1ZsX/1fXc/HOZ93Y=;
        b=IbiqBm/LCCLB2bu5CVW2xyg/QVqCZ1T7ic+gJ3on5K3TtYZLqttWEsjpjKYYQmnk9D
         ZKSMMnDoQ8YLH7xvBPMCsPM8xd18qrmcDu/8/UQiA5afhY0uX3z5mHkSgfMDu1b6MrQ6
         37qtTSDqh8T1yUZIyeXoXX11gRe/U7Z7kkd0VrDIt0jaQb99kKNZi/0hpJRoqUCOqDhF
         wThc7WSZmaK5XMHi5fNrMtNwUGWDb5s8lkHUsMBrMS2RlB8OiefEPzMXjkh2BhP7KJaX
         depvJuBwHDZT7G/EaU2cOUFILoAWlgE5rEyXvVK2XGeuZyac2gDx9hgBK7O95JNRCxtg
         x6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EQOSbe2COP9o2ZKjn/yX/nzbKNV1ZsX/1fXc/HOZ93Y=;
        b=VCwIxxyHBfAewsL38zjqlStllTADvvtkq18mb9o6XpuTc0koYwTVpcLcs3LC6DSdVX
         i1dDHoMTIaW6Q6CXRa1GrG+/C9kl4K4pXrAMbofBwW6NFd0+Z5UnBc5nFWTkEiq9pKOa
         Vg8h4VTr9vhjXN7CjO1OXEhQ45885yOGJum4fuajOK6ES5iJdLt53IetJf+U8yo1VY+/
         +nb6YGgNrNWv6+Q1+fTd2kxXsFfII8xiyPZW8NomFUzJVNfospAJDIWfEQLwZCQ3NAQT
         FLTwZyf6HGS8ZuboT85ebj86Z+ARWLgWD9WQPRAxoAjOLPS+0GMLreD/LWMex6ora7ei
         o2bQ==
X-Gm-Message-State: AG10YORYinGfoaXItoqA/lFhucDatQlK92UfGdRGbQtnUgRCjuIQmcb4Bd4RuNZtSN7QtQ==
X-Received: by 10.98.79.28 with SMTP id d28mr7244988pfb.77.1454552098805;
        Wed, 03 Feb 2016 18:14:58 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id l14sm12646282pfb.73.2016.02.03.18.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 18:14:58 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, jaedon.shin@gmail.com,
        dragan.stancevic@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/4] MIPS: BMIPS: Add missing 7038 L1 register cells to BCM7435
Date:   Wed,  3 Feb 2016 18:14:51 -0800
Message-Id: <1454552093-17897-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
References: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

7435 has 4 7038 L1 base register address for each of its Core + TP (for a total
of 4 threads of execution), add the two missing cells for Core 1. We are
providing HW interrupts 2/3 even for Core 1/TP0/TP1 because that's what they
are, and we can later decide to remap these in software to provide proper
interrupt affinity/parenting.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 614ee211f71a..07eff7f69fa9 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -63,13 +63,14 @@
 
 		periph_intc: periph_intc@41b500 {
 			compatible = "brcm,bcm7038-l1-intc";
-			reg = <0x41b500 0x40>, <0x41b600 0x40>;
+			reg = <0x41b500 0x40>, <0x41b600 0x40>,
+				<0x41b700 0x40>, <0x41b800 0x40>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&cpu_intc>;
-			interrupts = <2>, <3>;
+			interrupts = <2>, <3>, <2>, <3>;
 		};
 
 		sun_l2_intc: sun_l2_intc@403000 {
-- 
2.1.0
