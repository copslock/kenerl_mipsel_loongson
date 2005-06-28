Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 20:02:46 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.200]:28947 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226064AbVF1TCZ> convert rfc822-to-8bit;
	Tue, 28 Jun 2005 20:02:25 +0100
Received: by wproxy.gmail.com with SMTP id i22so702384wra
        for <linux-mips@linux-mips.org>; Tue, 28 Jun 2005 12:01:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KzWf/lVSZr6Y8dlk5obhxkxVlctLNeRtMt26KvSsqepqFFOPiSWJHuV3n49ZiR7VP5ykeR3wSQTUp7Pgex0xTe9dKIj5O+KiX2mPw4bs9NubovK1HM+WatQw7JmCcoTDHfERm5d7EFBoVj/R4P9uXsGq2XujeT+OeGVoRd6QZq4=
Received: by 10.54.101.6 with SMTP id y6mr103847wrb;
        Tue, 28 Jun 2005 12:01:56 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Tue, 28 Jun 2005 12:01:26 -0700 (PDT)
Message-ID: <2db32b72050628120154cb669@mail.gmail.com>
Date:	Tue, 28 Jun 2005 12:01:26 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: can't find interrupt number under /proc/interrupts for the pci multi-port on db1550
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1119981143.32369.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b720506271706201a66fb@mail.gmail.com>
	 <1119966279.32381.7.camel@localhost.localdomain>
	 <2db32b720506280930a5de769@mail.gmail.com>
	 <1119981143.32369.26.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks for your help.
I tried your script. the result is really interesting.
the interrupt is still shown as 0 times. I even hacked into the do_IRQ
and handle_IRQ_event, let them printk if there is a interrupt number 2
coming in. Still no printk output through klogd logfile. more
interesting thing is there is a timer on the multi-port board, which
is keeping time-out and keeping the timer interrupt up.

Is that possible the board is not enabled to interrupt correctly?
really a pain. I just got the driver from the company. don't know what
is the start point if I want to really dig into the hardware control
of the board.

thanks

 



On 6/28/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-06-28 at 17:30, rolf liu wrote:
> > but the number of interrupts for that driver is always 0, which seems
> > not OK. I am wondering if such interrupt is routed to somewhere else?
> 
> I'd expect it to stay zero unless characters were received or events
> occurred. Something like
> 
>   (echo "Hello world"; cat ) <> /dev/ttywhatever
> 
> ought to cause interrupts
> 
> [That bit of script writes Hello world to the serial port and then
> copies anything from it back to it until you hit ^C]
> 
>
