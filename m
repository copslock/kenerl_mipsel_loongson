Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:06:34 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:35025
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbdBGXEmKJoQI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:04:42 +0100
Received: by mail-wr0-x244.google.com with SMTP id o16so6865890wra.2;
        Tue, 07 Feb 2017 15:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fq5YDQRnfYdiR70kAxqjIuPzTf++t/xYs3DHOBXrckI=;
        b=mCfZBGHWxeXlncOskOZmwcuAZYgjYRgRK1ydXx3mp+TcfdbF9hvRFubl5kzKd3rMYC
         3GbaKoB6GQmKiSpv77uWuBYaUdTlBm40cbF81YXAXPEfVYJ/GgN/4/+en6sGFFcInVsN
         VRhTT3T9B4KQcnO4CFP1NuZEaJlxM+iFdL31+6EAN1gqZcxx1ea6bdQMStNujAGv+g/i
         qYcjPUsr4upuYCPS6CoQTAarT8y8W//u/xIeeSCYsSTGHhyQNht1fiC8WHHiIdRozpFs
         OPLwaAkP9nf1u5fU5/l4hw4BI5YnIe0kOB4f/HXy2xsBGig27uI0eWSKTOwhI8pL6mNo
         7eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fq5YDQRnfYdiR70kAxqjIuPzTf++t/xYs3DHOBXrckI=;
        b=sVz4f9U5s29M8xiN80B6qheRoUSOHKPTAqpByfZ2XYA321Ok0a9P6naGahHuVjxvGX
         8Z97DWMIlIxgn3tZI8q5fX6ek5L9wPBFjvl3YyUj3n2zM3gaPrYat/MXqz4XcXBofDFL
         sFeeJ/YpIL3W6b1Wd3eyl8AecgursR8EKKTRdM/Rm9aAG7K/RXDQ7JdaXpuX6Y98q9NN
         ynFzrGxktQ8p0AWCj9RfGi2mpTIi9uom3ynKJ386LKNJM5Ia9kzzxK/oS0VCMZoacnBq
         xUlMdoc7wYZvjhjrTb4lg03xc5Z5tY0513hjNTeHZrBRBALCNmrLwM1A3sFX+PaTJz/Y
         f8CA==
X-Gm-Message-State: AMke39l6VKoVA11aPylvi21LFqb97Hq+gwD6sNMXt/8753VjY9qytu8Qla1xQgabQtghXQ==
X-Received: by 10.223.146.228 with SMTP id 91mr16167050wrn.203.1486508676870;
        Tue, 07 Feb 2017 15:04:36 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:04:36 -0800 (PST)
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
Subject: [PATCH net-next v2 06/12] net: fman: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:02:59 -0800
Message-Id: <20170207230305.18222-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56711
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

drivers/net/ethernet/freescale/fman/fman_memac.c:519:21: error: dereferencing pointer to incomplete type 'struct fixed_phy_status'

Add linux/phy_fixed.h to fman_memac.c

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 71a5ded9d1de..cd6a53eaf161 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/phy.h>
+#include <linux/phy_fixed.h>
 #include <linux/of_mdio.h>
 
 /* PCS registers */
-- 
2.9.3
