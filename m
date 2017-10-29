Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2017 16:28:18 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:43504
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdJ2P1rDxTE7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2017 16:27:47 +0100
Received: by mail-wm0-x241.google.com with SMTP id m72so7829338wmc.0;
        Sun, 29 Oct 2017 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nzGeyTHrY9UQWxEbYSikFyL8On7MrTRApuQvU2Kfp60=;
        b=tx5wBPYgZIGp5V5/I4g3YoV3U7ubLb6wUuq6/kCUYp3FNqCVjfeLLk+sZ7FAd82pN3
         tOS4bjb9Tt6tJYeZKsfrZ3qeWwAOQ/lb75exHQep6pIAWLPR3mAwfkKyZc6hRCDIjO9e
         maAEZGK20eR5BijXA5Hcta6XgmF+agxoLNATkrb9XLJvTtVI4mSJUweb4WMedOdOAxCq
         5KawB/Z8YuA9wLY//8rM+blloLs00glQvkrHr2EHEOWs9pnzCsfCjCt1einNx1GiRFc8
         dwgMeMYmY9trugnPo9/Ev2JdC08ZTJ3x0vRl7iUJvHR8MwL++DK+rM+DN2nJ+89czT0o
         BV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nzGeyTHrY9UQWxEbYSikFyL8On7MrTRApuQvU2Kfp60=;
        b=OiGNPMbdix+vgDaHMcIGlmjX4H2qRDSwWaOj4F3x0yOtKW/jl3lqrcg6Oi/YSLaln9
         rvK6vjzyCWJkBnBW1r3V+ILXymNDKTUsRvzZxq5F+M8MCVldkU8lVIehxJr6drP3s9hP
         OR8JqX1Yfn9FhmjBKImbfrlX4jDAibs9jO1kxi4apVfQWTScQSz6dRKQcanZQked1t6q
         52KEjemWZEd2jqVpSwK1nhxEf1Em7MbF3CVV9SDQRv6D/UktFncRjP2k/Xn0sdY8qlkS
         jIbCv6tApuSJHp9CEQ1ppXVE9U0sEzDr1ruUZdhiFjXp1n+sVOE9+DFV6AuxMLAGlnmi
         Yzzw==
X-Gm-Message-State: AMCzsaWs4VDbfwQb/YIGFjzSEz9DgUL0840arxz6nLW2ltIir+CleiAL
        IDPsxmIvjjlLJMUyshNzMXIF2A==
X-Google-Smtp-Source: ABhQp+Tsi1f3is5wJPhjZJ84TTwmiBt7xIPescHvNCAiP5HFU/ZLZLVCCj1zx4Nq4bCRORzbeWDzIQ==
X-Received: by 10.28.69.210 with SMTP id l79mr1653920wmi.117.1509290861613;
        Sun, 29 Oct 2017 08:27:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id m26sm12498532wrb.81.2017.10.29.08.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Oct 2017 08:27:41 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 1/3] MIPS: AR7: defer registration of GPIO
Date:   Sun, 29 Oct 2017 16:27:19 +0100
Message-Id: <20171029152721.6770-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171029152721.6770-1-jonas.gorski@gmail.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

When called from prom init code, ar7_gpio_init() will fail as it will
call gpiochip_add() which relies on a working kmalloc() to alloc
the gpio_desc array and kmalloc is not useable yet at prom init time.

Move ar7_gpio_init() to ar7_register_devices() (a device_initcall)
where kmalloc works.

Fixes: 14e85c0e69d5 ("gpio: remove gpio_descs global array")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Text shamelessy stolen from commit 2ec459f2a77b8.

 arch/mips/ar7/platform.c | 4 ++++
 arch/mips/ar7/prom.c     | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index df7acea3747a..f2c9f90c5f13 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -653,6 +653,10 @@ static int __init ar7_register_devices(void)
 	u32 val;
 	int res;
 
+	res = ar7_gpio_init();
+	if (res)
+		pr_warn("unable to register gpios: %d\n", res);
+
 	res = ar7_register_uarts();
 	if (res)
 		pr_err("unable to setup uart(s): %d\n", res);
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 4fd83336131a..dd53987a690f 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -246,8 +246,6 @@ void __init prom_init(void)
 	ar7_init_cmdline(fw_arg0, (char **)fw_arg1);
 	ar7_init_env((struct env_var *)fw_arg2);
 	console_config();
-
-	ar7_gpio_init();
 }
 
 #define PORT(offset) (KSEG1ADDR(AR7_REGS_UART0 + (offset * 4)))
-- 
2.13.2
