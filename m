Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 13:01:27 +0000 (GMT)
Received: from illchn-static-203.199.202.17.vsnl.net.in ([IPv6:::ffff:203.199.202.17]:50951
	"EHLO pub.isofttechindia.com") by linux-mips.org with ESMTP
	id <S8225329AbUKINBX>; Tue, 9 Nov 2004 13:01:23 +0000
Received: from mansoor ([192.168.0.140])
	by pub.isofttechindia.com (8.11.0/8.11.0) with SMTP id iA9D18f31189
	for <linux-mips@linux-mips.org>; Tue, 9 Nov 2004 18:31:08 +0530
Message-ID: <04e601c4c65c$2fdc15a0$8c00a8c0@mansoor>
From: "mansoor" <mansoor@isofttech.com>
To: <linux-mips@linux-mips.org>
Subject: Disabling lwc0 instruction
Date: Tue, 9 Nov 2004 18:31:11 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner: Found to be clean
Return-Path: <mansoor@isofttech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mansoor@isofttech.com
Precedence: bulk
X-list: linux-mips

Hi all,

Iam working on lx4189. This core doesnt support 
"lwc0" instruction but my tool chain generates
this instruction.

So when I run some applications it throws 
"unknown instruction" exception.

How can solve this issue ?

I have few solutions but I dont know
whether its correct.


1) Re-build the toolchain with this instruction
    disbaled. But how to do this ?.
2) Write an exception handler to handle this 
    instruction. The exact replacement would be
    "mfc0". how to do this ?


Thanx in advance
Mansoor Ahamed Basheer
