Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 07:32:20 +0100 (BST)
Received: from mf2.realtek.com.tw ([220.128.56.22]:24079 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8133569AbVJGGcD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 07:32:03 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.4) with ESMTP id <T73d7e97391dc803816180c@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Fri, 7 Oct 2005 14:33:59 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2005100714314478-331927 ;
          Fri, 7 Oct 2005 14:31:44 +0800 
Message-ID: <002701c5cb08$c9682630$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: gcc of SDE6 cannot compile C++ applications
Date:	Fri, 7 Oct 2005 14:31:44 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/10/07 =?Bog5?B?pFWkyCAwMjozMTo0NQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/10/07 =?Bog5?B?pFWkyCAwMjozMTo0NQ==?=,
	Serialize complete at 2005/10/07 =?Bog5?B?pFWkyCAwMjozMTo0NQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi there,
I upgrade my SDE from 5 to 6.
Before upgrading, we can compile C++ applications. After doing that, C++
cannot be compiled by the gcc of SDE6.
The warning message is like this:
    mipsel-linux-gcc: main.cpp: C++ compiler not installed on this system

I found that MIPS offers C++ compiler running on MIPS.
Does MIPS want us to compile C++ on MIPS, not on X86?

Regards,
Colin
