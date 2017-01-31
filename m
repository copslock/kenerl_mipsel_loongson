Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:18:38 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:40328
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993898AbdAaTScU8vJa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 20:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Date:Sender:Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:In-Reply-To; bh=ZxDJa5BvXhR8wWexPCNblUMIDl3mMFhgQz9VSFN1kVc=;
        b=as0AavDlh2o6v42zbUk4NWhr1xVN+7sciz5dJ8cY1VG48RkdI8rl7Up/REm41lXptpi0O4JP6Nec3mpdCCoAPt49+Ckj2a0/h4KkkPRcNJ98j7VTVWRvYme4YIK3EhRZqmkuollW7ZehCxUBGYitN0IGDfpa62eaq4g/6laA74k=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:48672 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdwj-0000id-MP; Tue, 31 Jan 2017 19:18:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdwi-0000Vs-97; Tue, 31 Jan 2017 19:18:28 +0000
In-Reply-To: <20170131191704.GA8281@n2100.armlinux.org.uk>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH 4.10-rc3 01/13] net: sunrpc: fix build errors when
 linux/phy*.h is removed from net/dsa.h
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1cYdwi-0000Vs-97@rmk-PC.armlinux.org.uk>
Date:   Tue, 31 Jan 2017 19:18:28 +0000
Return-Path: <rmk+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+kernel@armlinux.org.uk
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

Removing linux/phy.h from net/dsa.h reveals a build error in the sunrpc
code:

net/sunrpc/xprtrdma/svc_rdma_backchannel.c: In function 'xprt_rdma_bc_put':
net/sunrpc/xprtrdma/svc_rdma_backchannel.c:277:2: error: implicit declaration of function 'module_put' [-Werror=implicit-function-declaration]
net/sunrpc/xprtrdma/svc_rdma_backchannel.c: In function 'xprt_setup_rdma_bc':
net/sunrpc/xprtrdma/svc_rdma_backchannel.c:348:7: error: implicit declaration of function 'try_module_get' [-Werror=implicit-function-declaration]

Fix this by adding linux/module.h to svc_rdma_backchannel.c

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
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
2.7.4
