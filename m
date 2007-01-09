Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2007 02:52:27 +0000 (GMT)
Received: from mf2.realtek.com.tw ([60.248.182.6]:60945 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S28576189AbXAICwX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Jan 2007 02:52:23 +0000
Received: from msx.realtek.com.tw (unverified [172.21.1.77]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T7d12e6286bdc803816a4c@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Tue, 9 Jan 2007 10:53:05 +0800
Received: from rtpdii3098 ([172.21.98.16])
          by msx.realtek.com.tw (Lotus Domino Release 6.5.3)
          with ESMTP id 2007010910521398-230522 ;
          Tue, 9 Jan 2007 10:52:13 +0800 
Message-ID: <1cf601c73399$2ab7cd10$106215ac@realtek.com.tw>
From:	"colin" <colin@realtek.com.tw>
To:	<linux-mips@linux-mips.org>
Subject: Using 802.11x wireless usb device on MIPS platform
Date:	Tue, 9 Jan 2007 10:52:14 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2007/01/09 =?Bog5?B?pFekyCAxMDo1MjoxNA==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2007/01/09 =?Bog5?B?pFekyCAxMDo1MjoxNQ==?=,
	Serialize complete at 2007/01/09 =?Bog5?B?pFekyCAxMDo1MjoxNQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
I have used two 802.11x wireless usb devices successfully on MIPS platform.
One is realtek 8187 and the other one is ralink 2571.
I would like to put them into kernel tree and then I found that there are
not many 802.11x devices supported in Linux. Moreover, there is no any
wireless usb device supported.
It is also very strange that 8187 and 2571 both have their own ieee802.11x
stack and crypt drivers. It seems that Linux doesn't offer them.
I am wondering why Linux is so complex in 802.11x.

Regards,
Colin
