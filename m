Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jun 2006 21:54:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25792 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133866AbWFKUyu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Jun 2006 21:54:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5BKsnkI027416;
	Sun, 11 Jun 2006 21:54:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5BKsm64027415;
	Sun, 11 Jun 2006 21:54:48 +0100
Date:	Sun, 11 Jun 2006 21:54:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: PNX8550 fails to compile in 2.6.17-rc4
Message-ID: <20060611205448.GA27193@linux-mips.org>
References: <20060607105221.7b15b243.vitalywool@gmail.com> <20060607142702.GA20184@linux-mips.org> <acd2a5930606111321t11c29c77p83e56615b42902f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd2a5930606111321t11c29c77p83e56615b42902f9@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 12, 2006 at 12:21:57AM +0400, Vitaly Wool wrote:

> On 6/7/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> >This seems to be one of the serial bits for the ip3106 which must have
> >been lost on the way to kernel.org.  Unfortunately the original author
> >does no longer take care of the code.  I just took a stab at the PNX8550
> >code and it has a significant number of other problems.  All small in
> >the sum large enough such that I will mark PNX8550 support broken.
> 
> I took an attempt to compile 2.6.16.20 kernel from linux-mips.org for
> PNX8550 and it went a little further but also failed soon:
> 
>  CC      arch/mips/philips/pnx8550/common/platform.o
> /home/vital/work/opensource/linux-
> 2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:101: error: variable
> `pnx8550_usb_ohci_device' has initializer but incomplete type
> /home/vital/work/opensource/linux-
> 2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102: error: unknown
> field `name' specified in initializer
> /home/vital/work/opensource/linux-
> 2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102: warning: excess
> elements in struct initializer
> /home/vital/work/opensource/linux-
> 2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:102: warning: (near
> initialization for `pnx8550_usb_ohci_device')
> /home/vital/work/opensource/linux-
> 2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:103: error: unknown
> field `id' specified in initializer
> /home/vital/work/opensource/linux-
> 2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:103: warning: excess
> elements in struct initializer
> ...
> /home/vital/work/opensource/linux-
> 2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:101: error: storage
> size of `pnx8550_usb_ohci_device' isn't known
> /home/vital/work/opensource/linux-
> 2.6.16.20/arch/mips/philips/pnx8550/common/platform.c:112: error: storage
> size of `pnx8550_uart_device' isn't known
> make[2]: *** [arch/mips/philips/pnx8550/common/platform.o] Error 1
> make[1]: *** [arch/mips/philips/pnx8550/common] Error 2
> make: *** [vmlinux] Error 2
> 
> Does it make sense to try to fix those? Or will it only result in more
> errore showing up next?

There is a whole number of small problems such as this one but as far
as I look at it all where only simple.

  Ralf
