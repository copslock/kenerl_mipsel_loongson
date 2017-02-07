Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:04:28 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:35002
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdBGXEEyYMiI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:04:04 +0100
Received: by mail-wr0-x243.google.com with SMTP id o16so6865201wra.2;
        Tue, 07 Feb 2017 15:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qcCEqxiAtxxa646/dehPwT3HNIWCrvNAncVvkN3FZS4=;
        b=dFBScKQSgf/RKD/uJKOI7DjKgCCYUhOPee+SHJ+NrHaT3Kn9zDDoDqx11Vw8MFdG0p
         v6pbSfTQwkxbfGu/pHGkJ8IDuA3owY2JeB7lbPcy8JirdZgVnxHIJfyrGno6MfwpYY8b
         1OU45mvFantFBqKbk5h8gD84JY1TGFLQqOO0UXmZxAINGMuUI7c1CV5Kv89F/oQv/Bwv
         8CuscZuQCSBpmTV/mJwiB1JeZIMRfQZqJHaF19d4aYl/iMQWyvB5ITP1bfF3/mU7e+9Y
         tt1imroI6skhSxN8yBvmkKXe7U9S+PZMyUGPt4m1iTf69zYQ3TM4qhfF0VojAKjnjUR2
         pRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qcCEqxiAtxxa646/dehPwT3HNIWCrvNAncVvkN3FZS4=;
        b=gbwIbbiRhOBSRA1k5LLwEieOEp2b6R+MHFKvhLF9nTfMiwJcPLdu9c/1UaLUJILkzA
         FVfJVJGatHdUJEW9GjOduae2QJJ4KwrkyJN3HxxAo2OIV9AHRMrycJ9GCqGfRgsfA5Ku
         2W7wc7ih5/nCi9z336fLcCjfd5PJHvrsYlth/R7jtQyeXN+4TI+LdWpG7/RV8lNGlY5e
         aK00gXwb0DBvtggcw1djQ0Pzo59zF8pxxs0rT7KPiC/63OC944zk/D6dDFNZa0pZkLIN
         T4JGLtLTsJawYSUox0bV/F3G0M1g8OeRJvQ6Ii/SmVSlGz4eWzOqG9twgm4aZUxNoY4Z
         AdZw==
X-Gm-Message-State: AIkVDXKwXDmnwJPtP7SRX37SVLn5dG/HOoltJXR4ANz/qUeHer84y8XG35TG1yp/lILtlA==
X-Received: by 10.223.160.246 with SMTP id n51mr15607218wrn.158.1486508639609;
        Tue, 07 Feb 2017 15:03:59 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:03:59 -0800 (PST)
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
Subject: [PATCH net-next v2 01/12] net: sunrpc: fix build errors when linux/phy*.h is removed from net/dsa.h
Date:   Tue,  7 Feb 2017 15:02:54 -0800
Message-Id: <20170207230305.18222-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170207230305.18222-1-f.fainelli@gmail.com>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56706
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

Removing linux/phy.h from net/dsa.h reveals a build error in the sunrpc
code:

net/sunrpc/xprtrdma/svc_rdma_backchannel.c: In function 'xprt_rdma_bc_put':
net/sunrpc/xprtrdma/svc_rdma_backchannel.c:277:2: error: implicit declaration of function 'module_put' [-Werror=implicit-function-declaration]
net/sunrpc/xprtrdma/svc_rdma_backchannel.c: In function 'xprt_setup_rdma_bc':
net/sunrpc/xprtrdma/svc_rdma_backchannel.c:348:7: error: implicit declaration of function 'try_module_get' [-Werror=implicit-function-declaration]

Fix this by adding linux/module.h to svc_rdma_backchannel.c

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 288e35c2d8f4..cb1e48e54eb1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -4,6 +4,7 @@
  * Support for backward direction RPCs on RPC/RDMA (server-side).
  */
 
+#include <linux/module.h>
 #include <linux/sunrpc/svc_rdma.h>
 #include "xprt_rdma.h"
 
-- 
2.9.3
