Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:05:42 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:34909
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992221AbdBGXE15W7kI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:04:27 +0100
Received: by mail-wm0-x241.google.com with SMTP id u63so30970420wmu.2;
        Tue, 07 Feb 2017 15:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eAlv0osZZgDfTGDafZZFb+oSqqLYKb7P1DLSJNZRuTw=;
        b=cX8rU3eCxkjm1SvNdvgqH6LzrlI+CelWMnGkB3dTn/+jk826+/oGOtRTaLrGO/AHOq
         WXRJbxa2e4j8KqcP/nSMnpyiCLPgV9578WLYNS5HSpzXtRlz38Ggzg6Zvj8tuKT9yVf2
         TdaabuJozZipjGDy7P6GI7eTwRKmt9P1PylLUsP2MUiFm714BGXXyMlam0xbgWlcAF4Q
         L6TuDzVyK0ABlvL9ExX3YjkxEVwedf9NihFtmM5JGuxW0VLKRHL4HjRnb2wyR9OObPJX
         3Tz74FGyrjt89XdAqWAOkYIUaBELK9Q2RZTd4SLbWlcjdZm6IKn33xK8YCDsoTHf9Qth
         tSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eAlv0osZZgDfTGDafZZFb+oSqqLYKb7P1DLSJNZRuTw=;
        b=lUM9LN/jizZuaJJp5Nzsx09UsPHIh6gCOH7735J22xksyq3Xdmiomst2tybdW1WDDJ
         32y929aiekxhQis5Gxr/oEgVVrEerq1Qo1sP53vxwSV8lHpmj63L1RKw0vXiHh0eCDmt
         KB+N+OkF30fcZgDiAAFe6ijnmNNWz/78f0h26hS026hiYC9OlfMIwKiw0h4yjprjlKIw
         pwP5Svs21B6atpRdFZEKLIDsJs6aiQbeT1Tq/Y+/lCFEGDjvuA/q2nAXj4kY/EoNQx3n
         bDPOqQltkM20gZymSQYx08QqKvLtd2HTAkvvRfK1FqCCHTuk9fA6d9lmk9F0cf6UGZ04
         fdEA==
X-Gm-Message-State: AMke39my5UMre+rbuP7Uzc7td7TcYe1eobJ0eTfA35N1Qa38yrL47+2hcemGEWE42XezcQ==
X-Received: by 10.28.217.83 with SMTP id q80mr14073721wmg.58.1486508662658;
        Tue, 07 Feb 2017 15:04:22 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:04:22 -0800 (PST)
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
Subject: [PATCH net-next v2 04/12] net: lan78xx: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:02:57 -0800
Message-Id: <20170207230305.18222-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56709
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

drivers/net/usb/lan78xx.c:394:33: sparse: expected ; at end of declaration
drivers/net/usb/lan78xx.c:394:33: sparse: Expected } at end of struct-union-enum-specifier
drivers/net/usb/lan78xx.c:394:33: sparse: got interface
drivers/net/usb/lan78xx.c:403:1: sparse: Expected ; at the end of type declaration
drivers/net/usb/lan78xx.c:403:1: sparse: got }

Add linux/phy.h to lan78xx.c

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/usb/lan78xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 08f8703e4d54..9889a70ff4f6 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -35,6 +35,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/microchipphy.h>
+#include <linux/phy.h>
 #include "lan78xx.h"
 
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
-- 
2.9.3
