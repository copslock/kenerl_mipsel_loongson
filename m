Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 20:58:31 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:49542 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012467AbbBDTybjnaPa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 20:54:31 +0100
Received: by mail-ie0-f176.google.com with SMTP id at20so4812311iec.7
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 11:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w4q0qMqnY1opseEdYnWsuE7GGqKD5eb5dpdQ5rlxsKY=;
        b=k33Q9PjJ4c+MvYa3TyTz4Tr6p8D/QVkvdukHqLeHAuiJrjELsNYR+Q0kCcoLpaVUho
         t0/8fNv122xvv/tim1BsDl3kk/7+Ro/EkiNZlZH4zMHPxmOOed9XNhtlxiL01CIWJFg6
         CWAdOwVTui84WSyFtUSp7SqPMx2jcRBF43NJW0eCjujFULNnJmTeDpwMUaf5fzUgbKgl
         uV1xj+2dhnsbtk2oUOjJEYjR21eOc6zuAxMlYwdeatLV7qlp8dqNpT7YY3tLUMknfxSB
         v891phYcEfIyK3YKVASe3b10YxS7N+fNQajo76H6noPw8h+JPHrJ0mNRl5nFMz+IfUhf
         SRFg==
X-Received: by 10.107.131.68 with SMTP id f65mr12343iod.70.1423079666294;
        Wed, 04 Feb 2015 11:54:26 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by mx.google.com with ESMTPSA id e70sm1348825ioe.6.2015.02.04.11.54.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Feb 2015 11:54:25 -0800 (PST)
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
        Upinder Malhi <umalhi@cisco.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v2 16/17] net: mlx4: identify predicate for debug messages
Date:   Wed,  4 Feb 2015 11:53:40 -0800
Message-Id: <1423079621-1374-17-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
References: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45714
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
index 944a112..96bf728 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -869,9 +869,11 @@ __printf(3, 4)
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
2.2.0.rc0.207.ga3a616c
