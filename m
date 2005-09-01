Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 18:16:51 +0100 (BST)
Received: from twilight.cs.hut.fi ([IPv6:::ffff:130.233.40.5]:15843 "EHLO
	twilight.cs.hut.fi") by linux-mips.org with ESMTP
	id <S8225550AbVIARQd>; Thu, 1 Sep 2005 18:16:33 +0100
Received: by twilight.cs.hut.fi (Postfix, from userid 60001)
	id 35AD22DB3; Thu,  1 Sep 2005 20:22:50 +0300 (EEST)
Received: from kekkonen.cs.hut.fi (kekkonen.cs.hut.fi [130.233.41.50])
	by twilight.cs.hut.fi (Postfix) with ESMTP id CD1D42DA1
	for <linux-mips@linux-mips.org>; Thu,  1 Sep 2005 20:22:49 +0300 (EEST)
Received: (from tmnousia@localhost)
	by kekkonen.cs.hut.fi (8.11.7p1+Sun/8.10.2) id j81HMn904232;
	Thu, 1 Sep 2005 20:22:49 +0300 (EEST)
Date:	Thu, 1 Sep 2005 20:22:49 +0300 (EEST)
From:	turja@mbnet.fi
X-X-Sender: tmnousia@kekkonen.cs.hut.fi
Reply-To: turja@mbnet.fi
To:	linux-mips@linux-mips.org
Subject: [PATCH] SGI VINO Kconfig patch
Message-ID: <Pine.GSO.4.58.0509012016560.3961@kekkonen.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <tmnousia@twilight.cs.hut.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: turja@mbnet.fi
Precedence: bulk
X-list: linux-mips

Please apply this patch to make the config for VINO a bit nicer :)

Mikael Nousiainen


diff -urN b/drivers/media/video/Kconfig c/drivers/media/video/Kconfig
--- b/drivers/media/video/Kconfig	2005-08-10 17:37:15.000000000 +0300
+++ c/drivers/media/video/Kconfig	2005-09-01 20:07:35.000000000 +0300
@@ -153,12 +153,38 @@
 	  If in doubt, say N.

 config VIDEO_VINO
-	tristate "SGI Vino Video For Linux (EXPERIMENTAL)"
-	depends on VIDEO_DEV && I2C && SGI_IP22 && EXPERIMENTAL
+	tristate "SGI VINO Video For Linux"
+	depends on VIDEO_DEV && I2C && SGI_IP22
 	select I2C_ALGO_SGI
 	help
-	  Say Y here to build in support for the Vino video input system found
-	  on SGI Indy machines.
+	  Say Y here to enable support for the VINO video input system found
+	  on SGI Indy machines. To use the driver you also need to select
+	  at least one of the video input modules: SAA7191 and IndyCam.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vino.
+
+config VIDEO_SAA7191
+	tristate "Philips SAA7191 video decoder support"
+	depends on VIDEO_VINO
+	default y
+	help
+	  Say Y here to enable support for the Philips SAA7191 digital
+	  multi-standard video decoder. This driver provides access
+	  to the Composite and S-Video inputs of SGI Indy.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called saa7191.
+
+config VIDEO_INDYCAM
+	tristate "SGI IndyCam support"
+	depends on VIDEO_VINO
+	default y
+	help
+	  Say Y here to enable support for the SGI IndyCam digital camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called indycam.

 config VIDEO_STRADIS
 	tristate "Stradis 4:2:2 MPEG-2 video driver  (EXPERIMENTAL)"
diff -urN b/drivers/media/video/Makefile c/drivers/media/video/Makefile
--- b/drivers/media/video/Makefile	2005-08-16 16:32:52.000000000 +0300
+++ c/drivers/media/video/Makefile	2005-09-01 19:58:00.000000000 +0300
@@ -29,7 +29,9 @@
 obj-$(CONFIG_VIDEO_ZORAN) += zr36067.o videocodec.o
 obj-$(CONFIG_VIDEO_PMS) += pms.o
 obj-$(CONFIG_VIDEO_PLANB) += planb.o
-obj-$(CONFIG_VIDEO_VINO) += vino.o saa7191.o indycam.o
+obj-$(CONFIG_VIDEO_VINO) += vino.o
+obj-$(CONFIG_VIDEO_SAA7191) += saa7191.o
+obj-$(CONFIG_VIDEO_INDYCAM) += indycam.o
 obj-$(CONFIG_VIDEO_STRADIS) += stradis.o
 obj-$(CONFIG_VIDEO_CPIA) += cpia.o
 obj-$(CONFIG_VIDEO_CPIA_PP) += cpia_pp.o
