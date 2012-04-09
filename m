Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 20:29:30 +0200 (CEST)
Received: from fep13.mx.upcmail.net ([62.179.121.33]:36743 "EHLO
        fep13.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903631Ab2DIS3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 20:29:24 +0200
Received: from edge01.upcmail.net ([192.168.13.236])
          by viefep13-int.chello.at
          (InterMail vM.8.01.05.04 201-2260-151-105-20111014) with ESMTP
          id <20120409182919.OWXQ3333.viefep13-int.chello.at@edge01.upcmail.net>;
          Mon, 9 Apr 2012 20:29:19 +0200
Received: from ecaz.lan ([80.98.112.136])
        by edge01.upcmail.net with edge
        id vuVE1i00x2wdXpc01uVE5E; Mon, 09 Apr 2012 20:29:19 +0200
X-SourceIP: 80.98.112.136
From:   Imre Kaloz <kaloz@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH] STAGING: octeon-ethernet: fix build errors by including interrupt.h
Date:   Mon,  9 Apr 2012 20:29:15 +0200
Message-Id: <1333996155-30523-1-git-send-email-kaloz@openwrt.org>
X-Mailer: git-send-email 1.7.1
X-archive-position: 32912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch fixes the following build failures:

drivers/staging/octeon/ethernet.c: In function 'cvm_oct_cleanup_module':
drivers/staging/octeon/ethernet.c:799:2: error: implicit declaration of function 'free_irq'
drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_no_more_work':
drivers/staging/octeon/ethernet-rx.c:119:3: error: implicit declaration of function 'enable_irq'
drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_do_interrupt':
drivers/staging/octeon/ethernet-rx.c:136:2: error: implicit declaration of function 'disable_irq_nosync'
drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_rx_initialize':
drivers/staging/octeon/ethernet-rx.c:532:2: error: implicit declaration of function 'request_irq'
drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_tx_initialize':
drivers/staging/octeon/ethernet-tx.c:712:2: error: implicit declaration of function 'request_irq'
drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_tx_shutdown':
drivers/staging/octeon/ethernet-tx.c:723:2: error: implicit declaration of function 'free_irq'

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 drivers/staging/octeon/ethernet-rx.c |    1 +
 drivers/staging/octeon/ethernet-tx.c |    1 +
 drivers/staging/octeon/ethernet.c    |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 400df8c..d91751f 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -36,6 +36,7 @@
 #include <linux/prefetch.h>
 #include <linux/ratelimit.h>
 #include <linux/smp.h>
+#include <linux/interrupt.h>
 #include <net/dst.h>
 #ifdef CONFIG_XFRM
 #include <linux/xfrm.h>
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 56d74dc..91a97b3 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -32,6 +32,7 @@
 #include <linux/ip.h>
 #include <linux/ratelimit.h>
 #include <linux/string.h>
+#include <linux/interrupt.h>
 #include <net/dst.h>
 #ifdef CONFIG_XFRM
 #include <linux/xfrm.h>
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9112cd8..60cba81 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -31,6 +31,7 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include <net/dst.h>
 
-- 
1.7.1
