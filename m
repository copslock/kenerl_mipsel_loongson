Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2005 19:23:27 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:37368 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8224920AbVAWTXV>; Sun, 23 Jan 2005 19:23:21 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id j0NJNJdh022697;
	Sun, 23 Jan 2005 11:23:19 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id j0NJNIsC022695;
	Sun, 23 Jan 2005 11:23:18 -0800
Date:	Sun, 23 Jan 2005 11:23:18 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TX4927 processor can support different speeds
Message-ID: <20050123192318.GA22681@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Based on the feedback from Toshiba, the TX4927 processor can support different 
speeds. Attached patch takes care of that. If you find this approach reasonable, 
can you please check it in

Thanks
Manish Lachwani


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_tx4927_cpuspeed.patch"

Source: MontaVista Software, Inc. | http://www.mvista.com | Manish Lachwani <mlachwani@mvista.com>
MR: 9936
Type: Enhancement
Disposition: Submitted to linux-mips.org
Keywords:
Signed-off-by: Manish Lachwani  <mlachwani@mvista.com>
Description:
	Based on suggestion from Toshiba, TX4927 can operate at different
	speeds

Index: linux-2.6.10/arch/mips/Kconfig
===================================================================
--- linux-2.6.10.orig/arch/mips/Kconfig
+++ linux-2.6.10/arch/mips/Kconfig
@@ -901,6 +901,14 @@
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
 	  support this machine type
 
+config TOSHIBA_TX4927_CPU_SPEED
+	int "CPU speed of the TX4927 processor (MHz)"
+	depends on TOSHIBA_RBTX4927
+	default 200
+	help
+	  This sets the speed for the TX4927 processor. The default speed
+	  is 200 MHz. 
+
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
 	depends on TOSHIBA_RBTX4927
Index: linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
--- linux-2.6.10.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -1008,7 +1008,11 @@
 				       mips_hpt_frequency,
 				       mips_hpt_frequency / 1000000);
 #else
-	mips_hpt_frequency = 100000000;
+	/*
+	 * Default TX4927 processor speed is 200 MHz. However, it 
+	 * can be configured by the user
+	 */
+	mips_hpt_frequency = (CONFIG_TOSHIBA_TX4927_CPU_SPEED * 1000000) / 2;
 #endif
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "+\n");

--azLHFNyN32YCQGCU--
