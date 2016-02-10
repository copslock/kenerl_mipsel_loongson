Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:34:32 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35290 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009890AbcBJAaU0iRpx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:20 +0100
Received: by mail-pa0-f65.google.com with SMTP id fl4so158971pad.2
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IpA9nl8IZlK/ByCx1cK2rQrWfMOQ/Wm2UEg6gnOMKA=;
        b=O+mWeNXnSK0UgwKRf+1A7w+1THJHSCNodxIB55mMRENA/y7OlUxWV+j4mIx8t+Pk1e
         O6yUvpZ+MqpcsVN1KoEZcAugzHYsNv/8oBCwUgOv5P4tqiX3I+Ob4OjkEkPKuAr1N79l
         nDLdOXRv+rsezWDN6IxAkHA2lP11tToti7Eq44m6dinV/oMV1Hap6BBrg9lotqPCVhov
         ivp9V/EKi9CuQagJIZ65FFNglAD3c22k3RQInMBB4/RG2y5iXSSIEHMyQB8MgrcvJduL
         ZLPAwxqeqLlgcPqGVnKdJ5dFFbXZeGp28dUtmrqSa6sUloYl9UTAmQA7FKW9ki6hA9My
         WrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IpA9nl8IZlK/ByCx1cK2rQrWfMOQ/Wm2UEg6gnOMKA=;
        b=DEkOddmus6ep+elbpN0R5S2enpKiJoeL5HbSOZM4NbEIugOlw7cgVzPedDMev1qHV8
         88hFxeWNVnl51+bcCEmWfpZ9mEj9tHvOIE90rGSNha9aV0wSC956aIU37ACkdNNcnKJ3
         yZMFvnuGZrT41hhZOh1SXS5LIKcxuEypXQqxFixs+r7U6v9VTnt2R3u3akhspflcOtPu
         p7cZ1EZaL+olAf3w9V/KtCSqbbTEgRudUFGDB7GzG3eCrzLqBS/iXTQJ/5kZNvSO9yNW
         aPD3gF0h5wPBCojraQvdU23Dvu9L8cYTrSMM3vwdc/OwKux7QqYpvju97uxHtHfkS1nw
         0pvw==
X-Gm-Message-State: AG10YOSRwGZ64TJyN8K1No/u8EhScTjKktiMe5+P5W6N4XpJ0DkrU0dWic3Ru8EppRHSQA==
X-Received: by 10.66.119.71 with SMTP id ks7mr55067456pab.151.1455064214861;
        Tue, 09 Feb 2016 16:30:14 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:14 -0800 (PST)
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
Subject: [PATCH net-next v8 15/19] net: bridge: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:24 -0800
Message-Id: <1455064168-5102-16-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51953
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
 net/bridge/br_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c367b3e..cafe4e6 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -36,10 +36,10 @@
  */
 static int port_cost(struct net_device *dev)
 {
-	struct ethtool_cmd ecmd;
+	struct ethtool_ksettings ecmd;
 
-	if (!__ethtool_get_settings(dev, &ecmd)) {
-		switch (ethtool_cmd_speed(&ecmd)) {
+	if (!__ethtool_get_ksettings(dev, &ecmd)) {
+		switch (ecmd.parent.speed) {
 		case SPEED_10000:
 			return 2;
 		case SPEED_1000:
-- 
2.7.0.rc3.207.g0ac5344
