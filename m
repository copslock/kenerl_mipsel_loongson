Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:17:07 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:35282
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993608AbdITLQQ3d0yX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:16:16 +0200
Received: by mail-wm0-x241.google.com with SMTP id e64so2125911wmi.2;
        Wed, 20 Sep 2017 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Bl/9j7Wf3jg8soLXiHN+cQvG9qEvrfOWjJAbdJOh9A=;
        b=DczwrIg6FXNgiFY1G5IZUPA43h3ND0UheGkOFQ5zTVC5AxXNNfyMHU6D3GSWtroPNQ
         P39fUGK89Wws59yYKpym79cuU/48HJHOiMMqbfwYUfUM3FRJ/wgZKsQLRcgr3INzT6oi
         W4y7ZADfJ4MFxEjIjcV/f8dtXbW6+w0P4jqfJt83T90ToVJ4moeVmkwIro6dbyVZ4wyN
         /q49xcRT1MA2vIayJ1dMDCGFbSOWbG94GgOtTpZ1KRr76o1iRRBFO1yBtNWDD5q+Imr/
         cy2AL6nrq93AZyJtFpldwWQeVY5aOKn2xoClIuhaax6n3ZYRSslOldKPddF1AbmI4Dfl
         jIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Bl/9j7Wf3jg8soLXiHN+cQvG9qEvrfOWjJAbdJOh9A=;
        b=D71emQUUJfxnt+NJ9Gxy0jhNrksg1IIGfMpBGPxifd0bwQuKf2POoyBgJPm7LonaZi
         dmIaBI08lLCtlohyfj0imVlICtUxIzfuI7rw6ae/cqekt+UctEAbYfaC6o+k4TqCfKR5
         dEx2+QMqRKg5zA503v82+R4/EGQcLLaGh3DvFXkbZmhJkYStyNa0VJNEEvte1fBPty5/
         U2iF2GLNxzvNZsCNMeIz2/vsA/yYi8VSnB3n94h58dzMButaDn2117KU8/KcmgwLO8jo
         lcRQTzs09vNsQeT16DGBjZsTH6SBxYB6pmtf0OYJmY4Gc7+B4zYzIgPEjNQHcuiTDho1
         HsUw==
X-Gm-Message-State: AHPjjUgOvEvb/BF8OZA0arBcJ+I3VERJx2XVtNDEJN1gWIAu3k0ABHNa
        QWyJdsG2xkwVRPVAWWiihkburQ==
X-Google-Smtp-Source: AOwi7QCQUzEWsnmLPY28TSEG0/DLXww0ymtHCB0J/LZvjKIccm2dlW6X2y2jHiEzHjKW5K9YcggUow==
X-Received: by 10.80.180.227 with SMTP id x32mr4194360edd.192.1505906170824;
        Wed, 20 Sep 2017 04:16:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:16:10 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH V2 3/8] tty/bcm63xx_uart: use refclk for the expected clock name
Date:   Wed, 20 Sep 2017 13:14:03 +0200
Message-Id: <20170920111408.29711-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60087
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

We now have the clock available under refclk, so use that.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 583c9a0c7ecc..a2b9376ec861 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -842,7 +842,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
-				  clk_get(&pdev->dev, "periph");
+				  clk_get(&pdev->dev, "refclk");
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-- 
2.13.2
