Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2016 01:57:23 +0100 (CET)
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35905 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013821AbcCOA5Tgg5nv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Mar 2016 01:57:19 +0100
Received: by mail-pf0-f179.google.com with SMTP id u190so3492190pfb.3
        for <linux-mips@linux-mips.org>; Mon, 14 Mar 2016 17:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IUxIZO1JS0JsAwvhhaNuf7Z6SMeX34oQLW6Rvj7qTqI=;
        b=Ta+TfHHTL+sNVc9Z0LRQSzg5Sd69p0L2ZFCJctac1BebJXrM540CaSyMSRy4lrbuNB
         MNdsUKva7bUdz8wQCOUTmIIG8AeaNyDG77ZCFR9zqT5SnuAy5uqnQ6/frobtfl1i+IiQ
         VeqXxQv3tW+5BccSv6nlgcZeW0xm/NsQZfRsklfKH10Ulzkhr2bzSEGDPvR3QpRitle5
         oCi1kIeKDWK0sW9jpduqTXxmQaOc9Z4R4uhxOM6xn/8IteuE+eqdcMA9qkb1IECtZGEK
         DUNNZqGd/ZWdyyGnOuwi8sPFAierhL6mVb/MpUtZdTZ3Uh+k73SsrO4AmP6kd9UjMnrx
         5p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IUxIZO1JS0JsAwvhhaNuf7Z6SMeX34oQLW6Rvj7qTqI=;
        b=Mp5n6gtdjgg4zS+LVsPbK+zgdYaQPB9DVzU3lxkP/J7cgNrHxOMe3mb/F4SVJs3F+N
         jNTm1avNFkCrI8bLaDkJRgHT0RxPf6b0dak/gQbB8eVHSOypIMA7baW+5of2vNOL3L4I
         YMsrEfgREjlO6IxoREXABubXQwzxL0MgzEognX12bdr+2C64wslRXZJqtDYVTLJG+Xvw
         GQRlJAZJ3KCe84T8f/fMZnV3tFdZi181W9YKSG3apF7Mxcrqgh49PrpCfoZ4IyiGqq9O
         V6QOKpgKFvNMByQ9MzNRLf6b0DlmmFrftjSD/bmf+zn5QaIYBN+NF6Kip8hgiI9aJS6L
         GHEA==
X-Gm-Message-State: AD7BkJKtcbmd2CM4kGxLJoYwSv9A7i+OQOQCroQg1OJ1XAK28cizyA7qfsoCTwbASrp9fw==
X-Received: by 10.66.190.168 with SMTP id gr8mr42342112pac.23.1458003433395;
        Mon, 14 Mar 2016 17:57:13 -0700 (PDT)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id ey7sm34844110pab.47.2016.03.14.17.57.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Mar 2016 17:57:11 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u2F0vAJ6027665;
        Mon, 14 Mar 2016 17:57:10 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u2F0v9aP027664;
        Mon, 14 Mar 2016 17:57:09 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] netdev: Move octeon/octeon_mgmt driver to cavium directory.
Date:   Mon, 14 Mar 2016 17:57:08 -0700
Message-Id: <1458003428-27632-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

No code changes.  Since OCTEON is a Cavium product, move the driver to
the vendor directory to unclutter things a bit.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/Kconfig                           |  1 -
 drivers/net/ethernet/Makefile                          |  1 -
 drivers/net/ethernet/cavium/Kconfig                    | 11 +++++++++++
 drivers/net/ethernet/cavium/Makefile                   |  1 +
 drivers/net/ethernet/{ => cavium}/octeon/Makefile      |  0
 drivers/net/ethernet/{ => cavium}/octeon/octeon_mgmt.c |  0
 drivers/net/ethernet/octeon/Kconfig                    | 14 --------------
 7 files changed, 12 insertions(+), 16 deletions(-)
 rename drivers/net/ethernet/{ => cavium}/octeon/Makefile (100%)
 rename drivers/net/ethernet/{ => cavium}/octeon/octeon_mgmt.c (100%)
 delete mode 100644 drivers/net/ethernet/octeon/Kconfig

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index be67a19..2ffd634 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -139,7 +139,6 @@ config NET_NETX
 source "drivers/net/ethernet/nuvoton/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
 source "drivers/net/ethernet/nxp/Kconfig"
-source "drivers/net/ethernet/octeon/Kconfig"
 source "drivers/net/ethernet/oki-semi/Kconfig"
 
 config ETHOC
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 6ffcc80..1d349e9 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -59,7 +59,6 @@ obj-$(CONFIG_NET_NETX) += netx-eth.o
 obj-$(CONFIG_NET_VENDOR_NUVOTON) += nuvoton/
 obj-$(CONFIG_NET_VENDOR_NVIDIA) += nvidia/
 obj-$(CONFIG_LPC_ENET) += nxp/
-obj-$(CONFIG_OCTEON_MGMT_ETHERNET) += octeon/
 obj-$(CONFIG_NET_VENDOR_OKI) += oki-semi/
 obj-$(CONFIG_ETHOC) += ethoc.o
 obj-$(CONFIG_NET_PACKET_ENGINE) += packetengines/
diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
index 953aa40..0ef232d 100644
--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -53,4 +53,15 @@ config LIQUIDIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called liquidio.  This is recommended.
 
+config OCTEON_MGMT_ETHERNET
+	tristate "Octeon Management port ethernet driver (CN5XXX, CN6XXX)"
+	depends on CAVIUM_OCTEON_SOC
+	select PHYLIB
+	select MDIO_OCTEON
+	default y
+	help
+	  Enable the ethernet driver for the management
+	  port on Cavium Networks' Octeon CN57XX, CN56XX, CN55XX,
+	  CN54XX, CN52XX, and CN6XXX chips.
+
 endif # NET_VENDOR_CAVIUM
diff --git a/drivers/net/ethernet/cavium/Makefile b/drivers/net/ethernet/cavium/Makefile
index d22f886a..872da9f 100644
--- a/drivers/net/ethernet/cavium/Makefile
+++ b/drivers/net/ethernet/cavium/Makefile
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_NET_VENDOR_CAVIUM) += thunder/
 obj-$(CONFIG_NET_VENDOR_CAVIUM) += liquidio/
+obj-$(CONFIG_NET_VENDOR_CAVIUM) += octeon/
diff --git a/drivers/net/ethernet/octeon/Makefile b/drivers/net/ethernet/cavium/octeon/Makefile
similarity index 100%
rename from drivers/net/ethernet/octeon/Makefile
rename to drivers/net/ethernet/cavium/octeon/Makefile
diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
similarity index 100%
rename from drivers/net/ethernet/octeon/octeon_mgmt.c
rename to drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
diff --git a/drivers/net/ethernet/octeon/Kconfig b/drivers/net/ethernet/octeon/Kconfig
deleted file mode 100644
index a7aa280..0000000
--- a/drivers/net/ethernet/octeon/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Cavium network device configuration
-#
-
-config OCTEON_MGMT_ETHERNET
-	tristate "Octeon Management port ethernet driver (CN5XXX, CN6XXX)"
-	depends on CAVIUM_OCTEON_SOC
-	select PHYLIB
-	select MDIO_OCTEON
-	default y
-	---help---
-	  This option enables the ethernet driver for the management
-	  port on Cavium Networks' Octeon CN57XX, CN56XX, CN55XX,
-	  CN54XX, CN52XX, and CN6XXX chips.
-- 
1.7.11.7
