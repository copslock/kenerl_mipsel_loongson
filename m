Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2004 18:04:17 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16891 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225250AbUKDSEM>; Thu, 4 Nov 2004 18:04:12 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iA4I49dh026096;
	Thu, 4 Nov 2004 10:04:09 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iA4I49dC026094;
	Thu, 4 Nov 2004 10:04:09 -0800
Date: Thu, 4 Nov 2004 10:04:09 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Rm7000/Rm9000 cache code change for 64-bit
Message-ID: <20041104180409.GA26087@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf

Attached small change fixes Rm7000/Rm9000 cache code to compile for 64-bit. This has
been verified on the 2.6.10 kernel and tested on the Momentum Ocelot-3 board.

Please review 

Thanks
Manish Lachwani


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-cache-ckseg

--- arch/mips/mm/sc-rm7k.c.orig	2004-11-04 09:27:09.000000000 -0800
+++ arch/mips/mm/sc-rm7k.c	2004-11-02 11:10:51.000000000 -0800
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

--wRRV7LY7NUeQGEoC--
