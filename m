Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:07:20 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:33479
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992903AbdBGXE4C4TGI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:04:56 +0100
Received: by mail-wm0-x242.google.com with SMTP id v77so30889642wmv.0;
        Tue, 07 Feb 2017 15:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Uvepsogu80TqyvA70jHOPVlqznY7HdztCe8CinrtvU=;
        b=B0q0PFHxYm3Vfp6out4mEoX1k2vcPshElovjwy8KLrzdxqH6ATUmstdqTobel4b2P8
         xpIPQQL0zdbPtbTRM4lORF2z7WaZw6+FzJTR7B7Bt3SsE0jVDptlDUC/jC2h26rKZh4u
         DltFAYwR4VuGe+Sa/zquCqEWFaWlY4vy+3B6X041q7rQ20cBpoYusnhJq7xwLUDxFPHh
         Mw3+4z6l6nG7m3Xx6jDhx8D3ynnKuCej9V+RjkmR4QEoyfUOazpAZvFETpJvzp03exil
         NOk9hubW7LTZzgf3a/HmJ5sJIFZdm4xx85+Wa47xnAa4RyJaef5CrFhctIAXIXGpKV0F
         Slug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Uvepsogu80TqyvA70jHOPVlqznY7HdztCe8CinrtvU=;
        b=nRwpIVBtkboPeLlTrnnbRADQTF6Xl+ejLSjJg4d+Dr/eNNSNcI7LT4sYATnW34qQN/
         1d0CJ12lScDgbx+QdRGOmTrAMkRi/1S1jQb889PNH6lZ0piQdO1asjZVivLtjtIbZgG6
         x/bY53qfN7nPt5sYCZ+wdSCpVkahVpc/TLuBcUzw8spy7DeBnr/QmRQPC+iFBgeZFqey
         dat7BaQMRcS2PmWV9FAXBvShaQLe+L4XVu2JqrgA16BIX13g2eLJbp2OjdLO6Ug88fFJ
         wAePobfNsjw20TiEuktBXJ14/Ij8dBzxoiY+9jseIewuvyW37GH9v8L16aiBHv7T2ltw
         nX1Q==
X-Gm-Message-State: AMke39n0YNAvYZ/nRV5NPTT0xU+hJ684ABnGNvhZE/ElyOyujz39KLI3ADJfVbgOroTKhQ==
X-Received: by 10.223.146.228 with SMTP id 91mr16167603wrn.203.1486508690766;
        Tue, 07 Feb 2017 15:04:50 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:04:50 -0800 (PST)
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
Subject: [PATCH net-next v2 08/12] iscsi: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:03:01 -0800
Message-Id: <20170207230305.18222-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56713
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

drivers/target/iscsi/iscsi_target_login.c:1135:7: error: implicit declaration of function 'try_module_get' [-Werror=implicit-function-declaration]

Add linux/module.h to iscsi_target_login.c.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 drivers/target/iscsi/iscsi_target_login.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 450f51deb2a2..eab274d17b5c 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -17,6 +17,7 @@
  ******************************************************************************/
 
 #include <crypto/hash.h>
+#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/kthread.h>
 #include <linux/idr.h>
-- 
2.9.3
