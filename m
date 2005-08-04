Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2005 11:49:34 +0100 (BST)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:28941 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8225624AbVHDKtP>; Thu, 4 Aug 2005 11:49:15 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.4) with ESMTP id <T728ee9041fdc80381613d4@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Thu, 4 Aug 2005 17:18:27 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2005080417162317-215319 ;
          Thu, 4 Aug 2005 17:16:23 +0800 
Message-ID: <009b01c598d5$2ede3e20$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: Compiling uClibc with MIPS SDE6
Date:	Thu, 4 Aug 2005 17:16:23 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/08/04 =?Bog5?B?pFWkyCAwNToxNjoyMw==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/08/04 =?Bog5?B?pFWkyCAwNToxNjoyNA==?=,
	Serialize complete at 2005/08/04 =?Bog5?B?pFWkyCAwNToxNjoyNA==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi there,
I encounter a problem when compiling uClibc with SDE6. If compiling with
debug information enabled, the output executable file of busybox is about
the same with the one that is compiled with SDE5, but uClibc libraries are
over 10 times the size of the ones that are compiled with SDE5. I am
wondering if it is because GCC 3.4.4 of SDE6 has changed some parameters
setting?

Regards,
Colin
