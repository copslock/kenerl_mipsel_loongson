Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 17:44:29 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:34979 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009523AbaIWPo1iBSp5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Sep 2014 17:44:27 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5AF1CAB1E;
        Tue, 23 Sep 2014 15:44:27 +0000 (UTC)
Received: by sepie.suse.cz (Postfix, from userid 10020)
        id B40C14085B; Tue, 23 Sep 2014 17:44:26 +0200 (CEST)
From:   Michal Marek <mmarek@suse.cz>
To:     sfr@canb.auug.org.au, rdunlap@infradead.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 1/5] mips: Set CONFIG_NET=y in defconfigs
Date:   Tue, 23 Sep 2014 17:44:00 +0200
Message-Id: <1411487044-14071-1-git-send-email-mmarek@suse.cz>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <54218AEF.5090200@suse.cz>
References: <54218AEF.5090200@suse.cz>
Return-Path: <mmarek@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
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

Commit 5d6be6a5 ("scsi_netlink : Make SCSI_NETLINK dependent on NET
instead of selecting NET") removed what happened to be the only instance
of 'select NET'. Defconfigs that were relying on the select now lack
networking support.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-mips@linux-mips.org
Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 arch/mips/configs/gpr_defconfig             | 1 +
 arch/mips/configs/ip27_defconfig            | 1 +
 arch/mips/configs/jazz_defconfig            | 1 +
 arch/mips/configs/loongson3_defconfig       | 1 +
 arch/mips/configs/malta_defconfig           | 1 +
 arch/mips/configs/malta_kvm_defconfig       | 1 +
 arch/mips/configs/malta_kvm_guest_defconfig | 1 +
 arch/mips/configs/mtx1_defconfig            | 1 +
 arch/mips/configs/rm200_defconfig           | 1 +
 9 files changed, 9 insertions(+)

diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 8f219da..e24feb06 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -19,6 +19,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PCI=y
 CONFIG_BINFMT_MISC=m
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index cc07560..48e16d9 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -28,6 +28,7 @@ CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 CONFIG_PM=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index 2575302..4f37a59 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -18,6 +18,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
+CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
 CONFIG_NET_KEY=m
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 4cb787f..1c6191e 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -59,6 +59,7 @@ CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 CONFIG_PM_RUNTIME=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index e18741e..f57b96d 100644
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
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index cf0e01f..d41742d 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -20,6 +20,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PCI=y
+CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index edd9ec9..a7806e8 100644
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
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index d269a53..9b6926d 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -27,6 +27,7 @@ CONFIG_PD6729=m
 CONFIG_I82092=m
 CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
+CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
 CONFIG_XFRM_USER=m
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 29d79ae..db029f4 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -20,6 +20,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_PCI=y
 CONFIG_BINFMT_MISC=m
 CONFIG_PM=y
+CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
 CONFIG_NET_KEY=m
-- 
1.8.4.5
