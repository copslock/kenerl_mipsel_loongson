Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2005 09:28:02 +0000 (GMT)
Received: from mf2.realtek.com.tw ([220.128.56.22]:9482 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8133519AbVLMJ1o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Dec 2005 09:27:44 +0000
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T7531950ea4dc80381613b4@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Tue, 13 Dec 2005 17:30:25 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2005121317280651-53657 ;
          Tue, 13 Dec 2005 17:28:06 +0800 
Message-ID: <017301c5ffc7$80383830$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: To put Linux kernel as closer as possible to 0x80000000
Date:	Tue, 13 Dec 2005 17:27:56 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/12/13 =?Bog5?B?pFWkyCAwNToyODowNg==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/12/13 =?Bog5?B?pFWkyCAwNToyODowOQ==?=,
	Serialize complete at 2005/12/13 =?Bog5?B?pFWkyCAwNToyODowOQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
We want to put Linux kernel as closer as possible to the bottom of memory.
I know that there is some stuff put in the beginning of memory, like
Exception table.
So, what's the closest address to 0x80000000 that is allowable to store
kernel?

Regards,
Colin
