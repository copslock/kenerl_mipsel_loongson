Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:47:06 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36548 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012027AbaKGGpRxjRDh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:17 +0100
Received: by mail-pd0-f169.google.com with SMTP id y10so2759905pdj.0
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tjPEmFBZBdGRQMyHVqR7Wa//Jjkmh7h5mvBYaufuTYI=;
        b=dSFmEiWf1K1j7UYuuAryGkB6ZFwHVouNH+F1bMl50FVSMCU4xkLmumYP9EIxG6X/+u
         UqPg83GvRC8ADGXxXrkRQWRT41MbcxjmowHmIkz6wTB+3tK4D6/b/1kSWicCqiWQwVfh
         9YPmi0MmjRo9OBHeu3USsJkFQdFX5xjW7hOp3HIejvOlkt7lIXJ+CsmIhr91H1dGg+1q
         vIrvTTt3tg/p9wKpZv90ctdCmRSB41PAirBb5HAUz+bthjPgt5fc+txzwXbkkqoaj+0k
         22tfKl/S/dcGf/k9wIQoY8J1mYjP/AUoZotspYdxYj//RsDBsjmk1khKuQr0MiZGo2uB
         f9qw==
X-Received: by 10.68.189.136 with SMTP id gi8mr9921445pbc.54.1415342711917;
        Thu, 06 Nov 2014 22:45:11 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:11 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 07/14] irqchip: bcm7120-l2, brcmstb-l2: Remove ARM Kconfig dependency
Date:   Thu,  6 Nov 2014 22:44:22 -0800
Message-Id: <1415342669-30640-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43900
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

This can compile for MIPS (or anything else) now.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b21f12f..09c79d1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -50,7 +50,6 @@ config ATMEL_AIC5_IRQ
 
 config BRCMSTB_L2_IRQ
 	bool
-	depends on ARM
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
-- 
2.1.1
