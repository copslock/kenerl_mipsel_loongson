Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 18:32:04 +0100 (BST)
Received: from msr32.hinet.net ([IPv6:::ffff:168.95.4.132]:51118 "EHLO
	msr32.hinet.net") by linux-mips.org with ESMTP id <S8225347AbUJORb6>;
	Fri, 15 Oct 2004 18:31:58 +0100
Received: from dinosaur (218-168-152-123.dynamic.hinet.net [218.168.152.123])
	by msr32.hinet.net (8.9.3/8.9.3) with SMTP id BAA19614
	for <linux-mips@linux-mips.org>; Sat, 16 Oct 2004 01:31:29 +0800 (CST)
Message-ID: <002f01c4b2dc$cd1262e0$7101a8c0@dinosaur>
From: =?big5?B?qkyr2KZ3?= <Mickey@turtle.ee.ncku.edu.tw>
To: <linux-mips@linux-mips.org>
Subject: Is there any means to use Cramfs and JFFS2 images as root disks?
Date: Sat, 16 Oct 2004 01:31:20 +0800
Organization: III
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <Mickey@turtle.ee.ncku.edu.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mickey@turtle.ee.ncku.edu.tw
Precedence: bulk
X-list: linux-mips


Hello,
I had successfully booted up Linux with an NFS root.
Trying to boot up Linux with Cramfs and JFFS2 roots, I am wondering how to
pass parameters to Kernel.
I found that on some bootloaders, parameters are like these:
    rootfstype = jffs2 root=/dev/mtdblock3

But YAMON doesn't seem to support MTD BLOCK.
Therefore, how do I tell Kernel where the root image is on YAMON?

Thanks and regards,
Colin
