Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 22:51:59 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.207]:50337 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226701AbVGNVvl> convert rfc822-to-8bit;
	Thu, 14 Jul 2005 22:51:41 +0100
Received: by wproxy.gmail.com with SMTP id i31so517684wra
        for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 14:52:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RXh5j+AVqALvdq7KFNo0ZcerD/L/HnrL2fOH2F+WtZ9xRYV0LsJ2jXiRQZckpMB/8zcq5E4Oud9svfeOdc0wug1Om5tl8rPXbNMzJG9S7ijUZ0OozKRzl/c7fWOSUxz8kwGRqB3kga6oaInp6Ab2qkH+q3GJvBjVaYVsag18fQQ=
Received: by 10.54.106.13 with SMTP id e13mr906168wrc;
        Thu, 14 Jul 2005 14:52:50 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 14 Jul 2005 14:52:50 -0700 (PDT)
Message-ID: <2db32b720507141452df44769@mail.gmail.com>
Date:	Thu, 14 Jul 2005 14:52:50 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	ppopov@embeddedalley.com
Subject: Re: What is the current USB support status on DB1550?
Cc:	Kevin Turner <kevin.m.turner@pobox.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1121376170.16115.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b7205071408327b005e4e@mail.gmail.com>
	 <1121356192.4797.362.camel@localhost.localdomain>
	 <1121374174.30104.7.camel@troglodyte.asianpear>
	 <1121376170.16115.30.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

The drive is identified in the file "devices".
Pete,
I can't get my netac flash drive working on db1550. Could you tell me
what went wrong?

I mount the usbfs as "mount none /proc/bus/usb  -t usbfs".
In /proc/bus/usb, I don't see "drivers", only "001" and "devices".

Under /proc/scsc/usb-storage, there is file "0", which gives the
information for this drive:
Host scsi0: usb-storage
Vendor: Netac
Product: OnlyDisk
Serial number: None
Protocol: Transparent SCSI
Transport: Bulk

The output from usb-storage debug keeps showing
"Bad target number", since the device->id is not 0 and the flags is 0.
Any suggestion on this part? 

...
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2:0)
usb-storage: scsi cmd done, result=0x40000
...

Thanks


On 7/14/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> On Thu, 2005-07-14 at 13:49 -0700, Kevin Turner wrote:
> > On Thu, 2005-07-14 at 08:49 -0700, Pete Popov wrote:
> > > Host only. We couldn't make gadget work due to interrupt latency
> > > requirements by the HW that couldn't be reliably achieved with Linux.
> > > But gadget does work on the Au1200.
> >
> > Is the Au1500 in the same boat as the DB1550?
> 
> The Db1550 is the reference board for the Au1550.
> 
> >  Do the hardware
> > requirements apply to all boards with that SOC, or is it somewhat
> > board-dependent?
> 
> All boards with the 1100, 1500, or 1550. The Au1200 gadget works, but
> the usb controller on the SOC is different. We've made the other CPUs
> work before but it was on top of RTLinux, different/proprietary usb
> stack, and a lot of debug and tuning.
> 
> Pete
> 
> 
>
