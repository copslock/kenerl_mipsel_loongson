Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:04:49 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:34885
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992209AbdBGXENXf-5I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:04:13 +0100
Received: by mail-wm0-x244.google.com with SMTP id u63so30969465wmu.2;
        Tue, 07 Feb 2017 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vlOYoSRaitoUSGk6yP1ryaXFWuinzKAK2fe5kHRvsAA=;
        b=D/FiGqBkM4WpjdGn93cliOWVjnA7B7ccj0yUK7j0g8syNG7IuEa7+hvlqRxqfrCMsK
         kqadORmX/MDYLT6Zkuqcr/tpAePGC1WQdVUnIObBJolrXPAtwZ7E+uczXC375dY4o7qL
         y1betD06kMnCnPEtKhDWFjHDLiAfbuz6zFbPwpbMbqGmfAlxgdGnFmttSvdko43JXYn2
         CmfBVcqkYFj6nQ+fIJJ6CDnDOVAhxTksERk2weU0nkCJyaXh45zoYl4klPrTKQ8jIxUS
         Z552pBy1yqEao0ivTTDrG7KWszHCm2p2HtDfeTD7xDRhJv4u1JEg8ACdyE/mSdknfWd8
         yAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vlOYoSRaitoUSGk6yP1ryaXFWuinzKAK2fe5kHRvsAA=;
        b=U1kJ74rt7fIt4JhmQGPJ3okweldyh7pQ7NaOUlYQ41W/TQ2oytppf36cDXyemB5CxU
         fZZkPyhtqong1xYDAwu4alCr5uImpvAwgRn9FJTXrrt/3aiOP1+IKocq4FMM6OecCBaT
         kvA8TPoAxy238MucYk/m7mCpuqRf7TNJFcmoz8kxMkFrxiWxgSkDeGn9FCFnSk0fasxS
         o8uVSvXhQo3tKCB8LQD/fzvovgTT+JcbKC480P6TXHa3lb3tNILugOlvCEJtXF4EVlvp
         T+bTuRKIk+CsdZ0cz84PrrGf9082NpPPDGvcpIk6Ju7v6qW+EziXRsbYO/VnQZiJEMZ3
         geIA==
X-Gm-Message-State: AMke39lRzVwEu+sk9H1PFwHIFiznzswat7pJIi6KL3QOteqnx0NJtbeo09mxYeWUWK5sWg==
X-Received: by 10.28.17.20 with SMTP id 20mr15776238wmr.106.1486508647575;
        Tue, 07 Feb 2017 15:04:07 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:04:06 -0800 (PST)
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
Subject: [PATCH net-next v2 02/12] net: cgroups: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:02:55 -0800
Message-Id: <20170207230305.18222-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56707
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

net/core/netprio_cgroup.c:303:16: error: expected declaration specifiers or '...' before string constant
    MODULE_LICENSE("GPL v2");
                   ^~~~~~~~

Add linux/module.h to fix this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 net/core/netprio_cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/netprio_cgroup.c b/net/core/netprio_cgroup.c
index 2ec86fc552df..756637dc7a57 100644
--- a/net/core/netprio_cgroup.c
+++ b/net/core/netprio_cgroup.c
@@ -13,6 +13,7 @@
 
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
-- 
2.9.3
