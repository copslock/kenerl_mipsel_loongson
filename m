Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 14:10:19 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:60112 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992907AbeIOMJTN53j2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Sep 2018 14:09:19 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 85A70497DE;
        Sat, 15 Sep 2018 14:09:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id Uea8bTJwhn2J; Sat, 15 Sep 2018 14:09:12 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH net-next 5/5] net: dsa: tag_gswip: Add gswip to dsa_tag_protocol_to_str()
Date:   Sat, 15 Sep 2018 14:08:49 +0200
Message-Id: <20180915120849.24630-6-hauke@hauke-m.de>
In-Reply-To: <20180915120849.24630-1-hauke@hauke-m.de>
References: <20180915120849.24630-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The gswip tag was missing in the dsa_tag_protocol_to_str() function, add it.

Fixes: 7969119293f5 ("net: dsa: Add Lantiq / Intel GSWIP tag support")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 net/dsa/dsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5f73e96cc9e6..a69c1790bbfc 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -88,6 +88,9 @@ const char *dsa_tag_protocol_to_str(const struct dsa_device_ops *ops)
 #ifdef CONFIG_NET_DSA_TAG_EDSA
 		[DSA_TAG_PROTO_EDSA] = "edsa",
 #endif
+#ifdef CONFIG_NET_DSA_TAG_GSWIP
+		[DSA_TAG_PROTO_GSWIP] = "gswip",
+#endif
 #ifdef CONFIG_NET_DSA_TAG_KSZ
 		[DSA_TAG_PROTO_KSZ] = "ksz",
 #endif
-- 
2.11.0
