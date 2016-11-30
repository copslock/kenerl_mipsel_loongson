Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2016 23:58:56 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:42054 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992519AbcK3W60GiNRL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Nov 2016 23:58:26 +0100
Received: from hauke-desktop.lan (p20030086280C75006955C9BE4344F859.dip0.t-ipconnect.de [IPv6:2003:86:280c:7500:6955:c9be:4344:f859])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 250381001CD;
        Wed, 30 Nov 2016 23:58:23 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] lantiq: refresh default configuration
Date:   Wed, 30 Nov 2016 23:58:07 +0100
Message-Id: <20161130225808.11620-1-hauke@hauke-m.de>
X-Mailer: git-send-email 2.10.2
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Just generate a configuration based on this default configuration and
store it again. This removed some old configuration options.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/configs/xway_defconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index 8987846..0ccb642 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -2,11 +2,11 @@ CONFIG_LANTIQ=y
 CONFIG_XRX200_PHY_FW=y
 CONFIG_CPU_MIPS32_R2=y
 # CONFIG_COMPACTION is not set
-# CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+# CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
@@ -35,12 +35,10 @@ CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
-CONFIG_ARPD=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -62,7 +60,6 @@ CONFIG_NETFILTER_XT_MATCH_MAC=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
 CONFIG_NF_CONNTRACK_IPV4=m
-# CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
@@ -151,9 +148,6 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CRYPTO_MANAGER=m
 CONFIG_CRYPTO_ARC4=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_ITU_T=m
 CONFIG_CRC32_SARWATE=y
-CONFIG_AVERAGE=y
-- 
2.10.2
