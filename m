Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:06:59 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:35032
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdBGXEszvr0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:04:48 +0100
Received: by mail-wr0-x242.google.com with SMTP id o16so6866102wra.2;
        Tue, 07 Feb 2017 15:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aJWEtj6OKYNDdbrWDSCsS/b3FQY3VNv8YNYUaficLPY=;
        b=KFE3HZh41HYcgbouG9L64IVq22ZZ/jsuSoE4ikndJHOedTFiW9k+rTdPHhpjOdZQh1
         o6ypByf5ai/gO7kSu2FSgMPK2nNt1pxRVXvcWpPaWtBjvM6ZA0/h5Ly7AHffFg5cCrqR
         3jkriKm8fThZvzl+lEdKDxV8/Az9T+DRquihym0fnxJBVk9sM5g+68UwQ7ncyrwEhqtB
         nejn770aBDVYBQicE6p4hIq5oVvkMdyXUDt0acgWSilxm4XzVJhzMfsgSV6ESJxKnbxg
         auElX4zV2xPJdHHNSnzC+/BeoEC8T8xYYTV2PvH7pI1CXHH5Cnl6ZwL9aBNpBKsbgyqg
         kE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aJWEtj6OKYNDdbrWDSCsS/b3FQY3VNv8YNYUaficLPY=;
        b=rh/aMJP9L8GGQ+YlFPVHtZV8a/T5mbpw+qNFy+DEHuUDZRAUNdkNGTkUUTNkE92eHI
         te26Mo6I4ic7Jxga+TE5nPE94MfUGqWfjrZY7oFhiK7YcgpkdODBr9JhK69knKtFuf0W
         pSCXgAVvr8ZSoJtLT6EtP3kbW0jBwA1yJYTmbrnJdoC1wACzQ7E0kY59IYvtsYBWrQmG
         gJYXDGX1aatm46fz6QhogHvzw6Er3c/hpjNaiI1WiLE7Hs5TzQKBqReRvrhx/2LTPKeb
         byfao2MxFiXGq0a4601tYvO8+2/RWZNVZYJQCn9+0uSyul9Zt9jC8o4XKdtnz+Tx1XgL
         3iaQ==
X-Gm-Message-State: AIkVDXJ4RwgR9UkK97X7FrTfLC1/0HZYXbDhS7AqmE0ppuSbcv75wsoPam6hpeKA+L4yvA==
X-Received: by 10.223.135.80 with SMTP id 16mr15296846wrz.182.1486508683590;
        Tue, 07 Feb 2017 15:04:43 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:04:42 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jiri Slaby <jirislaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Timur Tabi <timur@codeaurora.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next v2 07/12] net: mvneta: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:03:00 -0800
Message-Id: <20170207230305.18222-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56712
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

From: Russell King <rmk+kernel@armlinux.org.uk>

drivers/net/ethernet/marvell/mvneta.c:2694:26: error: storage size of 'status' isn't known
drivers/net/ethernet/marvell/mvneta.c:2695:26: error: storage size of 'changed' isn't known
drivers/net/ethernet/marvell/mvneta.c:2695:9: error: variable 'changed' has initializer but incomplete type
drivers/net/ethernet/marvell/mvneta.c:2709:2: error: implicit declaration of function 'fixed_phy_update_state' [-Werror=implicit-function-declaration]

Add linux/phy_fixed.h to mvneta.c

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0f4d1697be46..fdf71720e707 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -28,6 +28,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/phy.h>
+#include <linux/phy_fixed.h>
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
 #include <net/hwbm.h>
-- 
2.9.3
