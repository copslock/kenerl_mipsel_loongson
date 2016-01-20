Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:49:50 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35426 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011081AbcATAofEqyXw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:35 +0100
Received: by mail-pa0-f68.google.com with SMTP id gi1so41971542pac.2
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=armc4XePUYtdepP6EOcKIhPlBFWTLDb4Fr4GLxD5PWo=;
        b=JvBWGbMSJPN98unWtMHy/xQBgKBHlEn/yyzf1DUj8ufmjFHILhggyIqaL/ua8WMntp
         BBiasUlgMFMsrYdizUpxRNvCWmUcxc96G3t4wEFp2hjl+FoeeF4RDEw3EWtY8n5AwUqF
         ePa2WdBLr83dQh0QWwDcMhddY8yqg8BVSqPhDHujGcz5t4QfWJO3Rxp0O/Ueyzq0H21z
         BjVRBeg8WIx9j9Jn6e7kpEc3QMId6eY9BGMw+f40EPkhoiy586Ss35Hx4xJ38yyuWrqW
         yznYDR3DBL/pKyZXC9pF78oCfAoOSo/oR6O0Cz/cvXbZu9t6+b84SfcxanWZdcJhtufW
         WJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=armc4XePUYtdepP6EOcKIhPlBFWTLDb4Fr4GLxD5PWo=;
        b=S/ElspWOuxbii2ycDM3vlo67MIY9nUO49zSrkY3TfM5roQwXEd6UL4zX1cdIpLaang
         MOwlN2PONzSoHqm2L0c0rK77A3UbuJwLuFFyN3V3phj9ycdRVT8LHMDZGQJprLXHwdlO
         8ao3BVj50ZSbVlcgOfA0cb+0OJAnVnN9YuNqPSAXpXej+G155pvuh+ToXPawDGP2lTpa
         4DdgMXiOlzwZZpKUvuJnvhjymQ+dAFiVJBZ8vESYZqAh7qsZ+V/HHT95cIbWU7XYBr+r
         4pvwBinqDybxlI12KMpSTcgcIpNfTH2AEIgevs0wM0MeKwXswAhcfsF6JH1V/uizvHRG
         4t/g==
X-Gm-Message-State: ALoCoQkUjyWVa6YrrfuVpYRBaj/9+FeEXTNqrSPMOIHHlTAR1YS3O/0SM06C+9t5V+N3gzh/j9sbDRZAA9D5UjyQIiPIzrjvYA==
X-Received: by 10.66.255.70 with SMTP id ao6mr48136518pad.64.1453250669440;
        Tue, 19 Jan 2016 16:44:29 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:28 -0800 (PST)
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
Subject: [PATCH net-next v6 18/19] net: mlx4: convenience predicate for debug messages
Date:   Tue, 19 Jan 2016 16:44:03 -0800
Message-Id: <1453250644-14796-19-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51246
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
