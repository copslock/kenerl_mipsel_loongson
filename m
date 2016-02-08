Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:13:37 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34715 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011987AbcBHBJpqqkAT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:45 +0100
Received: by mail-pa0-f65.google.com with SMTP id yy13so5076505pab.1
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zlvzA8cSGAN/q/RmhVlpyKrKeU8P8LUXLwV9qsqWtIo=;
        b=QFn719e58hrmJZyXHOQ+lPWB4LokvSSme0lF9De4bLiQSV0m2HPwN+AcElrCF65kym
         jmGFi+Xj3FltH512lY9E/iBJy2m05ccZ0K3RffQoVKNCi8/OeovdPmj08kGmqpysrqk+
         lfsX8g5XPgaOmv0kILMlvshW1FoepAj/LjoflvzwGQWGDPmZYTrD6zBj8QFZiQrCGPSP
         nTQeAV+u341hqowAFK2VruVZujJoiKwQGLMX7xhutnyIXcwKTcCm6yrCFKblLXRkrDoR
         0X1Tw5swLQYg3XGDXojwEwuH0hNBmBNS2spnyXBTe/3sc8bU224bKCk0dUiSNm/n+cNQ
         //Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zlvzA8cSGAN/q/RmhVlpyKrKeU8P8LUXLwV9qsqWtIo=;
        b=FKcHbqOjDMilTR97VB9tp8eraXerYJ3KifnfCnIfj2QrxqqXiXkLDEm5BJj4Fy2DqV
         kXwGwY8uhWCUSZsmSYYCHBo2enj/qJi2KCNIOVdZIFVGN2zL+qztGTRwzAyMDBc0Kpfp
         gRFzg0mvtG+77OP8jIuJnniwV3m+y0vNPkI5y3t/Tqb32Z2CXQ09z5kCyWu9WKPsHo9G
         TjXcmb6vvrxcbFDbkI1zFyS5tiilD5ZqTqWHDuusqC00GZbJ+qu7n/R7mx2/IHEB/yRr
         c6esXUyNMxGeTkpk7JdyZZ5EsfnImdrscoX3TCoMON7NJ4V48ha0u3kuv8YcVh2uDFzL
         Ny9w==
X-Gm-Message-State: AG10YOTl7Cw/lFvbyp7aklRtTIN/aipFXhAsEPcRnIWOQZPAtWP6+p9jwfPdeQYoA74hsA==
X-Received: by 10.66.193.195 with SMTP id hq3mr38684845pac.38.1454893780158;
        Sun, 07 Feb 2016 17:09:40 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:39 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v7 13/19] net: rdma: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:57 -0800
Message-Id: <1454893743-6285-14-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

From: David Decotigny <decot@googlers.com>

Signed-off-by: David Decotigny <decot@googlers.com>
---
 include/rdma/ib_addr.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index c34c900..f669751 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -262,24 +262,22 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 
 static inline int iboe_get_rate(struct net_device *dev)
 {
-	struct ethtool_cmd cmd;
-	u32 speed;
+	struct ethtool_ksettings cmd;
 	int err;
 
 	rtnl_lock();
-	err = __ethtool_get_settings(dev, &cmd);
+	err = __ethtool_get_ksettings(dev, &cmd);
 	rtnl_unlock();
 	if (err)
 		return IB_RATE_PORT_CURRENT;
 
-	speed = ethtool_cmd_speed(&cmd);
-	if (speed >= 40000)
+	if (cmd.parent.speed >= 40000)
 		return IB_RATE_40_GBPS;
-	else if (speed >= 30000)
+	else if (cmd.parent.speed >= 30000)
 		return IB_RATE_30_GBPS;
-	else if (speed >= 20000)
+	else if (cmd.parent.speed >= 20000)
 		return IB_RATE_20_GBPS;
-	else if (speed >= 10000)
+	else if (cmd.parent.speed >= 10000)
 		return IB_RATE_10_GBPS;
 	else
 		return IB_RATE_PORT_CURRENT;
-- 
2.7.0.rc3.207.g0ac5344
