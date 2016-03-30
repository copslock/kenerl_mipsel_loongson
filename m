Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 13:42:55 +0200 (CEST)
Received: from mail.skyhub.de ([78.46.96.112]:49181 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025852AbcC3LmxhwIP1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2016 13:42:53 +0200
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KY-2SkBqebPz; Wed, 30 Mar 2016 13:42:52 +0200 (CEST)
Received: from pd.tnic (p200300454B3D010025E5E0C016AF59EE.dip0.t-ipconnect.de [IPv6:2003:45:4b3d:100:25e5:e0c0:16af:59ee])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E775A1DA24F;
        Wed, 30 Mar 2016 13:42:51 +0200 (CEST)
Received: by pd.tnic (Postfix, from userid 1000)
        id 7C0321617BB; Wed, 30 Mar 2016 13:42:48 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/5] mips/defconfigs: Remove CONFIG_IPV6_PRIVACY
Date:   Wed, 30 Mar 2016 13:42:45 +0200
Message-Id: <1459338168-29334-3-git-send-email-bp@alien8.de>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1459338168-29334-1-git-send-email-bp@alien8.de>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
Return-Path: <bp@alien8.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
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

From: Borislav Petkov <bp@suse.de>

Option is long gone, see

  5d9efa7ee99e ("ipv6: Remove privacy config option.")

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-mips@linux-mips.org
---
 arch/mips/configs/bcm47xx_defconfig    | 1 -
 arch/mips/configs/bigsur_defconfig     | 1 -
 arch/mips/configs/decstation_defconfig | 1 -
 arch/mips/configs/ip22_defconfig       | 1 -
 arch/mips/configs/ip27_defconfig       | 1 -
 arch/mips/configs/jazz_defconfig       | 1 -
 arch/mips/configs/lemote2f_defconfig   | 1 -
 arch/mips/configs/mtx1_defconfig       | 1 -
 arch/mips/configs/nlm_xlp_defconfig    | 1 -
 arch/mips/configs/nlm_xlr_defconfig    | 1 -
 arch/mips/configs/rm200_defconfig      | 1 -
 11 files changed, 11 deletions(-)

diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index 0db4eb319e0a..fad8e964f14c 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -23,7 +23,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TCP_CONG_ADVANCED=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
 CONFIG_IPV6_MROUTE=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index e070dac071c8..d20b09d77b53 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -62,7 +62,6 @@ CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 # CONFIG_INET_LRO is not set
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index ebc011c51e5a..2b6cb41d5715 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -30,7 +30,6 @@ CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_INET6_AH=m
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 6ba9ce9fcdd5..5d83ff755547 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -48,7 +48,6 @@ CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
 # CONFIG_INET_LRO is not set
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 77e9f505f5e4..2b74aee320a1 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -43,7 +43,6 @@ CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index a5e85e1ee5de..3019fce63cd3 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -34,7 +34,6 @@ CONFIG_IP_PIMSM_V2=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_INET6_AH=m
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index d1f198b072a0..5da76e0e120f 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -71,7 +71,6 @@ CONFIG_TCP_CONG_ADVANCED=y
 CONFIG_TCP_CONG_BIC=y
 CONFIG_DEFAULT_BIC=y
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 9b6926d6bb32..f3f60056bc27 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -51,7 +51,6 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index b3d1d37f85ea..b496c25fced6 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -95,7 +95,6 @@ CONFIG_TCP_CONG_YEAH=m
 CONFIG_TCP_CONG_ILLINOIS=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index 3d8016d6cf3e..8e99ad807a57 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -75,7 +75,6 @@ CONFIG_TCP_CONG_YEAH=m
 CONFIG_TCP_CONG_ILLINOIS=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 82db4e3e4cf1..c2b4e3f33a73 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -37,7 +37,6 @@ CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_INET6_AH=m
-- 
2.7.3
