Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 13:12:05 +0100 (BST)
Received: from p508B62CE.dip.t-dialin.net ([IPv6:::ffff:80.139.98.206]:51744
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225987AbUENMME>; Fri, 14 May 2004 13:12:04 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4ECBxxT008541;
	Fri, 14 May 2004 14:11:59 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4ECBxpj008540;
	Fri, 14 May 2004 14:11:59 +0200
Date: Fri, 14 May 2004 14:11:58 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: shiraz.ta@philips.com
Cc: linux-mips@linux-mips.org
Subject: Re: Porting of Linux on to a MIPS16 Processor. Help required
Message-ID: <20040514121158.GA5466@linux-mips.org>
References: <OF9C1094DD.6309A695-ON45256E94.002F4A91-65256E94.00311FA8@philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9C1094DD.6309A695-ON45256E94.002F4A91-65256E94.00311FA8@philips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 14, 2004 at 02:24:50PM +0530, shiraz.ta@philips.com wrote:

> I am new to linux.  I am  in need of porting linux to a MIPS16 based
> processor.   I need some information regarding the porting. It will be a
> great help if somebody could answer me.
>
> 1) Is there any port available already for this? If available how do i get
> it along with the development environment.
> 
> 2) If the port  is not available  then how much complex (How much effort ?)
> is it to port it to MIPS 16.
> 
> 3) Where can  I get the tool chain on windows and linux kernel source code
> which can be used .

You forgot to mention the exact processor type but anyway, MIPS16 is
really just an extension.  As such Linux can run on a system without
actually knowing anything about MIPS16.  Which is nice, if you intend to
actually exploit MIPS16 you don't have to have that working right away but
can introduce support later, as optimization for size.

Windows?  Good luck.  I've seen success reports with Cygwin but if you want
to keep things sane, use a Linux box for development.

> 6) I would like to know how much would be  the code size for the kernel
> alone with out any shell and with  the console driver. (Source code and
> Binary)

To my knowledge nobody has used MIPS16 for Linux so far.  There seems
little point in that because MIPS16 primarily targets very small systems -
a class of systems that Linux doesn't tend to run on well.

  Ralf
