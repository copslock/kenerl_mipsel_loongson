Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 07:09:21 +0100 (CET)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:46396 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825865AbaANGIijjAoy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jan 2014 07:08:38 +0100
Received: by mail-oa0-f53.google.com with SMTP id i7so263726oag.26
        for <multiple recipients>; Mon, 13 Jan 2014 22:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+jvGNO1klaHogczqwEspjv1/cceReyX+pw9WKrZfjw=;
        b=e4mA/FOXKGs1TaGnPH5t2nzbrXpPVVWzbK1fBHD03kEIw1lXwFmx/olSNVFIi56U2C
         6CS7WDIKiEBdVjkR46iFNQpuRqpCulB0PTea8X84cKTWQmbO7SWwuwQeCwke+jAhMOaC
         ajncKwSXbxNwxxFPS3ZPq8tCqs1iMaK0Gqhv3eTntMtBci/yEIUaBv6E0VqrEiCctJ2O
         52eLbt0ZilVbAtIg54cDxbTTbSCG67HxCxjQE56El5npd2YC5+SW5JSbsYMK/BsBfCaM
         46Mk0keGT1zP8n25QkxVG5u7WBsvV8gbMnHBvsPHEEUJDyJb4IPHAuLpsHzQE7IkFsVc
         bXBQ==
X-Received: by 10.182.60.233 with SMTP id k9mr23581270obr.34.1389679712670;
        Mon, 13 Jan 2014 22:08:32 -0800 (PST)
Received: from localhost.localdomain (ip68-5-18-231.oc.oc.cox.net. [68.5.18.231])
        by mx.google.com with ESMTPSA id nw5sm24074812obc.9.2014.01.13.22.08.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 Jan 2014 22:08:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        mbizon@freebox.fr, cernekee@gmail.com, dgcbueu@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v3 2/3] MIPS: update MIPS_L1_CACHE_SHIFT based on MIPS_L1_CACHE_SHIFT_<N>
Date:   Mon, 13 Jan 2014 22:07:31 -0800
Message-Id: <1389679652-14269-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1389679652-14269-1-git-send-email-f.fainelli@gmail.com>
References: <1389679652-14269-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38968
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

From: Florian Fainelli <florian@openwrt.org>

All platforms that require a special MIPS_L1_CACHE_SHIFT value have been
updated, such that we can now make MIPS_L1_CACHE_SHIFT default to the
appropriate integer value based on the select MIPS_L1_CACHE_SHIFT_<N>
variable.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v2:
- rebased on top of john's mips-next-3.14

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
