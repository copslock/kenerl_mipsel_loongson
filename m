Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2009 18:25:27 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:51561 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493222AbZHXQZU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2009 18:25:20 +0200
Received: by ewy25 with SMTP id 25so662574ewy.33
        for <linux-mips@linux-mips.org>; Mon, 24 Aug 2009 09:25:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0FAt29Lw5oen9vZHjGWdbpbuWY43AxC9kCzRs43ORRA=;
        b=n+neJoWAeHwaw/E8ojmD6mka+m/X/F33Q8matJdXDXoDD3ABsmj3pQBtmp0OGQYnyt
         zOCkzpHD6KGuDfFRpoxATBM9kmdFAQa19frD6V82e09v9q0kCyLMffXcpynan0+O+3eE
         HiuqGPU3rWepNnEvGs47RiEgu55HK5+gVvSVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mZIIT2nkznP+hKSUSzYxr5bPeXVmsdpMxCuhHCWnFo8RT23bg6+ANfUkTWQ+93hfSJ
         MtQJvWQAGSN1suLubCXXQSFlNx4YuQWQtSHGz3q7AQ+oZ2gU26n5kWxd4UtEGwWwdQV2
         DMck/rOFoxRBir8ZRbXo6IhXUohX+AZd9PQUA=
Received: by 10.210.37.4 with SMTP id k4mr5429466ebk.4.1251131112954;
        Mon, 24 Aug 2009 09:25:12 -0700 (PDT)
Received: from localhost.localdomain (bohr2.srcc.msu.ru [212.192.244.122])
        by mx.google.com with ESMTPS id 7sm5580536eyg.20.2009.08.24.09.25.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 09:25:12 -0700 (PDT)
From:	Alexander Beregalov <a.beregalov@gmail.com>
To:	davem@davemloft.net, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Cc:	Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 1/2] irda/au1k_ir: fix broken netdev_ops conversion
Date:	Mon, 24 Aug 2009 18:54:27 +0400
Message-Id: <1251125667-6509-1-git-send-email-a.beregalov@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <a.beregalov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.beregalov@gmail.com
Precedence: bulk
X-list: linux-mips

This patch is based on commit d2f3ad4 (pxaficp-ir: remove incorrect
net_device_ops). Do the same for au1k_ir.
Untested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 drivers/net/irda/au1k_ir.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/net/irda/au1k_ir.c b/drivers/net/irda/au1k_ir.c
index c4361d4..ee1cff5 100644
--- a/drivers/net/irda/au1k_ir.c
+++ b/drivers/net/irda/au1k_ir.c
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
-#include <linux/etherdevice.h>
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/interrupt.h>
@@ -205,9 +204,6 @@ static const struct net_device_ops au1k_irda_netdev_ops = {
 	.ndo_start_xmit		= au1k_irda_hard_xmit,
 	.ndo_tx_timeout		= au1k_tx_timeout,
 	.ndo_do_ioctl		= au1k_irda_ioctl,
-	.ndo_change_mtu		= eth_change_mtu,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= eth_mac_addr,
 };
 
 static int au1k_irda_net_init(struct net_device *dev)
-- 
1.6.4
