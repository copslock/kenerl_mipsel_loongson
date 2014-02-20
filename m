Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 15:02:45 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:47672 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6871416AbaBTOA1hpFZm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Feb 2014 15:00:27 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/5] MIPS: Malta: Enable DEVTMPFS
Date:   Thu, 20 Feb 2014 14:00:25 +0000
Message-ID: <1392904828-12969-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_20_14_00_22
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Recent versions of udev and systemd require the kernel
to be compiled with CONFIG_DEVTMPFS in order to populate
the /dev directory. Most MIPS platforms have it enabled by
default, so enable it for Malta configs as well.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/configs/malta_defconfig           | 1 +
 arch/mips/configs/malta_kvm_defconfig       | 1 +
 arch/mips/configs/malta_kvm_guest_defconfig | 1 +
 arch/mips/configs/maltaaprp_defconfig       | 1 +
 arch/mips/configs/maltasmtc_defconfig       | 1 +
 arch/mips/configs/maltasmvp_defconfig       | 1 +
 arch/mips/configs/maltaup_defconfig         | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index bc494b2..6bb89a3 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -223,6 +223,7 @@ CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 041e41b..bc19ebb 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -225,6 +225,7 @@ CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index bf186df..e36681c 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -224,6 +224,7 @@ CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 90b1725..fb042ce 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -78,6 +78,7 @@ CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_CLS_IND=y
 # CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_IDE=y
diff --git a/arch/mips/configs/maltasmtc_defconfig b/arch/mips/configs/maltasmtc_defconfig
index 991da9f..4e59730 100644
--- a/arch/mips/configs/maltasmtc_defconfig
+++ b/arch/mips/configs/maltasmtc_defconfig
@@ -79,6 +79,7 @@ CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_CLS_IND=y
 # CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_IDE=y
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 1dafe79..e867c9a 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -81,6 +81,7 @@ CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_CLS_IND=y
 # CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_IDE=y
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index b8a97a2..6234464 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -77,6 +77,7 @@ CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_CLS_IND=y
 # CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_IDE=y
-- 
1.8.5.5
