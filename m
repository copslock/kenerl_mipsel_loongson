Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:48:57 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:51645 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009386AbaIUArIcU7iK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:47:08 +0200
Received: by mail-pd0-f178.google.com with SMTP id ft15so2152221pdb.23
        for <multiple recipients>; Sat, 20 Sep 2014 17:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wh9CTfFvJ7Dy3hh/AEXv3MxX1ZwJDawgyE+9Yb+SbFc=;
        b=vXqYpZDP4wded1xJpQePK7GvgI+On4u0zeaNItUSR9xiRrBZneKQPNuPvOaaae9kXw
         UQspiRXspL+cTDhmADgUA8ejfOwDOt50C/SBe69JTfW4sV99BRDfNNx9vzxaezCYe2PI
         lMMOsaXkgJ8Nl3eiy5ocbv3pU/TBnSx33pd+HOgBMJwrFR6V7GIxAMyxwAmGYV7ScW7a
         CX9um13Y+fxzxtsCDnRU7nYUFiB9HArmmre41zdmS9Ea+pYzEyr6y1cRYMKuFz5GaDUr
         XbJoGapB51tKeHch4QSXZjOXmDOyi4saIdoOXpr8PWA/vu3Na9WGg+5YLYxY+XwjDjoW
         9LJQ==
X-Received: by 10.66.161.41 with SMTP id xp9mr14284784pab.120.1411260422488;
        Sat, 20 Sep 2014 17:47:02 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id ou6sm5482498pbb.88.2014.09.20.17.47.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:47:02 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 07/11] next: mips: Fix malta_kvm_guest_defconfig
Date:   Sat, 20 Sep 2014 17:46:22 -0700
Message-Id: <1411260386-6800-8-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
References: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42716
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
 arch/mips/configs/malta_kvm_guest_defconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index edd9ec9..2decf36 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
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
@@ -260,7 +257,6 @@ CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
-- 
1.9.1
