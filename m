Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 23:26:18 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:7928 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225228AbUJTW0N>; Wed, 20 Oct 2004 23:26:13 +0100
Received: from prometheus.mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 3239C184F7; Wed, 20 Oct 2004 15:26:11 -0700 (PDT)
Subject: Support for the third ethernet port on Titan 1.2
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Content-Type: text/plain
Organization: 
Message-Id: <1098311170.4266.13.camel@prometheus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Oct 2004 15:26:11 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Ralf

Attached patch initializes port #2 of the titan 1.2 GE subsystem in 2.6.
Note that this patch does not allocate irq for the port yet since the
plan is to implement allocate_irqno() as discussed earlier.

Thanks
Manish Lachwani

--- drivers/net/titan_ge.c.orig	2004-10-20 13:46:58.000000000 -0700
+++ drivers/net/titan_ge.c	2004-10-20 14:59:43.000000000 -0700
@@ -470,6 +470,9 @@
 			if (port_num == 1)
 				ack &= ~(0x300);
 
+			if (port_num == 2)
+				ack &= ~(0x30000);
+
 			/* Interrupts have been disabled */
 			TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, ack);
 
@@ -911,6 +914,52 @@
 		TITAN_GE_WRITE(0x494c, reg_data);
 	}
 
+	/*
+	 * Titan 1.2 revision does support port #2
+	 */
+	if (port_num == 2) {
+		/*
+		 * Put the descriptors in the SRAM
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
 
@@ -1034,6 +1083,9 @@
 		reg_data1 |= 0x300;
 	}
 
+	if (port_num == 2)
+		reg_data1 |= 0x30000;
+
 	TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, reg_data1);
 	TITAN_GE_WRITE(0x003c, 0x300);
 
@@ -2038,6 +2090,13 @@
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
 
 out_unmap_ge:
