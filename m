Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 03:43:52 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54265 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006781AbaKXClNnMq0s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 03:41:13 +0100
Received: by mail-pd0-f180.google.com with SMTP id p10so8902727pdj.11
        for <multiple recipients>; Sun, 23 Nov 2014 18:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BqHYS3t4bh4tnyDWGS3/FP1YfrMf3ur0SePPM70pHYA=;
        b=Xzv5oTBcDzA5JT7p9TG0Fgr0+1nWJ3LMXQk19y7S4yRGVkCtLf/zpYGCZRzKhkHysG
         SVj5dUjBvyjWAASeXxhSjmeDmA68W/V6tk/4G7jHYtWnXd5JMm9EFV5R65PPTpgb1ErU
         /w9Yeuelkoik60rNzitHKYyfqVeXSev6kTOkgpDYv6t8J0zwrDouHOIp3+OCSomRVh6Z
         +pXNI2mhMJ/dXmQlFD0eSE5FxBfSsXQmoNp/OFR2EJt9MqktbTfnsPfFUL7s5IADNfvA
         40uvRDw7WmNZSf/KDhA62JM8KCjk5dJExo5NikV5+AxbXuhueSU49nBf4yfLKHw0/UP3
         yK9A==
X-Received: by 10.70.63.9 with SMTP id c9mr29145113pds.104.1416796868064;
        Sun, 23 Nov 2014 18:41:08 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id ml5sm10930673pab.32.2014.11.23.18.41.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 18:41:07 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 10/11] MIPS: Reorder MIPS_L1_CACHE_SHIFT priorities
Date:   Sun, 23 Nov 2014 18:40:45 -0800
Message-Id: <1416796846-28149-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Enabling support for more than one BMIPS CPU in the same build may
result in different L1_CACHE_SHIFT values, e.g.

    CPU_BMIPS5000 selects MIPS_L1_CACHE_SHIFT_7
    CPU_BMIPS4380 selects MIPS_L1_CACHE_SHIFT_6
    anything else defaults to MIPS_L1_CACHE_SHIFT_5

Ensure that if more than one MIPS_L1_CACHE_SHIFT_x option is selected,
Kconfig sets CONFIG_MIPS_L1_CACHE_SHIFT to the highest value.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ae8ae77b2ecd..9c09a5a43f87 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1167,10 +1167,10 @@ config MIPS_L1_CACHE_SHIFT_7
 
 config MIPS_L1_CACHE_SHIFT
 	int
-	default "4" if MIPS_L1_CACHE_SHIFT_4
-	default "5" if MIPS_L1_CACHE_SHIFT_5
-	default "6" if MIPS_L1_CACHE_SHIFT_6
 	default "7" if MIPS_L1_CACHE_SHIFT_7
+	default "6" if MIPS_L1_CACHE_SHIFT_6
+	default "5" if MIPS_L1_CACHE_SHIFT_5
+	default "4" if MIPS_L1_CACHE_SHIFT_4
 	default "5"
 
 config HAVE_STD_PC_SERIAL_PORT
-- 
2.1.1
