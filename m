Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jan 2005 20:04:04 +0000 (GMT)
Received: from mail.qarbon.com ([IPv6:::ffff:66.151.148.199]:48038 "EHLO
	eagle.qarbon.com") by linux-mips.org with ESMTP id <S8225411AbVALUD7>;
	Wed, 12 Jan 2005 20:03:59 +0000
Received: (qmail 12219 invoked by uid 210); 12 Jan 2005 20:03:50 +0000
Received: from 216.217.36.130 by mail (envelope-from <ilya@total-knowledge.com>, uid 201) with qmail-scanner-1.23st 
 (perlscan: 1.23st.  
 Clear:RC:0(216.217.36.130):. 
 Processed in 0.019409 secs); 12 Jan 2005 20:03:50 -0000
Received: from unknown (HELO ?10.0.15.99?) (ilya@216.217.36.130)
  by 192.168.2.15 with AES256-SHA encrypted SMTP; 12 Jan 2005 20:03:50 +0000
Message-ID: <41E582A0.1050407@total-knowledge.com>
Date: Wed, 12 Jan 2005 12:03:44 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: make meth eht0 on IP32
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

meth is built-in ethernet card on O2, and it would make sense for it to be
eth0, even if there is also another network card in PCI slot.

    Ilya.

Index: drivers/net/Makefile
===================================================================
RCS file: /home/cvs/linux/drivers/net/Makefile,v
retrieving revision 1.107
diff -u -r1.107 Makefile
--- drivers/net/Makefile        15 Nov 2004 11:49:28 -0000      1.107
+++ drivers/net/Makefile        12 Jan 2005 19:58:47 -0000
@@ -28,6 +28,8 @@
 obj-$(CONFIG_MYRI_SBUS) += myri_sbus.o
 obj-$(CONFIG_SUNGEM) += sungem.o sungem_phy.o

+obj-$(CONFIG_SGI_O2MACE_ETH) += meth.o
+
 obj-$(CONFIG_MACE) += mace.o
 obj-$(CONFIG_BMAC) += bmac.o

@@ -125,7 +127,6 @@
 obj-$(CONFIG_SUN3LANCE) += sun3lance.o
 obj-$(CONFIG_DEFXX) += defxx.o
 obj-$(CONFIG_SGISEEQ) += sgiseeq.o
-obj-$(CONFIG_SGI_O2MACE_ETH) += meth.o
 obj-$(CONFIG_AT1700) += at1700.o
 obj-$(CONFIG_FMV18X) += fmv18x.o
 obj-$(CONFIG_EL1) += 3c501.o
