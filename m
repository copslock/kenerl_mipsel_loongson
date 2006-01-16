Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 08:14:19 +0000 (GMT)
Received: from mf2.realtek.com.tw ([60.248.182.46]:17679 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S3457192AbWAPIN7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 08:13:59 +0000
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T75e06cae14dc803816c34@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Mon, 16 Jan 2006 16:19:52 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2006011616174962-447378 ;
          Mon, 16 Jan 2006 16:17:49 +0800 
Message-ID: <005101c61a75$43edc6b0$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: Can I use this kind of performance counters to implement oProfile?
Date:	Mon, 16 Jan 2006 16:17:17 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/01/16 =?Bog5?B?pFWkyCAwNDoxNzo0OQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/01/16 =?Bog5?B?pFWkyCAwNDoxNzo1MQ==?=,
	Serialize complete at 2006/01/16 =?Bog5?B?pFWkyCAwNDoxNzo1MQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
Our SOC has performance counters, and we would like to use oProfile on it.
After surveying the oProfile doc, I found that the model of our performance
counters donot seem to fit oProfile.
This is because oProfile uses the interrupts caused by overflow of, say,
cache miss count to estimate the probability of this event in every portion.
Our SOC doesn't emit interrupt when event count overflow. Therefore,
oProfile cannot be used to estimate cache miss event on our chip. Is that
right?

Regards,
Colin
