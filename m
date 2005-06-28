Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 15:57:49 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:20785 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226050AbVF1O5a> convert rfc822-to-8bit;
	Tue, 28 Jun 2005 15:57:30 +0100
Received: by wproxy.gmail.com with SMTP id i22so654660wra
        for <linux-mips@linux-mips.org>; Tue, 28 Jun 2005 07:56:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ksbmp9XmGCw/+9yy9ILT/KHvV+N+/cAc5M6pe58MPanEYn334awxc/hc3PIXOCKrWNKlIYXKWnFXKjrVp+OCLZLxKnIwEQNCaT2JbD35otZuZLrnjixhDOSZxSfDu+d/Sv2HCBTX284H2Z/SVe651Q6b34VxqqNDWxTpU1TzOPA=
Received: by 10.54.16.27 with SMTP id 27mr128946wrp;
        Tue, 28 Jun 2005 07:56:59 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Tue, 28 Jun 2005 07:55:59 -0700 (PDT)
Message-ID: <2db32b7205062807566d7a9f25@mail.gmail.com>
Date:	Tue, 28 Jun 2005 07:56:29 -0700
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
X-archive-position: 8231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I did it and it is just stuck there. I have to use Ctrl-c to kill it.
It seems no working :(

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
