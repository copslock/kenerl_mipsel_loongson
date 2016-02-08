Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:12:04 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33368 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011943AbcBHBJnGMkYT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:43 +0100
Received: by mail-pa0-f68.google.com with SMTP id y7so259880paa.0
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zMoutD4K4abopHMoPWMLnSXDq2EdilqE7/cUUP2P36A=;
        b=z8NVs9hrICj2G/koa0/ZE8B1WcswAmd321vAEnbaU5Kx1ObdUq3lkLTk1Q7ld+2tXv
         uQrrkoZ4RwNmz04wDcYB8XPpI+R1JvoMGae20K749/RkCtFsbg50mR+GvmQUknE3cI/H
         5nJObrlBWEn2GEktWAKs23XfDsjHnIAC8H+ebeBWuAXBL2DgL+43DvawFKEq3+zzNcGM
         bl6LXFq2hTmUSsrVIclQC4bEGqa9m0ZgLlKymQi+zJLOk1GW6RWMtc2qZ7Pxid4D/ZeU
         EdC6uz7/oGX5wJwM6hiA8+K/hkgDNWKJtTZN4yrQzU9CyUYgVHJSy8sHFgOGw/C5SKtb
         7fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zMoutD4K4abopHMoPWMLnSXDq2EdilqE7/cUUP2P36A=;
        b=A253WeG1os9C2KPyp2C9uuioOUBlJ8xnJD8885LaKIW1CM2m7e71m275Nmo1bmQyxO
         HHlSjHEiz34rgzeKkzyc/2HO5Vv1QgIxLNzD2OOpOc3j3IgNxZWOWzjvojdw3Vknpre8
         mA1PHqBETfhR39RuGpCtlJhl+X0N0bNOxppOZgEaEJC/3ZYWLM/HcXMGsDbrF+M4XdkX
         OFtjs++zg/sFhR741dOQxliqTqP86ftzgPGXEvFYLI9eD07NZjkNQPsfo9aHuRc069o9
         fFuRXR1xu7owOeDidtZjZ2ygevuuuE4kPjOlZLm+/rBn1S/sgHxiMQwMZ0wRnNS3aE6A
         DREw==
X-Gm-Message-State: AG10YOSOQ24n9UlOlqprcBTKhTdVlqZBikLyy8AWgVLYrd3vsENV3tMNs/P93xEm0c8atw==
X-Received: by 10.66.121.167 with SMTP id ll7mr1536739pab.6.1454893771202;
        Sun, 07 Feb 2016 17:09:31 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:30 -0800 (PST)
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
Subject: [PATCH net-next v7 06/19] tx4939: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:50 -0800
Message-Id: <1454893743-6285-7-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51829
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
index e3733cd..4a3ebf6 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -320,11 +320,12 @@ void __init tx4939_sio_init(unsigned int sclk, unsigned int cts_mask)
 #if IS_ENABLED(CONFIG_TC35815)
 static u32 tx4939_get_eth_speed(struct net_device *dev)
 {
-	struct ethtool_cmd cmd;
-	if (__ethtool_get_settings(dev, &cmd))
+	struct ethtool_ksettings cmd;
+
+	if (__ethtool_get_ksettings(dev, &cmd))
 		return 100;	/* default 100Mbps */
 
-	return ethtool_cmd_speed(&cmd);
+	return cmd.parent.speed;
 }
 
 static int tx4939_netdev_event(struct notifier_block *this,
-- 
2.7.0.rc3.207.g0ac5344
