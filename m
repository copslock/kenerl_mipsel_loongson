Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 17:14:29 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:39157 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225074AbUKWROY>; Tue, 23 Nov 2004 17:14:24 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iANHEMdh030459;
	Tue, 23 Nov 2004 09:14:22 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iANHELBK030457;
	Tue, 23 Nov 2004 09:14:21 -0800
Date: Tue, 23 Nov 2004 09:14:21 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Comments in the titan ethernet driver for IP header alignment
Message-ID: <20041123171421.GA30451@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Attached patch puts comments around the section that programs register 0x103C
for IP header alignment. Please review ...

Thanks
Manish Lachwani


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-titan-comments

--- drivers/net/titan_ge.c.orig	2004-11-23 09:00:29.000000000 -0800
+++ drivers/net/titan_ge.c	2004-11-23 09:12:07.000000000 -0800
@@ -1000,6 +1000,17 @@
 	 * driver. This performance drawback existed in the previous
 	 * versions of the silicon
 	 */
+	/*
+	 * The register (0x103c) below has been used to program the 
+	 * chip to do the IP header alignment. The idea was to fix the
+	 * IP header alignment by using existing unused registers,
+	 * so that this feature can be implemented quickly. If these 
+	 * registers are not programmed, then the chip will not align the 
+	 * IP headers and an extra copy would have to be implemented
+	 * in the driver on the Rx side. I am not sure if this 
+	 * has been documented.  
+	 *			- Manish Lachwani (11/23/2004)
+	 */
 	reg_data_1 = TITAN_GE_READ(0x103c + (port_num << 12));
 	reg_data_1 |= 0x40000000;
 	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);

--DocE+STaALJfprDB--
