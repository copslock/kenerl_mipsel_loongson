Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 17:31:17 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.194]:6938 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226051AbVF1QbA> convert rfc822-to-8bit;
	Tue, 28 Jun 2005 17:31:00 +0100
Received: by wproxy.gmail.com with SMTP id i22so674892wra
        for <linux-mips@linux-mips.org>; Tue, 28 Jun 2005 09:30:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X5o3FaUSpZC1sZDBboeYwzIbLkIwcU7C367Fm6NGk5GF3sFeSH9+8TYVaCVmRBy2yPBsUBQzVnxzKhQMJ2Wno0LGpSoysEJ1Tbzu84Y/5tQBGouMkw16+CPZq9AzzbbkfWoTBMT5qNcYsDe35Z+Wz3ldG65UlGaLExE12VPpLQI=
Received: by 10.54.92.15 with SMTP id p15mr21657wrb;
        Tue, 28 Jun 2005 09:30:28 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Tue, 28 Jun 2005 09:30:28 -0700 (PDT)
Message-ID: <2db32b720506280930a5de769@mail.gmail.com>
Date:	Tue, 28 Jun 2005 09:30:28 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: can't find interrupt number under /proc/interrupts for the pci multi-port on db1550
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1119966279.32381.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b720506271706201a66fb@mail.gmail.com>
	 <1119966279.32381.7.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I checked again. When I cat sth to /dev/ttyM0 and it is stuck there, I
cat /proc/interrupts, the interrupt number show up for that driver,
but the number of interrupts for that driver is always 0, which seems
not OK. I am wondering if such interrupt is routed to somewhere else? 
If that is possible, what is the most likely place, the
au1x00_serial.c?

thanks


On 6/28/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-06-28 at 01:06, rolf liu wrote:
> > I am running 2.4.31 on db1550 with a pci multi-port board. the kernel
> > starts up ok. but after start-up, I can't find the corresponding
> > interrupt number for this board, which is irq 2. I can find the device
> > under /proc/devices and /proc/tty/driver, etc. So I am now sure if it
> > is working ok. Is there good (simple) method to test this serial port?
> 
> Do something like
> 
>        cat /dev/ttySwhatever
> 
> then look at the IRQ list. The interrupt will only be allocated while
> the port is in use.
> 
>
