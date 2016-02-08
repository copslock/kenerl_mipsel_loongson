Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:15:15 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34728 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012048AbcBHBJwmfiKT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:52 +0100
Received: by mail-pa0-f66.google.com with SMTP id yy13so5076575pab.1
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=armc4XePUYtdepP6EOcKIhPlBFWTLDb4Fr4GLxD5PWo=;
        b=IGq8/4el57kNRupW+EhroroBIY7X8Q26Kg2zGtQdYnOZJRo0NQIJJj/aVpuW7AG6GB
         L0F9jpwKwWI4wg14FmWjIMJRbup+GhiG6ewWe7YYSwfk29C5l22LXSwGaPr8cQdMg/Na
         y4+DGKcP7/6UJzhGNGDB07gP0Gee+1+lzekBeFX+N8oueLctTt5/Ts6+x2yV8zxCgp0W
         eQqDNHXVxsAw54X202Z6FjxqYXLGUz9NCynKtfOP0s86B7qervvSBxmJHA57mZ1bH+Hb
         ++lzoRzX209pv13fvLORFDtBfevMcp+9xbx+xL1nZsWo+P/eArnPy117zm6f5JPccPuu
         pG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=armc4XePUYtdepP6EOcKIhPlBFWTLDb4Fr4GLxD5PWo=;
        b=jkJjUfXjEaCnE6Ro27lDs5Sb22sbrIZc8o2oGLLamPJMEcfBjeLJODlvHQIztUZcrV
         y2DqsTkxesWvn7Ozx5dE4WzUL8olfrJobuIT+lnbxv36YUSHEtBOLM8JbQZIi7mE9N7e
         t+tG2PmvDB5ox6FgsSlR+c+W2Lx8bXaax9Tj5E5+ym8Kqcaolx67fFmiBBBmqMS2/9wl
         vtbAsGWSBUwrHFfsMLb9NGezXurRYmiAHeaAMt/O6KsQxz02UktKlZM9HpqeFuDlRXoi
         Gbx4LBcg+mYVpioQkxcN6TVd94gg22xFsl4kFm5KdnAGkMHBDOS06fU4E3p+Wu7SWx/Z
         p/5w==
X-Gm-Message-State: AG10YORcXmrQEJ4v3q71q3fEWb9R9Z4D7fApzF5mFPRtT4kXr9BarH9Opj2cPCbJCh43Cg==
X-Received: by 10.66.122.8 with SMTP id lo8mr38981213pab.35.1454893787043;
        Sun, 07 Feb 2016 17:09:47 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:46 -0800 (PST)
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
Subject: [PATCH net-next v7 18/19] net: mlx4: convenience predicate for debug messages
Date:   Sun,  7 Feb 2016 17:09:02 -0800
Message-Id: <1454893743-6285-19-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51839
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
