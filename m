Received:  by oss.sgi.com id <S305165AbQBORbc>;
	Tue, 15 Feb 2000 09:31:32 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:40214 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBORbZ>;
	Tue, 15 Feb 2000 09:31:25 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA01852; Tue, 15 Feb 2000 09:26:55 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id JAA28107; Tue, 15 Feb 2000 09:31:25 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA06839
	for linux-list;
	Tue, 15 Feb 2000 09:14:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA66838
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 15 Feb 2000 09:14:18 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA01942
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Feb 2000 09:16:40 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port44.duesseldorf.ivm.de [195.247.65.44])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id SAA26476;
	Tue, 15 Feb 2000 18:13:52 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000215181433.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <00f001bf77a7$01e6cd10$0ceca8c0@satanas.mips.com>
Date:   Tue, 15 Feb 2000 18:14:33 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: ioremap() broken?
Cc:     linux@cthulhu.engr.sgi.com
Cc:     linux@cthulhu.engr.sgi.com,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 15-Feb-00 Kevin D. Kissell wrote:
>>> > 1. Is it really necessary to add anything to the addr in the readb() et
>>> > al.
>>> >    macros? ioremap() already takes care of that.
>>> 
>>> There is something of an "embarassment of riches" in the kernel
>>> code in terms of mechanism for getting at I/O resources.  I don't
>>> think it was ever intended that people use readb() on addresses
>>> that had already been massaged with ioremap().  ioremap() is
>>> used where the driver *expects* an memory-mapped I/O model,
>>> and is applied to pointers that will be used to directly reference
>>> the device.  readb/writeb et. al. are for drivers that think that expect
>>> a more peek/poke like model.  I don't think it was ever intended that
>>> someone apply both at once!
>>
>>Yes it is! Please read Documentation/IO-mapping.txt. To access PCI memory
>>space, you have to use ioremap() and readb() and friends. If PCI drivers have
>>to work across differen architectures, this has to be fixed.
> 
> It is a coincidence that ioremap() is so simple on most current MIPS 
> platforms.  On some systems, and on MIPS systems with more than 
> 512M of combined memory and mapped I/O, it would be necessary
> to invoke VM functions to create (and possibly wire) a kernel address
> mapping, and on such systems ioremap() would have some real work
> to do.

Yes, indeed. The Philips PR31700/Toshiba TMPR3912 is such a beast and I could
imagine that other MIPS based embedded CPUs tend to be similar.

On this particular CPU PCMCIA memory is accessed through *physical* addresses
0x64000000-0x6bffffff, and thus unreachable through KSEG0 or KSEG1. To make
things even more delicate, this CPU is based on a R3000 core and supports 4kB
pages only, so even ye olde "let's create a wired TLB entry with 16 MB page
size"-trick will not work. 

Before you're beginning to ask, yes, I *do* have Linux/MIPS running on a Sharp
Mobilon HC-4500 :-), and, no, PCMCIA is not working yet :-(

What I am trying to say is that sooner or later we may have to deal with this
case as well.

---
Regards,
Harald
