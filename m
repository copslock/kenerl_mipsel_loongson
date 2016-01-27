Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 21:14:57 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35531 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011828AbcA0UOZCDlzA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 21:14:25 +0100
Received: by mail-pa0-f68.google.com with SMTP id gi1so860550pac.2;
        Wed, 27 Jan 2016 12:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V8TnC5oJQVe5RUxOyPr3vD595RL7ilBTiDvmLOptZnw=;
        b=zlq4gJ0mEniSMwkL1ctICAJaekC1J5fKNi1uNc1tL9zKui6LZtvzgYWT9DY7sUZF3B
         Zc5XLYdKyN44TDpHwMTrbrcU71RRhPAoGh6IrrLDmbpTvsjqhv5sNi9lnYIqJBKxCXVJ
         r6di+7HQ3h05GKDm29wjRTq8JuRGxiEv9vJOe2IibMxgKnBIM8ACSeeq0jUN8hM31DKc
         ElaTMkx5+jyBY/+7G/Dw74NHpR4Sr2s/SysavCWHyXZt3hsyKrmHljqrtXG95pqUHU1R
         jHc1WcrQawh/0q1etUyi5xdIpwUrzXYa7dFzJNKSR7u0Rs3WL5p5xmtXLDVh4shGAGPj
         STmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V8TnC5oJQVe5RUxOyPr3vD595RL7ilBTiDvmLOptZnw=;
        b=EhR2dOeGG88VJSl2nD0epbiHXdPUdTBD399UAzWepoGa1YQBrtpuseGXT2Y4fvw5SI
         wgtMHDiJSA5hv46PkxmlnXdQGOYcZCUB4Fek4Wa1H853g1X8DjYjj3zLNYsZK2ZkIVsJ
         JpRt0RNDuevmXERRG1bGqFlRq/cKUe0Fb7IM8f/56cjpxvMDaIPsKRq7EwT9LleZm/9k
         U6GX3oVyvfXJ3nBqwBC5v+8BwBCf/fFL1UoO7QY6bY7+HE0g9wkp8GErSH7hc6hsWBY+
         BHbGqz2P+us1RY6fl5zZf+kNwSJgtU11BJGkI6xgfyqjnHCt76bi9aFe1tEVnaQN3kkY
         MqWA==
X-Gm-Message-State: AG10YOSby/IOWihTs2EOVWgXKZo51VT+5IPQOX05ikqkUu+GLwLCeeZb213ntPZph7Me2w==
X-Received: by 10.66.234.200 with SMTP id ug8mr45727278pac.129.1453925659340;
        Wed, 27 Jan 2016 12:14:19 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 75sm10987965pfj.20.2016.01.27.12.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 12:14:18 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, computersforpeace@gmail.com,
        cernekee@gmail.com, jogo@openwrt.org, simon@fire.lp0.eu,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: BMIPS: Enable partition parser in defconfig
Date:   Wed, 27 Jan 2016 12:13:16 -0800
Message-Id: <1453925596-24661-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com>
References: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51486
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

Enable CONFIG_MTD_BCM63XX_PARTS in arch/mips/configs/bmips_be_defconfig
since this is a necessary option to parse the built-in flash partition
table on BMIPS big-endian SoCs (Cable Modem and DSL).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/configs/bmips_be_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index 24dcb90b0f64..acf7785c4cdb 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -36,6 +36,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_PRINTK_TIME=y
 CONFIG_BRCMSTB_GISB_ARB=y
 CONFIG_MTD=y
+CONFIG_MTD_BCM63XX_PARTS=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-- 
2.1.0
