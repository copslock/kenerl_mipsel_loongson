Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:09:06 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34259
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993016AbdBGXFWIXQCI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:05:22 +0100
Received: by mail-wm0-x243.google.com with SMTP id c85so30982367wmi.1;
        Tue, 07 Feb 2017 15:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/tgnjFydSER7FEIkvl5mqyQQKRRMyd8WvoKZUFmtUI=;
        b=bGy9SoinlTl9TO73X05R6p/6+AtQsIrDkiRLVcbNUU+RXKmP7/mM0D+QoDnEJpWBRH
         B25va6qCW36WdQ3EefVH9oGpEXiOq68QhGcZAVY9tES73MXh12vBQ+t5ym34zacKBnSY
         fp6Rx0AiqpG6edqbLz+8PUuuusfJ3oDV15RO9bGcnLpXnuPuBvfoVKGMJq5Q91vnjaug
         TwOQMo85OQFSLG1Rd5njFIxU4yaH4jjDSjNOqs0yPNHjDlHAWrF58LxKZS7Xw0EBlcwC
         WWmx1uNHYwN+B24syvX7qS/GLpH95uQMSYPAeqoJyJVVuODVPLpsi4eCkM1VlWV5tBvi
         52lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/tgnjFydSER7FEIkvl5mqyQQKRRMyd8WvoKZUFmtUI=;
        b=pcsCtaOsYbyfbLb7JTHoJk7Ffy/Fd4NhwQVaxvXAARM+p6w7JPsPX7xcRVxjPrqQmT
         IRBL+dErUrrqyw0jFx4bC9xozmxRkEgs3is20KcMloJqqS6CvMc0lZRdwPuuJqWUErPR
         VUw3XUZq2luIBYzP8tR4cqf1gNDQko0XARanICXgCdqd7zmAdf3rl+xGntxq9rjOMryf
         NjaJqMTCCZopRt9P6v6gHMrmhuhVYdMl3lAvxvhtDRE4zdYlMh7xTNwM66Djf45rZgwt
         VreSTv+S8qRiFNq2uBLI/L8HkOqm4K6jT20nKJ7YO63s++AhV7vMIaCkxvZ8l/ATsBLW
         1anQ==
X-Gm-Message-State: AMke39neqVBjIP6qtN6kt1c47e79StTgoNcUgMkp4/2FByHY8JMudTZ26BPTuUVrtnQm1w==
X-Received: by 10.28.127.13 with SMTP id a13mr14329084wmd.96.1486508716813;
        Tue, 07 Feb 2017 15:05:16 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:05:16 -0800 (PST)
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
Subject: [PATCH net-next v2 12/12] net: dsa: remove unnecessary phy*.h includes
Date:   Tue,  7 Feb 2017 15:03:05 -0800
Message-Id: <20170207230305.18222-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56717
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

Including phy.h and phy_fixed.h into net/dsa.h causes phy*.h to be an
unnecessary dependency for quite a large amount of the kernel.  There's
very little which actually requires definitions from phy.h in net/dsa.h
- the include itself only wants the declaration of a couple of
structures and IFNAMSIZ.

Add linux/if.h for IFNAMSIZ, declarations for the structures, phy.h to
mv88e6xxx.h as it needs it for phy_interface_t, and remove both phy.h
and phy_fixed.h from net/dsa.h.

This patch reduces from around 800 files rebuilt to around 40 - even
with ccache, the time difference is noticable.

Tested-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/mv88e6xxx.h | 1 +
 include/net/dsa.h                     | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/mv88e6xxx.h b/drivers/net/dsa/mv88e6xxx/mv88e6xxx.h
index 8a21800374f3..91c4dd25c2d3 100644
--- a/drivers/net/dsa/mv88e6xxx/mv88e6xxx.h
+++ b/drivers/net/dsa/mv88e6xxx/mv88e6xxx.h
@@ -15,6 +15,7 @@
 #include <linux/if_vlan.h>
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
+#include <linux/phy.h>
 
 #ifndef UINT64_MAX
 #define UINT64_MAX		(u64)(~((u64)0))
diff --git a/include/net/dsa.h b/include/net/dsa.h
index b49b2004891e..4e13e695f025 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -11,17 +11,18 @@
 #ifndef __LINUX_NET_DSA_H
 #define __LINUX_NET_DSA_H
 
+#include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/list.h>
 #include <linux/notifier.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/of.h>
-#include <linux/phy.h>
-#include <linux/phy_fixed.h>
 #include <linux/ethtool.h>
 
 struct tc_action;
+struct phy_device;
+struct fixed_phy_status;
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE = 0,
-- 
2.9.3
