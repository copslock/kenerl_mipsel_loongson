Received:  by oss.sgi.com id <S42366AbQFVAB7>;
	Wed, 21 Jun 2000 17:01:59 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:53882 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42245AbQFVABw>;
	Wed, 21 Jun 2000 17:01:52 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA09970
	for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 16:56:55 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA87045 for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 17:00:04 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA65987
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Jun 2000 16:58:17 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: from piglet.twiddle.net (piglet.twiddle.net [207.104.6.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08842
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jun 2000 16:58:16 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: (from rth@localhost)
	by piglet.twiddle.net (8.9.3/8.9.3) id QAA28945;
	Wed, 21 Jun 2000 16:57:44 -0700
Date:   Wed, 21 Jun 2000 16:57:44 -0700
From:   Richard Henderson <rth@twiddle.net>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Message-ID: <20000621165744.C28857@twiddle.net>
References: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jun 20, 2000 at 01:21:10PM +0200, Geert Uytterhoeven wrote:
>1. ISA I/O space is memory mapped on many platforms (e.g. PPC and MIPS). To
>   access it from user space, you cannot plainly use inb() and friends like on
>   PC, but you have to mmap() the correct region of /dev/mem first. This
>   region depends on the machine type and currently there's no simple way to
>   find out from user space.

You may wish to examine the pciconfig_iobase syscall used on Alpha.
It can be used to solve the multiple independant pci bus problem
as well as the ISA base address problem.

>2. ISA memory is not located at physical address 0 on many platforms (e.g. PPC
>   and some MIPS boxes). This means you cannot e.g. use
>   request_mem_region(0xa0000, 65536) to request the legacy VGA region.

This can be fiddled.  Basicly, you pretend that 0 is the base address,
then use ioremap to shift everything up into place.  This assumes that
the ISA bus is contained within exactly one PCI hose.


r~
