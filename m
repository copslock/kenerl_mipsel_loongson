Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:48:23 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40790 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009385AbaIUArC6n2V5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:47:02 +0200
Received: by mail-pd0-f169.google.com with SMTP id w10so2173910pde.14
        for <multiple recipients>; Sat, 20 Sep 2014 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtbdYCMkzuh+aK/+2EKyJVWCv3S7rJMCnA1SyXC6li8=;
        b=bZsWy/IPba7+wR6pDIL8HMAQgoBEP51Lh3sMlsBT8a6GgYtLDxmntpbOJjSdOAX/OJ
         ZvnifFViwO1ihJkKPeVzHeeHJQpVand+TQE0tSsSG6NEPKFqs2UDiNJmuWvQMz5y109M
         lfbyiotAhbdpbnXwVn4Cn5YvPHM2TTQwAvlaCpvrSROmrwqEA392cbhFu3F4Yj/UtKpm
         VnH/f/esGTtqINe6citfJBMi8OEnaFfS7x1RAquiC5907+r6nwGTWVX8dKBuNLqtIveL
         qjgh1ps5/vF6UeKQRH6f1RiKEPsj6azrORRkJL1xhwUcfYNeF1N5vci9uuZ8gFkmg7KT
         Q72A==
X-Received: by 10.70.59.35 with SMTP id w3mr14578855pdq.51.1411260416396;
        Sat, 20 Sep 2014 17:46:56 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id nx15sm5500796pdb.88.2014.09.20.17.46.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:46:55 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 05/11] next: mips: Fix malta_defconfig
Date:   Sat, 20 Sep 2014 17:46:20 -0700
Message-Id: <1411260386-6800-6-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Commit 5d6be6a5d486 ('scsi_netlink : Make SCSI_NETLINK dependent on NET instead
of selecting NET') changes 'select NET' to 'depends NET'. As a result, many
configurations which do not explicitly select CONFIG_NET are no longer valid
and need to be updated.

The command sequence to create the new configuration is as follows.

- Run "make ARCH=mips <configuration>" on upstream kernel
- Copy resulting .config to next-20140919
- Run "make ARCH=mips olddefconfig" in next-20140919
- Run "make ARCH=mips savedefconfig"
- Copy resulting defconfig file to arch/mips/configs/<configuration>
- Build the image with the resulting configuration

Fixes: 5d6be6a5d486 ('scsi_netlink : Make SCSI_NETLINK dependent on NET instead of selecting NET')
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/configs/malta_defconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index e18741e..7c3973f 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -19,6 +19,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PCI=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
@@ -131,7 +132,6 @@ CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -174,7 +174,6 @@ CONFIG_BRIDGE_EBT_MARK_T=m
 CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
-CONFIG_BRIDGE_EBT_ULOG=m
 CONFIG_BRIDGE_EBT_NFLOG=m
 CONFIG_IP_SCTP=m
 CONFIG_BRIDGE=m
@@ -219,8 +218,6 @@ CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_CLS_IND=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
-CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -259,7 +256,6 @@ CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
-- 
1.9.1
