Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2003 15:49:48 +0100 (BST)
Received: from p508B6225.dip.t-dialin.net ([IPv6:::ffff:80.139.98.37]:31144
	"EHLO p508B6225.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225209AbTHOOtq>; Fri, 15 Aug 2003 15:49:46 +0100
Received: from [IPv6:::ffff:210.22.155.234] ([IPv6:::ffff:210.22.155.234]:685
	"EHLO mail.koretide.com.cn") by linux-mips.net with ESMTP
	id <S869101AbTHOOtp> convert rfc822-to-8bit; Fri, 15 Aug 2003 16:49:45 +0200
Received: from zhufeng ([192.168.1.12])
	(authenticated)
	by mail.koretide.com.cn (8.11.6/8.11.6) with ESMTP id h7FElSc21538;
	Fri, 15 Aug 2003 22:47:28 +0800
From: =?UTF-8?B?5pyx5Yek?= <zhufeng@koretide.com.cn>
To: <wd@denx.de>
Cc: "Wilson Chan" <wilsonc@cellvision1.com.tw>,
	<linux-mips@linux-mips.org>
Subject: RE: gdbserver and gdb debugging stub for mips 
Date: Fri, 15 Aug 2003 22:49:21 +0800
Message-ID: <MGEELAPMEFMLFBMDBLKLIEKICEAA.zhufeng@koretide.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
In-Reply-To: <20030815135018.B55C0C59E4@atlas.denx.de>
Return-Path: <zhufeng@koretide.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhufeng@koretide.com.cn
Precedence: bulk
X-list: linux-mips

 what do you mean by "MIPS is NOT MIPS"? Does it mean there are too many mips boards?

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: 2003年8月15日 21:50
To: Öì·ï
Cc: Wilson Chan; linux-mips@linux-mips.org
Subject: Re: gdbserver and gdb debugging stub for mips 


In message <MGEELAPMEFMLFBMDBLKLGEKGCEAA.zhufeng@koretide.com.cn> you wrote:
> I'm also looking for them . If anybody who has , please tell me , thank you.

MIPS isn't MIPS. What exactly are you looking for?

We have gdb (cross and native) / gdbserver included with our ELDK for
MIPS - this is for 4Kc CPUs.

See section "3. Embedded Linux Development Kit" at
http://www.denx.de/twiki/bin/view/DULG/BoardSelect (select incaip).

Hope this helps.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If you can, help others. If you can't, at least don't hurt  others."
- the Dalai Lama
