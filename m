Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 07:06:22 +0100 (BST)
Received: from [IPv6:::ffff:203.199.202.17] ([IPv6:::ffff:203.199.202.17]:17169
	"EHLO pub.isofttechindia.com") by linux-mips.org with ESMTP
	id <S8225370AbTIKGGT>; Thu, 11 Sep 2003 07:06:19 +0100
Received: from ghgp8w6dvrof4f ([192.168.0.107])
	by pub.isofttechindia.com (8.11.0/8.11.0) with SMTP id h8B637t03755
	for <linux-mips@linux-mips.org>; Thu, 11 Sep 2003 11:33:07 +0530
From: "durai" <durai@isofttech.com>
To: <linux-mips@linux-mips.org>
Subject: unresolved symbol dptoli
Date: Thu, 11 Sep 2003 11:33:07 +0530
Message-ID: <BLEMJDCPNEFOILECKALMMEDICAAA.durai@isofttech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <durai@isofttech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: durai@isofttech.com
Precedence: bulk
X-list: linux-mips


hi,
i compiled a wireless lan driver using the mips-linux-gcc compiler 2.95.3.
When i try to insmod the driver i got the following errors. any ideas?

insmod: unresolved symbol dptoli
insmod: unresolved symbol dpmul
insmod: unresolved symbol litodp

Note that, i havent used any of these above functions in my code. It appears
only in the .o files


Durairaj P
Senior Software Engineer
Integrated SoftTech Solutiond Pvt. Ltd
Chennai 600 018
India
Tel : +91(44)2436 4915 Ext 88
www.isofttech.com
