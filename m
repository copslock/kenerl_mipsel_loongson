Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jan 2005 23:28:51 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:2814 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225426AbVALX2p>; Wed, 12 Jan 2005 23:28:45 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id j0CNShdh006160
	for <linux-mips@linux-mips.org>; Wed, 12 Jan 2005 15:28:43 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id j0CNSho0006158
	for linux-mips@linux-mips.org; Wed, 12 Jan 2005 15:28:43 -0800
Date: Wed, 12 Jan 2005 15:28:43 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Subject: [PATCH] Minor patch to build kernel for Ocelot-3
Message-ID: <20050112232843.GA6151@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello !

Attached patch is needed to build the kernel for Ocelot-3. Please apply

Thanks
Manish Lachwani


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-build-ocelot3

--- arch/mips/mm/sc-rm7k.c.orig	2005-01-12 15:25:06.000000000 -0800
+++ arch/mips/mm/sc-rm7k.c	2005-01-12 14:03:11.000000000 -0800
@@ -127,13 +127,13 @@
 		      ".set mips0\n\t"
 		      ".set reorder"
 		      :
-		      : "r" (KSEG0ADDR(i)), "i" (Index_Store_Tag_SD));
+		      : "r" (CKSEG0ADDR(i)), "i" (Index_Store_Tag_SD));
 	}
 }
 
 static __init void rm7k_sc_enable(void)
 {
-	void (*func)(void) = (void *) KSEG1ADDR(&__rm7k_sc_enable);
+	void (*func)(void) = (void *) CKSEG1ADDR(&__rm7k_sc_enable);
 
 	if (read_c0_config() & 0x08)			/* CONF_SE */
 		return;

--pWyiEgJYm5f9v55/--
