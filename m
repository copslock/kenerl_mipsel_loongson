Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 15:16:37 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:57992 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021665AbZFDOQa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 15:16:30 +0100
Received: by fxm23 with SMTP id 23so816104fxm.0
        for <multiple recipients>; Thu, 04 Jun 2009 07:16:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jtUiUlE8ZU+vjaOtSZWz8uZ0ZbZrZ6KemPqnZuLtCqU=;
        b=ICB5pWEEdlMU6JO/7RuMCX9Y4TfEocUC9EAyUlVRKthjuGrUV8RQ6fynxqS9d/Iy0X
         eMa81AYuuY2GSxGsPzjE7BkhgYFdJ9qMThoDFkEfYH/1phaeECvxHdljXhyzghWdps8x
         PzTu6xZJVp2FFCGLq2715rGgwuF/U6ZTaxozU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Fy+H5dWVI/vsMLg4W1bvwXu2UibIsd+WuKxBEFascLy1brAXQbmqStiZMGyXkKnZWK
         xZ63zB+BmTTx6zizX64Fxmf3oCp7xqZEo8FnTHC1I64K9E4ArrHSu8giLGPsAba4mrjB
         dhm3D4yDMxPtIzQVZlMlxEGBsgA4V/9j41B7g=
Received: by 10.204.54.65 with SMTP id p1mr2044141bkg.195.1244124985038;
        Thu, 04 Jun 2009 07:16:25 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 2sm3924788fks.33.2009.06.04.07.16.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 07:16:24 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 4 Jun 2009 16:16:21 +0200
Subject: [PATCH 3/8] net/netfilter/ipvs/ip_vs_wrr.c: use lib/gcd.c
MIME-Version: 1.0
X-UID:	234
X-Length: 2143
To:	"Linux-MIPS" <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906041616.22786.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch removes the open-coded version of the
greatest common divider to use lib/gcd.c, the latter
also implementing the a < b case.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 79a6980..5b37675 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -113,6 +113,7 @@ config	IP_VS_RR
  
 config	IP_VS_WRR
         tristate "weighted round-robin scheduling" 
+	select GCD
 	---help---
 	  The weighted robin-robin scheduling algorithm directs network
 	  connections to different real servers based on server weights
diff --git a/net/netfilter/ipvs/ip_vs_wrr.c b/net/netfilter/ipvs/ip_vs_wrr.c
index f7d74ef..8701212 100644
--- a/net/netfilter/ipvs/ip_vs_wrr.c
+++ b/net/netfilter/ipvs/ip_vs_wrr.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/net.h>
+#include <linux/gcd.h>
 
 #include <net/ip_vs.h>
 
@@ -35,20 +36,6 @@ struct ip_vs_wrr_mark {
 };
 
 
-/*
- *    Get the gcd of server weights
- */
-static int gcd(int a, int b)
-{
-	int c;
-
-	while ((c = a % b)) {
-		a = b;
-		b = c;
-	}
-	return b;
-}
-
 static int ip_vs_wrr_gcd_weight(struct ip_vs_service *svc)
 {
 	struct ip_vs_dest *dest;
