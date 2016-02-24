Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 19:59:34 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35665 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013928AbcBXS6hb0AxA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:37 +0100
Received: by mail-pf0-f195.google.com with SMTP id w128so1445215pfb.2
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49LufA/xP4TSljLr5x9lMGShUfkucjo04hTKQs7Me28=;
        b=zdxGeT4C+L9m92QEDzyhogRl0q+8f6jtHJMZF93PyCDx7x8c0Ok/EQhPkaO3+0ZP8t
         GLG+M6sSPde+uU4xELjGV5gEAsur4jDAAHC8jDNirVHtVedehabZDpWBdgXlyTKANgqZ
         U/JNAHmOJJUNWIXVx9s34edCG0g88yHnyZECKXzK1d6DyyK+vWAWu4SvmuL8EzHxE46M
         qwM+xB6IB1ufJfdhmx/Wh2TVJFe2FIhLKJo4KDSvQnAeRugnwn/JESWlnQlRVaStaG10
         JCKdtvvPgR+LyQx/7BXaTBTvFLBKzbrZjKpNaEiErFll6MZ7hgR2ukLHoi4A4FlEP+lh
         CCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=49LufA/xP4TSljLr5x9lMGShUfkucjo04hTKQs7Me28=;
        b=iWdVX0mfRoP8aJFe6sm69INDzXRpciMptEGTjHuJ9Ylk2Z42FMNUkfPN+AfBZWxbNy
         tW2Oz7qR+C0kFpNN7zfgljOzR4As7xs7xjqcZqWGfazLpgv5RAuaCWGJo8exiQH4ol6d
         lQArEcm5an8rXSeEDJKtYAlJdWOGe+MV6IH08Glz5xFrtD/yoH6Vh5zLFlLAwtKM5a4/
         9ErwksKMhz4LYEt9aTKLgrTz+BVbvNqtNe+f4W+8FS55AyA5H03y/ArSATKgJBvaPwwH
         2IsPnkIRjoCkHsyo2wJSfc8UJZN2Y45/7yHRSRM1B0UVykaYupfOvlV1EwOLONQcgi/D
         E4aQ==
X-Gm-Message-State: AG10YOR/96PMJNNp5OtNfLgjavh4CQVyVcGE3/nBgaHc4QnyY3MBI9yMLvtFRE8aqKAB+g==
X-Received: by 10.98.64.132 with SMTP id f4mr56423418pfd.159.1456340311877;
        Wed, 24 Feb 2016 10:58:31 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:31 -0800 (PST)
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
        kan.liang@intel.com, vidya@cumulusnetworks.com,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v9 04/16] tx4939: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:00 -0800
Message-Id: <1456340292-26003-5-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52209
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
 arch/mips/txx9/generic/setup_tx4939.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index e3733cd..402ac2e 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -320,11 +320,12 @@ void __init tx4939_sio_init(unsigned int sclk, unsigned int cts_mask)
 #if IS_ENABLED(CONFIG_TC35815)
 static u32 tx4939_get_eth_speed(struct net_device *dev)
 {
-	struct ethtool_cmd cmd;
-	if (__ethtool_get_settings(dev, &cmd))
+	struct ethtool_link_ksettings cmd;
+
+	if (__ethtool_get_link_ksettings(dev, &cmd))
 		return 100;	/* default 100Mbps */
 
-	return ethtool_cmd_speed(&cmd);
+	return cmd.base.speed;
 }
 
 static int tx4939_netdev_event(struct notifier_block *this,
-- 
2.7.0.rc3.207.g0ac5344
