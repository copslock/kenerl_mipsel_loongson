Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2005 23:56:33 +0000 (GMT)
Received: from c-24-6-74-43.client.comcast.net ([IPv6:::ffff:24.6.74.43]:61581
	"EHLO sarang.flyduck.com") by linux-mips.org with ESMTP
	id <S8225262AbVA0X4S>; Thu, 27 Jan 2005 23:56:18 +0000
Received: from acting (exchange01.skystream.com [63.89.190.81])
	by sarang.flyduck.com (8.12.10/8.12.5) with SMTP id j0RNonWV017979
	for <linux-mips@linux-mips.org>; Thu, 27 Jan 2005 15:50:49 -0800
Message-ID: <004201c504cb$d43bacc0$1202a8c0@acting>
From:	"Ho Lee" <flylist@linuxkernel.net>
To:	<linux-mips@linux-mips.org>
References: <41F8688A.24C5725C@procsys.com>
Subject: Re: Davicom driver support in pmon
Date:	Thu, 27 Jan 2005 15:56:32 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <flylist@linuxkernel.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flylist@linuxkernel.net
Precedence: bulk
X-list: linux-mips


Once I did in other platform. Did you set the valid MAC address
to ID registers starting from I/O base + 0xc0?

-- Ho

----- Original Message ----- 
From: "priya" <priya@procsys.com>
To: <linux-mips@linux-mips.org>
Sent: Wednesday, January 26, 2005 8:05 PM
Subject: Davicom driver support in pmon


> Hi,
> I have implemented a davicom driver on
> the same lines as rtl driver in pmon for
> a customized mips platform - but iam not
> able to set the mac ID. After the init
> routine  the driver seem to have has
> received a multicaste frame. This i
> could verify by putting sufficient
> prints. After this nothing happens. I
> guess the mac address is also not set
> properly. Has any one implemented a
> davicom driver in pmon before??
> 
> thanks,
> priya
>
