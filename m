Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:35:26 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36252 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012511AbcBJAaZMhwmx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:25 +0100
Received: by mail-pf0-f193.google.com with SMTP id e127so170872pfe.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=armc4XePUYtdepP6EOcKIhPlBFWTLDb4Fr4GLxD5PWo=;
        b=igdNuEz4ioa+MQ2KXuWiJMKCQMki/6E/vipWPMz0vbrh6sectiYf1bEfbWF43sEI6+
         sVVExZACdc8rk1g5pnYDmS1Dah3tD8Z2znrPpAFz15lAgtqm4q9MQTV+MVhPFIznfgMU
         d5LD5/Z1jPWKh6Jeis9Q58+Vs7nI1FhyhfMKbYlmI6Qys+v8p3Stg7BHNxA9lhpIWzVJ
         6z2dGK5Xe7EDtYZTItH48yUQh2b7sfnfovs+sWquF7BBZGkTqZpEo03cvPei5P7GdTEG
         9BXWEeKEAqMfEtJOSmTslqm5CJ33Fxgfbp2aJnv+wJeMBPxZVuAfE90Pq4RFDR15I/Xf
         buwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=armc4XePUYtdepP6EOcKIhPlBFWTLDb4Fr4GLxD5PWo=;
        b=Ngj7I3qxN+l3efLDroIGcOMsdDW9llgZSQ0orMNTB23h4LqUShXRbe2GlqlVw4ICkw
         sPkF+Z5g5LKHlMjRuUqOqPsHQtsLNmKV+DM65VsFrBvNxJMCe1uO7MKjy9/nXHAb/Xw6
         /ESkyrQHkkzFpufIB5SAQXAIwJIf70+u3e/tlNdNMTz7Aijc/2+oq+d/5Jq5Le8/W3jT
         OItQoxRyxoUj0zyEeRg/Paqs7anCgYhasSq/tGAztcsLpBkDI095T8naGdqVH8KYjCnN
         DBK0U/B/f12gV4Y+e19eHI2IxaSHYWjXMzwwy65awNJ4I3hYx6lJjWqH36vQu/FyX12C
         iaMw==
X-Gm-Message-State: AG10YOTbtQ31Hxx63N5B4QG/mp+vC8fJJeeou/4T2JRqVE/bpgbS8DjOx0yX9pC3iGuDDw==
X-Received: by 10.98.44.73 with SMTP id s70mr13708807pfs.2.1455064219621;
        Tue, 09 Feb 2016 16:30:19 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:18 -0800 (PST)
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
Subject: [PATCH net-next v8 18/19] net: mlx4: convenience predicate for debug messages
Date:   Tue,  9 Feb 2016 16:29:27 -0800
Message-Id: <1455064168-5102-19-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51956
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
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 35de7d2..b04054d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -740,9 +740,11 @@ __printf(3, 4)
 void en_print(const char *level, const struct mlx4_en_priv *priv,
 	      const char *format, ...);
 
+#define en_dbg_enabled(mlevel, priv)		\
+	(NETIF_MSG_##mlevel & (priv)->msg_enable)
 #define en_dbg(mlevel, priv, format, ...)				\
 do {									\
-	if (NETIF_MSG_##mlevel & (priv)->msg_enable)			\
+	if (en_dbg_enabled(mlevel, priv))				\
 		en_print(KERN_DEBUG, priv, format, ##__VA_ARGS__);	\
 } while (0)
 #define en_warn(priv, format, ...)					\
-- 
2.7.0.rc3.207.g0ac5344
