Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Nov 2004 08:52:06 +0000 (GMT)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:65292 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8224924AbUKCIwC>; Wed, 3 Nov 2004 08:52:02 +0000
Received: from msx.realtek.com.tw (unverified [172.20.1.77]) by mf2.realtek.com.tw
 (Content Technologies SMTPRS 4.3.14) with ESMTP id <T6d0bc3539adc803816a20@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Wed, 3 Nov 2004 16:53:05 +0800
Received: from rtpdii3098 ([172.19.26.139])
          by msx.realtek.com.tw (Lotus Domino Release 6.0.2CF1)
          with ESMTP id 2004110316530665-48494 ;
          Wed, 3 Nov 2004 16:53:06 +0800 
Message-ID: <01e101c4c182$5d0f2780$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-mips@linux-mips.org>
Subject: KGDB: I cannot stop execution by using "ctrl+c"
Date: Wed, 3 Nov 2004 16:51:52 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/11/03 =?Bog5?B?pFWkyCAwNDo1MzowNg==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/11/03
 =?Bog5?B?pFWkyCAwNDo1MzowNw==?=,
	Serialize complete at 2004/11/03 =?Bog5?B?pFWkyCAwNDo1MzowNw==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
When using gdb to debug Linux kernel, I found that it cannot be stopped
temporarily by using "ctrl+c".
After the first strike of "ctrl+c", nothing happen.
After the second, Linux kernel will show these messages:
    Interrupted while waiting for the program.
    Give up (and stop debugging it)? (y or n)
If choose yes, kernel will totally stop and it goes back to gdb shell.
How can I stop kernel temporarily and then resume it?

Thanks and regards,
Colin
