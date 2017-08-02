Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 11:37:45 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:36524
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994825AbdHBJfVL-sGy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 11:35:21 +0200
Received: by mail-wm0-x241.google.com with SMTP id d40so6443937wma.3;
        Wed, 02 Aug 2017 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P01t1wfUjgoqPqoQ+ZpIVJqVeUPl2vSPnGjfLm4DMv4=;
        b=FmxrS3eigwrltHBPFn2qsxWW00HvUNadVFXJ7MRfzJKGtv65QQksORg5nzOwJ436Nj
         zjqeFXiFLTAGDkXhXR2EQeHVZQpdzEzIjcbDgH1gM58x33CT7lsNaMwpnkUWzlOmTaIq
         ug21GvA8gIryDrJ1egYDcjtGAySR+OKq9bvzQejCHlCR06uLBi5jKzGNka3n36hWf2gc
         dfkMl87F5o2L0807EDWexrjcxakd6mmPYya2LYzGjl+q+chleq1CKjvjeFMnxuGCWzh/
         kTU0uuZOKLPgfF1FRCb6+7jOAINZ7R4U+T0xh4nGkkZwEZxOzYN2+8Ioccq4g2rVTvBQ
         Iejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P01t1wfUjgoqPqoQ+ZpIVJqVeUPl2vSPnGjfLm4DMv4=;
        b=Sw9Sqx4Gwl3WgA20kxk6kM/5VronQQwzKcRxqFCrv072PeSnKL6n2dNTZEJgI9o0mE
         laY5aTCiVe5Jwp8xPpVCQjvFAazFWIPwhyjaSaE0+yEV2SljTmC1YlXIN4RO+MrE2JBQ
         ms7KZxjUlb5+o0uhHdRlczA+z3icBKYxF9DghUDzsD6MjN6NALj/U09zIJ2a7jo5iGx6
         4dtKhficGoaebm2+tgGO61jewbOS1G4VZYAlevyoF/ZFvpGdmv4bmYjyr6Z5AgttVVH4
         18UNR78dJbXTQHnI6pyxuq35CMczTJNU5DiLIcP/W8/6WL0KhqoASAWBZF8GyLw1Hr9S
         EChQ==
X-Gm-Message-State: AIVw112+sRMd7n65gkjrihC9Hvg4vq1pZKWjEOp30A+cXhnJu1NqoKVn
        rqF7GqdLAqM3Arw1F/k=
X-Received: by 10.28.88.9 with SMTP id m9mr3195284wmb.57.1501666515744;
        Wed, 02 Aug 2017 02:35:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 91sm32058876wrg.83.2017.08.02.02.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 02:35:15 -0700 (PDT)
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
Subject: [PATCH 6/8] bcm63xx_enet: just use "enet" as the clock name
Date:   Wed,  2 Aug 2017 11:34:27 +0200
Message-Id: <20170802093429.12572-7-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59322
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

Now that we have the individual clocks available as "enet" we
don't need to rely on the device id for them anymore.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 61a88b64bd39..d6844923a1c0 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1718,7 +1718,6 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	struct bcm63xx_enet_platform_data *pd;
 	struct resource *res_mem, *res_irq, *res_irq_rx, *res_irq_tx;
 	struct mii_bus *bus;
-	const char *clk_name;
 	int i, ret;
 
 	/* stop if shared driver failed, assume driver->probe will be
@@ -1761,14 +1760,12 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	if (priv->mac_id == 0) {
 		priv->rx_chan = 0;
 		priv->tx_chan = 1;
-		clk_name = "enet0";
 	} else {
 		priv->rx_chan = 2;
 		priv->tx_chan = 3;
-		clk_name = "enet1";
 	}
 
-	priv->mac_clk = clk_get(&pdev->dev, clk_name);
+	priv->mac_clk = clk_get(&pdev->dev, "enet");
 	if (IS_ERR(priv->mac_clk)) {
 		ret = PTR_ERR(priv->mac_clk);
 		goto out;
-- 
2.13.2
