Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:05:17 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:34196
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdBGXEUFQ4qI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:04:20 +0100
Received: by mail-wm0-x241.google.com with SMTP id c85so30979053wmi.1;
        Tue, 07 Feb 2017 15:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lYhuQ4v0P99O+R7Th3fGSiwYdECJb1HWLx02D9ibDOY=;
        b=exgsBOvRVyw/sRZtZc67X5A6Mgsq8b50aI9nIQDkamcY2P2q1Ipvl+ARVYpCN/ajBp
         hK9tG+G2EwtApdRglKLuPSY1pAcxDpPM/zGFxgepWQSZd236MSb4eWnRMwgDvRWrw0PA
         lsTytzU3IJ5ekaQHtZey/FaflJQgPpnHFgsAqXYvoOYarRhAl9hIfJ3psECC4IUHqdSm
         cLdaU7wINf0aLbDRkQG6e1CnXYF8qqONT6ih5BWVLQ7+fZxH9ti11I4k7KKkgWS01OND
         qPeh8bNd99+B/ZlpS85OqmgNULMGYUXqw02d2dYBZ4FElvmqR90PgSgs/Ybq6rl0TiAd
         V8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lYhuQ4v0P99O+R7Th3fGSiwYdECJb1HWLx02D9ibDOY=;
        b=lXH4SrWZfsV5+BbOGE9o7ssv/w6DhHn2N/VClkrs9tLQIGiJPNAMTVn/p93jyuE5bO
         N4ISKJw1SUZcy+FElzYpiErXtHisMfbwb1B79AY+gxumupqgONafUhYFD06bUDBcQD1e
         UQ75cXzPp5wq7IhLy5nMx86ZmTZ5n5QpPXNRnXBdfH253pRGbCcY8rXwAToCU+l1RJ/q
         j91rRk6ncsjKzuG04HMU2upNTVKMX3+MlDmLKiDWVM+OPDjDf0WQhQtwoGee1p1w50c3
         wGDQD2luPE0NJ4YQe2feGGKCbKE2YvwcZJDyGYvYa62FeiWs7uV6HDSTTksu6OfiYmDa
         qqxw==
X-Gm-Message-State: AMke39mux08JBBFwf7hwjdkFM8IJt+fYSlfeMi1U4MvqI4IXCUylWUKmPptwGb3tndolYA==
X-Received: by 10.28.215.200 with SMTP id o191mr14612330wmg.118.1486508654771;
        Tue, 07 Feb 2017 15:04:14 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:04:14 -0800 (PST)
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
Subject: [PATCH net-next v2 03/12] net: macb: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:02:56 -0800
Message-Id: <20170207230305.18222-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56708
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

drivers/net/ethernet/cadence/macb.h:862:33: sparse: expected ; at end of declaration
drivers/net/ethernet/cadence/macb.h:862:33: sparse: Expected } at end of struct-union-enum-specifier
drivers/net/ethernet/cadence/macb.h:862:33: sparse: got phy_interface
drivers/net/ethernet/cadence/macb.h:877:1: sparse: Expected ; at the end of type declaration
drivers/net/ethernet/cadence/macb.h:877:1: sparse: got }
In file included from drivers/net/ethernet/cadence/macb_pci.c:29:0:
drivers/net/ethernet/cadence/macb.h:862:2: error: unknown type name 'phy_interface_t'
     phy_interface_t  phy_interface;
     ^~~~~~~~~~~~~~~

Add linux/phy.h to macb.h

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/net/ethernet/cadence/macb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index a2cf91223003..234a49eaccfd 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -10,6 +10,8 @@
 #ifndef _MACB_H
 #define _MACB_H
 
+#include <linux/phy.h>
+
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
 #define MACB_MAX_QUEUES 8
-- 
2.9.3
