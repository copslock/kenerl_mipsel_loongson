Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 14:37:44 +0100 (BST)
Received: from mf2.realtek.com.tw ([60.248.182.46]:28176 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8133762AbWC2Nhg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 14:37:36 +0100
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T7754657d1bdc803816a88@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Wed, 29 Mar 2006 21:50:45 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2006032921475844-85722 ;
          Wed, 29 Mar 2006 21:47:58 +0800 
Message-ID: <024c01c65337$63931c90$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: Using hardware watchpoint for applications debugging
Date:	Wed, 29 Mar 2006 21:47:58 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/29 =?Bog5?B?pFWkyCAwOTo0Nzo1OA==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/29 =?Bog5?B?pFWkyCAwOTo0ODowMA==?=,
	Serialize complete at 2006/03/29 =?Bog5?B?pFWkyCAwOTo0ODowMA==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
Our applications encounter memory crash very often. Thus we would like to
use hardware watchpoint on our platform, MIPS 4KEc.
After starting to design it, more and more issues emerge. They are listed
below:
    1. WatchLo Register only has 29 bits to indicate the VAddr. Therefore,
it will also trigger exceptions when accessing nearby addresses.
    2. When an exception happens and we find that it's not touching the righ
address, we will discard it. However, exception will happen again because
the former instruction will be re-executed when the exception is finished.

Is there any easy way to solve these problems?

Regards,
Colin
