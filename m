Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 18:49:57 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63726 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8224793AbUKRStw>; Thu, 18 Nov 2004 18:49:52 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAIInodh003490;
	Thu, 18 Nov 2004 10:49:50 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAIIno2K003488;
	Thu, 18 Nov 2004 10:49:50 -0800
Date: Thu, 18 Nov 2004 10:49:50 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Compile in the serial driver for TX4927
Message-ID: <20041118184950.GA3482@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf

Attached small patch compiles in the serial driver (serial_txx9.c) for Toshiba TX4927.
Thanks for Ralf Roesch for pointing this out

Thanks
Manish Lachwani

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-tx4927-serial

--- drivers/char/Makefile.orig	2004-11-18 10:44:22.000000000 -0800
+++ drivers/char/Makefile	2004-11-18 10:45:27.000000000 -0800
@@ -21,6 +21,7 @@
 obj-$(CONFIG_MVME162_SCC)	+= generic_serial.o vme_scc.o
 obj-$(CONFIG_BVME6000_SCC)	+= generic_serial.o vme_scc.o
 obj-$(CONFIG_SERIAL_TX3912)	+= generic_serial.o serial_tx3912.o
+obj-$(CONFIG_SERIAL_TXX9)	+= generic_serial.o serial_txx9.o
 obj-$(CONFIG_ROCKETPORT)	+= rocket.o
 obj-$(CONFIG_SERIAL167)		+= serial167.o
 obj-$(CONFIG_CYCLADES)		+= cyclades.o

--AqsLC8rIMeq19msA--
