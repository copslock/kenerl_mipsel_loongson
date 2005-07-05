Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 20:43:10 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.198]:19594 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226289AbVGETmz> convert rfc822-to-8bit;
	Tue, 5 Jul 2005 20:42:55 +0100
Received: by wproxy.gmail.com with SMTP id 70so1202633wra
        for <linux-mips@linux-mips.org>; Tue, 05 Jul 2005 12:43:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rtg6vzxipcXmqJpAx8yM3L/laLMxkFAznex1D5FetRJ9ZAwtY1KYid3EIj2rd4NwmcPmU37sHEDoisevyWHM+yum39YFZ1IPXf3CuoxjFYk/Cz6KOZDg1wGgwo+aMP10on1/9utH7VyaQBtRpsSlTU3QJ+mimQtJv4IvW2Uy8wo=
Received: by 10.54.15.38 with SMTP id 38mr4914608wro;
        Tue, 05 Jul 2005 12:43:07 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Tue, 5 Jul 2005 12:43:07 -0700 (PDT)
Message-ID: <2db32b7205070512432bb11fcb@mail.gmail.com>
Date:	Tue, 5 Jul 2005 12:43:07 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Jon Anders Haugum <jonah@omegav.ntnu.no>
Subject: Re: can't find interrupt number under /proc/interrupts for the pci multi-port on db1550
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050628100935.S46441@invalid.ed.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b720506271706201a66fb@mail.gmail.com>
	 <20050628100935.S46441@invalid.ed.ntnu.no>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Jon,
did you make the board work under 2.6.x? I tried to turn off the
au1x00 uart, but the board does not work by just not using au1000.h.
Any idea?

thanks


On 6/28/05, Jon Anders Haugum <jonah@omegav.ntnu.no> wrote:
> On Mon, 27 Jun 2005, rolf liu wrote:
> > I am running 2.4.31 on db1550 with a pci multi-port board. the kernel
> > starts up ok. but after start-up, I can't find the corresponding
> > interrupt number for this board, which is irq 2. I can find the device
> > under /proc/devices and /proc/tty/driver, etc. So I am now sure if it
> > is working ok. Is there good (simple) method to test this serial port?
> 
> My guess is that you can get it working if you disable the built-in serial
> ports in the kernel.
> 
> I've attached a quick'n'dirty patch I made for 2.4.27 that makes it
> possible to use both internal and pci serial ports. It's a hack, but it
> works.
> 
> 
> --
> Jon Anders Haugum
> 
> 
>
