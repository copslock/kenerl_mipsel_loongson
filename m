Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2M8IPe10915
	for linux-mips-outgoing; Fri, 22 Mar 2002 00:18:25 -0800
Received: from ms45.hinet.net (root@ms45.hinet.net [168.95.4.45])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2M8IMq10912
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 00:18:22 -0800
Received: from sam (61-220-89-134.HINET-IP.hinet.net [61.220.89.134])
	by ms45.hinet.net (8.8.8/8.8.8) with SMTP id QAA13645
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 16:20:43 +0800 (CST)
From: "Y.H. Ku" <iskoo@ms45.hinet.net>
To: <linux-mips@oss.sgi.com>
Subject: BootLoader on MIPS
Date: Fri, 22 Mar 2002 16:16:28 +0800
Message-ID: <NGBBILOAMLLIJMLIOCADKEKFCCAA.iskoo@ms45.hinet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id g2M8INq10913
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello there,

I am trying to porting Prom monitor code to
appropriate MIPS bootloader for loading Linux kernel

I ever make a test sucessfully with ppcboot's to load MBXloader
for transfering control to linux kernel (hardhat).

But I can not find the entry, and make decision what kind of BOOT LOADER
to use on MIPS platform.

I have the ddb5476 board type linux from montavista,
Could anybody give me some suggestion?

--Sam
