Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 15:29:51 +0200 (CEST)
Received: from mail-bk0-f52.google.com ([209.85.214.52]:53859 "EHLO
        mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862584Ab3IRN0kPkdRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 15:26:40 +0200
Received: by mail-bk0-f52.google.com with SMTP id e11so2755194bkh.39
        for <multiple recipients>; Wed, 18 Sep 2013 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h6bl6yvZ7oJIepvBlzf0smC8VMW56IknXD6yTxYLTes=;
        b=S/q4L+7aMnCyVuD3Ullm+8xb0JvPrn5KvWmYo12/De51i36EL0PiG+Zk+zRNoC9Wph
         uENQgo7hdo+lP9SOKpPiIWrgdv09H/QCqmGFYUUUOl5Gltkwlj8i2K4IGP1+56Va4jEE
         iI8BXVQQVI7BbYxHQBnylD0PYOYLSlHEHEVcGEPq7wSoFLELtQyK3Uz6zEF1r1ek3at2
         PZ1IGgLZQAGbP2uGZoiQnD2pfjiskyaQ2SrvxcleeCPpE9Dh+9aOb54T7PdSOtbZp93K
         oG4nYvejLX4rrkjnLLlQtPYyWZoYIkGPlXzuMilEoebnDsKWHl4bHeiBReJ7W+X9yEm2
         JHKQ==
X-Received: by 10.205.76.133 with SMTP id ze5mr1713079bkb.37.1379510794807;
        Wed, 18 Sep 2013 06:26:34 -0700 (PDT)
Received: from localhost (port-55509.pppoe.wtnet.de. [46.59.217.135])
        by mx.google.com with ESMTPSA id on10sm899081bkb.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 06:26:34 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <rob.herring@calxeda.com>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] gpio: tegra: Use module_platform_driver()
Date:   Wed, 18 Sep 2013 15:24:52 +0200
Message-Id: <1379510692-32435-11-git-send-email-treding@nvidia.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

With the driver core now resolving interrupt references at probe time,
it is no longer necessary to force explicit probe ordering using
initcalls.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note that there are potentially many more drivers that can be switched
to the generic module_*_driver() interfaces now that interrupts can be
resolved later and deferred probe should be able to handle all the
ordering issues.

 drivers/gpio/gpio-tegra.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 9a62672..766e6ef 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -513,12 +513,7 @@ static struct platform_driver tegra_gpio_driver = {
 	},
 	.probe		= tegra_gpio_probe,
 };
-
-static int __init tegra_gpio_init(void)
-{
-	return platform_driver_register(&tegra_gpio_driver);
-}
-postcore_initcall(tegra_gpio_init);
+module_platform_driver(tegra_gpio_driver);
 
 #ifdef	CONFIG_DEBUG_FS
 
-- 
1.8.4
