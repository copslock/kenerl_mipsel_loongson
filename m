Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:33:54 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35179 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012502AbcBJAaRGzjKx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:17 +0100
Received: by mail-pf0-f194.google.com with SMTP id 66so173078pfe.2
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zlvzA8cSGAN/q/RmhVlpyKrKeU8P8LUXLwV9qsqWtIo=;
        b=UhhlbO21hUb5bBn+F2Olwcu+QQ8wdkw1T+vPnuQ0rlBSTgN7OOC5Sf9eaxFeCxfwte
         eX2yjUY7xYxNTR5yHo1NaG3BVhnaYnNDdwAqnPNceNSoPY/YEoSDulCYbAcv+jv4CA8T
         1m6Z4/fI4bJgiYksBSENY2CYNvll47hF2OwASrFANzuBouq4sm5Yut0ijsMMU+4l9fJr
         C06HYHPCagKT+OwPaJU7SzJAj4CNMfhR0JIGtPvrLzi8cc9cca0YicUo3sM4mO9oSmqn
         eXf/UaHeymEOKcrXwE3aseA8H41uqMVvJul2pimYMJuC8OLL9uU9bvK+1gVGoWgs6yyi
         cX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zlvzA8cSGAN/q/RmhVlpyKrKeU8P8LUXLwV9qsqWtIo=;
        b=QSx/luCYaLP3vbmQS70O4Nl5pQP8ZesNYKnJvt82YbM1kDNB9X8U39g6TF/k99Wv/E
         uiVsS1kowUOjgR8iA0o25dy0mx8mkhcgCBYp93QRZpr20COxyHBUQeCYDpAIsP2MCKlr
         fJiU4QF2PVBE4vyMBvokUWUgai2bh3f7nNqwfB7klNk3ea4tsKqWUO8izlnYD9/98U0J
         cx+p7Kx/zsn1Xvh0i2TPNZjwNiA+98MO1x27UnWhaRQQvq/KtrShu5r/Rn5xqChI4LDm
         FtFsxT0J2qPHuLtdfmJPtwmRO0xtZOz8xgFdiolgqTjhHtb9l8f5qNuKm9uh0VMv/eEp
         jWsg==
X-Gm-Message-State: AG10YOSezMoQTtF4gJIpR0G9lqvvzcmUCPHWVn62g1DcuBwWLInF3YUhYUUVuSKwW/54HA==
X-Received: by 10.98.34.84 with SMTP id i81mr53955813pfi.160.1455064211531;
        Tue, 09 Feb 2016 16:30:11 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:10 -0800 (PST)
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
Subject: [PATCH net-next v8 13/19] net: rdma: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:22 -0800
Message-Id: <1455064168-5102-14-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51951
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
