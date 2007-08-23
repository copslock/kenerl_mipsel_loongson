Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2007 02:18:42 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:25165 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023163AbXHWBSk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Aug 2007 02:18:40 +0100
Received: by mo.po.2iij.net (mo30) id l7N1HJHa000316; Thu, 23 Aug 2007 10:17:19 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l7N1HIDK013842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2007 10:17:18 +0900
Message-Id: <200708230117.l7N1HIDK013842@po-mbox302.po.2iij.net>
Date:	Thu, 23 Aug 2007 10:17:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Brian Murphy <brm@murphy.dk>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add back support for LASAT platforms
In-Reply-To: <46CC9E2E.5090402@murphy.dk>
References: <200708212034.l7LKYGiD011023@potty.localnet>
	<20070822101425.430da249.yoichi_yuasa@tripeaks.co.jp>
	<46CC9E2E.5090402@murphy.dk>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

On Wed, 22 Aug 2007 22:35:58 +0200
Brian Murphy <brm@murphy.dk> wrote:

> Yoichi Yuasa wrote:
> 
> <much snipping>
> >> +
> >> +config DS1603
> >> +	bool "DS1603 RTC driver"
> >> +	depends on LASAT
> >>     
> >
> > If you add new RTC driver, it should go to drivers/rtc.
> >   
> It's hardly new, is it? It was removed by you with the rest
> of the LASAT stuff two months ago after it had been in the kernel
> for 5 years. Why are RTC drivers more important than any others?
> And why is it important that a platform specific driver goes in a
> common area when only one platform uses it?

DS1603 can be likely to be used with others.
But,

> The driver is quite platform specific:
> 
> 1) It needs to adjust for a slow transistor on the I/O line to allow
> for three-stating.
> 2) A special lasat_ndelay which guesses the clock speed based
> on platform to allowi the bit-banging interface to control the device
> before the CP0 timer is calibrated (by the RTC).
> 3) Platform specific I/O which is not programmable (part of an FPGA/CPLD).
> 
> 1 Is basically solved now in an ugly manner with a long delay parameter.
> 2 I cant really see a sensible solution to.
> 3 I could use the new fancy gpio interface but as the I/O is neither
> general or programmable I'm not sure of the point. If someone else
> needed the driver then I would have no problem in doing this but as
> it is it seems like a waste of time.
> 
> The interface the rtc uses is still used by many drivers implemented
> in the platform directories and is much simpler and straightforward
> than the general interface used by the drivers in drivers/rtc and will
> give more code.
> 
> I have no problems with your other points but I would really like the
> RTC code to stay where it is.

it's OK with me.

Yoichi
