Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 00:27:11 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63729 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225230AbUJTX1F>; Thu, 21 Oct 2004 00:27:05 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id C1B13184A8; Wed, 20 Oct 2004 16:27:03 -0700 (PDT)
Message-ID: <4176F447.2090006@mvista.com>
Date: Wed, 20 Oct 2004 16:27:03 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Support for the third ethernet port on Titan 1.2 (2.4)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Ralf

Attached patch initializes port #2 of the titan 1.2 GE subsystem in 2.4

Thanks
Manish Lachwani

--- drivers/net/titan_ge.c.orig	2004-10-20 15:41:35.000000000 -0700
+++ drivers/net/titan_ge.c	2004-10-20 16:04:16.000000000 -0700
@@ -522,6 +522,8 @@
  				ack &= ~(0x3);
  			if (port_num == 1)
  				ack &= ~(0x300);
+			if (port_num == 2)
+				ack &= ~(0x30000);

  			/* Interrupts have been disabled */
  			TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, ack);
@@ -972,6 +974,53 @@
  		TITAN_GE_WRITE(0x494c, reg_data);
  	}

+	/*
+	 * Titan 1.2 does support port #2
+	 */
+	if (port_num == 2) {
+		/*
+		 * Descriptors in SRAM
+		 */
+		reg_data = TITAN_GE_READ(0x48a0);
+
+		reg_data |= 0x100000;
+		reg_data |= (0xff << 10) | (2*(0xff + 1));
+
+		TITAN_GE_WRITE(0x48a0, reg_data);
+		/*
+		 * BAV2,BAV and DAV settings for the Rx FIFO
+		 */
+		reg_data1 = TITAN_GE_READ(0x48a4);
+		reg_data1 |= ( (0x10 << 20) | (0x10 << 10) | 0x1);
+		TITAN_GE_WRITE(0x48a4, reg_data1);
+
+		reg_data &= ~(0x00100000);
+		reg_data |= 0x200000;
+
+		TITAN_GE_WRITE(0x48a0, reg_data);
+
+		reg_data = TITAN_GE_READ(0x4958);
+		reg_data |= 0x100000;
+
+		TITAN_GE_WRITE(0x4958, reg_data);
+		reg_data |= (0xff << 10) | (2*(0xff + 1));
+		TITAN_GE_WRITE(0x4958, reg_data);
+
+		/*
+		 * BAV2, BAV and DAV settings for the Tx FIFO
+		 */
+
+		reg_data1 = TITAN_GE_READ(0x495c);
+		reg_data1 = ( (0x1 << 20) | (0x1 << 10) | 0x10);
+
+		TITAN_GE_WRITE(0x495c, reg_data1);
+
+		reg_data &= ~(0x00100000);
+		reg_data |= 0x200000;
+
+		TITAN_GE_WRITE(0x4958, reg_data);
+	}
+
  	if (port_num == 2) {
  		reg_data = TITAN_GE_READ(0x48a0);

@@ -1094,6 +1143,9 @@
  		reg_data1 |= 0x300;
  	}

+	if (port_num == 2)
+		reg_data1 |= 0x30000;
+
  	TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, reg_data1);
  	TITAN_GE_WRITE(0x003c, 0x300);
  	
@@ -1974,6 +2026,13 @@
  		printk(KERN_ERR "Error registering the TITAN Ethernet"
  				"driver for port 1\n");

+	/*
+	 * Titan 1.2 does support port #2
+	 */
+	if (titan_ge_init(2))
+		printk(KERN_ERR "Error registering the TITAN Ethernet"
+				"driver for port 2\n");
+
  	return 0;
  }
