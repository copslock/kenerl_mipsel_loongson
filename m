Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 11:36:31 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:36343
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992366AbdHBJfQepJny (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 11:35:16 +0200
Received: by mail-wr0-x241.google.com with SMTP id y67so3232171wrb.3;
        Wed, 02 Aug 2017 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y22cRhANdJfpGSPM2vXIcDIFeOdAE+jS9xz1NdH4yZk=;
        b=r1X+2oRoxIJdSVFY++YnSVRH8aijK1ScE+7ynn7rICdTkBZZll9SHNbhM0PpUwNwpO
         J3h+FtgTCd7wvimUHAVUh7iRt2vwH2J21Lf/cWU6pORrrMwJS0v0F7pCKZuR6hfmWCa7
         pd8cbwO/F2hc89ve38d49wZnPSn0++iwDNOYkF+/Uu8HeO0DqOsTUQDoA7pKbttk0dOC
         ZsWF2RhDHH5xBgniWfWAM+aLQp+gnliL0nhaeK9Zk5g/nx2JypegKZX4ZPnEX5ybv8om
         h9MkDoxGWTtetwRacfcDHI3BqKEGOGEu1kgQ0W1rFR76zzu9e57oXyG1NCv3YirZnxmt
         sSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y22cRhANdJfpGSPM2vXIcDIFeOdAE+jS9xz1NdH4yZk=;
        b=dBPSorWpRXA1UjDUVvvhKDfrOEF7l39gK4DB/TW02O8HNKqZUjFNFk6PR6AhrBYOAi
         XzPife7/jNpKo5YkuZQXBS+RQTicQp+PbaXK7ZCNiIjMR+Vqh/nPbJsKy7KU5ojwTYnB
         WuEt+voYa2hkofKsA+aZBaxJjIczHGXQNYlW3XMCQnRJln62/zK8ukC6Styz3E/I/+L6
         v8UTsw8iGtc9twfK3aHJzNW76M5OrBHuKVE6eKeTq4MliOS7SmqfWQyDtXtbiry905FR
         wSjBJZ57sL1VCGLkzdqrLrl2JWBflQnulhVOwED2pd8Mxv62G8UXyninblIU644kN5Xn
         2mvg==
X-Gm-Message-State: AIVw110qa2z2HkJbU10QGTKcj3quWjOIGpsFip60ihuzqlIJ8LXXcBh0
        LfGgG2XbW9shUN9TBXM=
X-Received: by 10.223.171.184 with SMTP id s53mr16049412wrc.75.1501666511146;
        Wed, 02 Aug 2017 02:35:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 91sm32058876wrg.83.2017.08.02.02.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 02:35:10 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 3/8] tty/bcm63xx_uart: use refclk for the expected clock name
Date:   Wed,  2 Aug 2017 11:34:24 +0200
Message-Id: <20170802093429.12572-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59319
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
