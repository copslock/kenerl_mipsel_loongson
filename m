Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2006 12:29:42 +0000 (GMT)
Received: from mf2.realtek.com.tw ([60.248.182.46]:65295 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S8133428AbWCUM3b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Mar 2006 12:29:31 +0000
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T772af3952edc8038161bb4@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Tue, 21 Mar 2006 20:41:54 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2006032120390890-150303 ;
          Tue, 21 Mar 2006 20:39:08 +0800 
Message-ID: <009101c64ce4$72d78820$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: uptime is too high. Is it normal?
Date:	Tue, 21 Mar 2006 20:39:08 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/21 =?Bog5?B?pFWkyCAwODozOTowOQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/03/21 =?Bog5?B?pFWkyCAwODozOToxMA==?=,
	Serialize complete at 2006/03/21 =?Bog5?B?pFWkyCAwODozOToxMA==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
We use MIPS Linux+uClibc0.9.28+busybox 1.1.0 on our machine.
After use "uptime" to get the loading of device, it shows: 
    03:50:05 up  3:50, load average: 2.00, 2.00, 2.00
Is it normal? It seems too high because my PC Linux has a much lower value:
    20:38:31 up 12 days,  5:11,  5 users,  load average: 0.04, 0.01, 0.00

Regards,
Colin
