Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBUMJ0r20668
	for linux-mips-outgoing; Sun, 30 Dec 2001 14:19:00 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBUMIvg20663
	for <linux-mips@oss.sgi.com>; Sun, 30 Dec 2001 14:18:57 -0800
Received: from brahma.roc.com ([202.56.196.162]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA09490
	for <linux-mips@oss.sgi.com>; Fri, 28 Dec 2001 00:18:55 -0800 (PST)
	mail_from (rajeshbv@intotoinc.com)
Received: from rajesh (machine82.roc.com [172.16.1.82])
	by brahma.roc.com (8.9.3/8.8.7) with SMTP id NAA21150
	for <linux-mips@oss.sgi.com>; Fri, 28 Dec 2001 13:27:53 +0530
Message-ID: <003901c18f76$563c7480$520110ac@roc.com>
From: "Rajesh B. V." <rajeshbv@intotoinc.com>
To: <linux-mips@oss.sgi.com>
Subject: Flash File System on MIPS 79S334A Board
Date: Fri, 28 Dec 2001 13:34:54 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,
 
 I am using a IDT MIPS 79S334A Board with on board FLASH 'AM29LV320DB'.
 I have to mount file system on this FLASH for my application usage.
 
 I came to know through the linux-mtd site that JFFS can be used for this 
 purpose with a lower layer mtd driver.
 My questions are
 1) Was this chip is already had supporting lower level read/write/erase 
 driver code in the mtd module?
 2) Did anybody used it on MIPS 79S334 board?
 
 Please give me some hooks on how to proceed for this.
 
 while replying please CC to me.
 
 Thanks in advance,
 --Rajesh
