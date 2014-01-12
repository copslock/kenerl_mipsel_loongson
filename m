Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jan 2014 22:30:33 +0100 (CET)
Received: from mail-oa0-f51.google.com ([209.85.219.51]:48727 "EHLO
        mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831300AbaALV3vKhI4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jan 2014 22:29:51 +0100
Received: by mail-oa0-f51.google.com with SMTP id m1so7195182oag.38
        for <multiple recipients>; Sun, 12 Jan 2014 13:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T+HxWzOgBmrvlQ4UnULUZ42Wl1eZroyLdsJNRh2nheA=;
        b=hRKI99Ns23eaI1HtdfMd/Kh6BxVfNBrs5yt92r0UAlE06affykS+lsGPL24ZqzMs6z
         03/2ukKKaKGhxwq8dntUnyUDUEzBT/4y3r7XVGg4Xwuq66qdFy9iBPbYyFPy7g6hPP2L
         Y81LEEdX/oVtl+YRnvj1d33Hf1TAQFA5/5/XULJ+g36TP/DjwylTae/OG2EvvJxBMiXl
         rhoDpBafFmrWk5VqydBoF3fdR+hzwzvaJh2kP6yj1HF2bOW28JSeAWqk/u94jQCU1LuG
         vYRETxtcXJtZuljbIRMp1Q6EnIfi0ZkJkG56KsFZk/iuITwf9TAt1xGfBzubrZHsM2e9
         oXYw==
X-Received: by 10.182.88.202 with SMTP id bi10mr87415obb.52.1389562185073;
        Sun, 12 Jan 2014 13:29:45 -0800 (PST)
Received: from localhost.localdomain (ip68-5-18-231.oc.oc.cox.net. [68.5.18.231])
        by mx.google.com with ESMTPSA id m4sm21274968oen.7.2014.01.12.13.29.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 13:29:44 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        mbizon@freebox.fr, cernekee@gmail.com, dgcbueu@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v2 2/3] MIPS: update MIPS_L1_CACHE_SHIFT based on MIPS_L1_CACHE_SHIFT_<N>
Date:   Sun, 12 Jan 2014 13:29:31 -0800
Message-Id: <1389562172-13242-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1389562172-13242-1-git-send-email-florian@openwrt.org>
References: <1389562172-13242-1-git-send-email-florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38947
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

All platforms that require a special MIPS_L1_CACHE_SHIFT value have been
updated, such that we can now make MIPS_L1_CACHE_SHIFT default to the
appropriate integer value based on the select MIPS_L1_CACHE_SHIFT_<N>
variable.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- keep order with MIPS_L1_CACHE_SHIFT_N
- add a default "5" to provide a safe default

 arch/mips/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3b7a2be..68969d9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1106,9 +1106,10 @@ config MIPS_L1_CACHE_SHIFT_7
 
 config MIPS_L1_CACHE_SHIFT
 	int
-	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL || SOC_RT288X
-	default "6" if MIPS_CPU_SCACHE
-	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
+	default "4" if MIPS_L1_CACHE_SHIFT_4
+	default "5" if MIPS_L1_CACHE_SHIFT_5
+	default "6" if MIPS_L1_CACHE_SHIFT_6
+	default "7" if MIPS_L1_CACHE_SHIFT_7
 	default "5"
 
 config HAVE_STD_PC_SERIAL_PORT
-- 
1.8.3.2
