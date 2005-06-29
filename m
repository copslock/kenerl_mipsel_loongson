Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2005 23:21:38 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.193]:65374 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226076AbVF2WVV> convert rfc822-to-8bit;
	Wed, 29 Jun 2005 23:21:21 +0100
Received: by wproxy.gmail.com with SMTP id i22so944730wra
        for <linux-mips@linux-mips.org>; Wed, 29 Jun 2005 15:20:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ECa52i5QrI+80as8r7D+LnN/UROhohQoHOsIZydyzHVP0ioOJy8kl4YaW9SGBwYYeSFWrKaWBsty+bWovN3BebYuNSlZDmyc6ebHbblG1sYxCE/usmsQ0rXjEE4p7cnaRLjzlt8fjOJ544bLVPLc3a6rMbXw2GHqHPZ1cTTlemo=
Received: by 10.54.50.44 with SMTP id x44mr48960wrx;
        Wed, 29 Jun 2005 15:20:56 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Wed, 29 Jun 2005 15:20:56 -0700 (PDT)
Message-ID: <2db32b72050629152010dab81d@mail.gmail.com>
Date:	Wed, 29 Jun 2005 15:20:56 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: can't find interrupt number under /proc/interrupts for the pci multi-port on db1550
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050628211559.GA2879@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b720506271706201a66fb@mail.gmail.com>
	 <20050628211559.GA2879@linux-mips.org>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

After some work, I found out the problem is the multi-port card is
using some of macros defined in au1000.h, which is not supposed to do.
I gave it a dirty hack by defining such macros in the source file.

Now I can see the interrupts coming up. BUT when I typed:
echo "hello world!">/dev/ttyM0 
the message is shown on terminal connected to this serial port. But it
then is stuck there. Then the rs_timer gives a lot of timeouts and
enter the interrupt service routine each time there is timeout.
rs_close() is never got called. any suggestion on this part?

What is the function of serial_timer? it is just sitting there,
generating timeout, periodically. Just to make sure the interrupt
routine will be called periodically?

thanks


On 6/28/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jun 27, 2005 at 05:06:27PM -0700, rolf liu wrote:
> 
> > I am running 2.4.31 on db1550 with a pci multi-port board. the kernel
> > starts up ok. but after start-up, I can't find the corresponding
> > interrupt number for this board, which is irq 2. I can find the device
> > under /proc/devices and /proc/tty/driver, etc. So I am now sure if it
> > is working ok. Is there good (simple) method to test this serial port?
> 
> Linux will only allocate the interrupt when the interface is actually
> opened, just loading the driver doesn't suffice.
> 
>  Ralf
>
