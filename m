Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:48:35 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35792 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014804AbcATAobwxTyw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:31 +0100
Received: by mail-pf0-f193.google.com with SMTP id 65so13873743pff.2
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oKd9zDo6KtWMBguni8s/XjoE69V8BH/xfQudHkpbw6U=;
        b=zPSfUCNKc335SnPFFRs4gkCSNuYgEmo+nnnAZ44DNGvggHIp5eY89uNrDqcnj0wDEv
         byOCbI8hg2Z8cZg0o3kJkPqmPAx36ERcm36qM096YTqZjeRy/Y1ZVZ+3tel2v8eqvQhl
         tfeHPLNihZSq7YTZbQ3Col/ylLjBETBpGISAiPq+KESoOKc5zgJwW4xTJFVrML/O1uZd
         P4XwAtAp4+/qemnzWxFDRX5HmEK28FLyMt3SgsiTn8LnKYmb5PUEDEnGaIFCmUlL038i
         h88wUoD6AxoyCFB2yIBalaZVn3b6a8TnAgn5cvIzX6gFJL7iPDdDkLWo6l9vlU1j6PPy
         OUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oKd9zDo6KtWMBguni8s/XjoE69V8BH/xfQudHkpbw6U=;
        b=DeU6RvhChQH+iC9JiFX1BNNeW748NyeJ12FOXb/4HB7mbfIuBkuYvCVo1L4DWWTkvf
         ZHCK9CzJ1/ybjMt12dy7jbeph+IQDCQp+g6yEm1wE0wkfzuEzn5miL/mW2rcerrmP/tC
         j+SLwbw/YDf5kvpSI3Y3RQ4043pRSeh7VrGiGWvd082nls/M02vSQUDWAieoquI/honG
         xexV9yE2Pyc0vrSPgRFV6zTQq0JAwHZA3FtlTUu8nWXvQ3PqzmZjZoyRRF9M4zI9b1ci
         AyvGVT9sapc2x9pjv82goLWvgOpAi97P3j1ZzZ0xrFk5fLCr7BZYSXe6mfbmJd/R70id
         RqEQ==
X-Gm-Message-State: ALoCoQmVsnEf5KUYkUAlTTgXzCDEx97o/UaZpPgoUMpyfmoHthaxrVuaPespu2YrUdzJDeMGG5LulPHyKWgzS06SVH9a/TFHXw==
X-Received: by 10.98.65.9 with SMTP id o9mr48032990pfa.114.1453250663578;
        Tue, 19 Jan 2016 16:44:23 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:23 -0800 (PST)
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
Subject: [PATCH net-next v6 13/19] net: rdma: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:43:58 -0800
Message-Id: <1453250644-14796-14-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51242
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
index 1152859..1820f26 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -254,24 +254,22 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 
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
