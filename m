Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2004 16:16:39 +0000 (GMT)
Received: from mail002.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.32]:4064
	"EHLO mail002.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225506AbUCTQQi>; Sat, 20 Mar 2004 16:16:38 +0000
Received: from colombia (c211-30-22-201.thorn1.nsw.optusnet.com.au [211.30.22.201])
	by mail002.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id i2KGGUG23960;
	Sun, 21 Mar 2004 03:16:30 +1100
From: "Martin C. Barlow" <mips@martin.barlow.name>
To: "'Thiemo Seufer'" <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: <linux-mips@linux-mips.org>
Subject: RE: hwclock and df seg fault
Date: Sun, 21 Mar 2004 03:16:14 +1100
Message-ID: <000001c40e96$adbdb1f0$6500a8c0@colombia>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
In-Reply-To: <20040320122225.GK25832@rembrandt.csv.ica.uni-stuttgart.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <mips@martin.barlow.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@martin.barlow.name
Precedence: bulk
X-list: linux-mips

Thiemo

With PREEMP turned off, the hwclock command works again. Looks like the
new scheduler may have a little problem.
The df problem is still there. This may be just a user space
mis-configuration error. I'll see if I can find the problem.
Let me know if you need any dumps.

marty

-----Original Message-----
From: Thiemo Seufer [mailto:ica2_ts@csv.ica.uni-stuttgart.de] 
Sent: Saturday, 20 March 2004 11:22 PM
To: Martin C. Barlow
Cc: linux-mips@linux-mips.org
Subject: Re: hwclock and df seg fault


Martin C. Barlow wrote:
[snip]
> Barcelona:/var/log# hwclock
> Mar 21 19:11:20 Barcelona kernel: bad: scheduling while atomic!
[snip]
> Mar 21 19:11:20 Barcelona kernel: note: hwclock[369] exited with 
> preempt_count 2

So this was with CONFIG_PREEMPT, I guess. Does it happen also without
that?


Thiemo
