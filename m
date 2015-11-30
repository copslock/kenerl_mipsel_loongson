Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 23:11:18 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35171 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010602AbbK3WGxXgPxY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 23:06:53 +0100
Received: by padhk6 with SMTP id hk6so26757776pad.2
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 14:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZ8owgYrInEviVftSyw6eg7uZYhotHL+sIyVXwpx+NA=;
        b=Hok89Y1hXq9hB/pCUS5L8Xdw4CIrA07d0hipm9hRkFFRbSKX6pfap+yklQk5kGUzeA
         UnYrGpyCwf9fet0K5bavGE6Gn3Ky2AeR3An9IYHdhbmI5rTH9la2Dbp0Xere45jqoKqz
         RRKp0BPjcEbO8/Qqd58+bXOB3sn+3mLJhRoqq7dBzBFLBQ0VadtstREcc9j7VKdzoBPo
         Jqhnlzydj6VXoQgi+mAIIcP7VF/8AWJ3MihqbGBFOa3QQH4i7y1iOfc07WkIaVoNS/zz
         MjYHtaShS8lDIWb/yLxILkqbjnBShdssL9uAGxYNGoCtZxI7h3/9Pjvndtqasp+41IOm
         S2tA==
X-Received: by 10.98.44.193 with SMTP id s184mr74718094pfs.8.1448921207711;
        Mon, 30 Nov 2015 14:06:47 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id p6sm53253789pfi.20.2015.11.30.14.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 14:06:47 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        Amir Vadai <amirv@mellanox.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v3 16/17] net: mlx4: convenience predicate for debug messages
Date:   Mon, 30 Nov 2015 14:05:54 -0800
Message-Id: <1448921155-24764-17-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
References: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50238
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
2.6.0.rc2.230.g3dd15c0
