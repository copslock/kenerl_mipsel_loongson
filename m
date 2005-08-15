Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2005 03:51:59 +0100 (BST)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:28944 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8225760AbVHOCvk>; Mon, 15 Aug 2005 03:51:40 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.4) with ESMTP id <T72c632d8addc80381610fc@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Mon, 15 Aug 2005 10:58:12 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2005081510560561-11568 ;
          Mon, 15 Aug 2005 10:56:05 +0800 
Message-ID: <006c01c5a144$e12c92d0$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: Pthread problem in pthread_create() in uClibc
Date:	Mon, 15 Aug 2005 10:56:05 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/08/15 =?Bog5?B?pFekyCAxMDo1NjowNQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/08/15 =?Bog5?B?pFekyCAxMDo1NjowNw==?=,
	Serialize complete at 2005/08/15 =?Bog5?B?pFekyCAxMDo1NjowNw==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi there,
We have encountered a pthread problem in pthread_create().
Our system is "MIPS Linux kernel 2.6.11 with uClibc 0.9.27". We need to know
if the problem is in Linux kernel or in uClibc.

When calling pthread_create(), it will fail at the line "suspend(self);".
I found that many people have encounter the same problem, but I havn't seen
any solution.
    http://www.uclibc.org/lists/uclibc/2003-April/006031.html
    http://www.uclibc.org/lists/uclibc/2004-June/009271.html
    http://www.uclibc.org/lists/uclibc/2003-July/006570.html

Here is the error message when I use gdbserver to debug it:
    "Cannot access memory at address 0x411104"

There is no this problem in "X86 Linux kernel 2.6.11 with uClibc 0.9.27".
Therefore, we need to know if this problem is because of that the MIPS Linux
kernel has some different thread behaviors from X86 Linux Kernel?

Regards,
Colin
