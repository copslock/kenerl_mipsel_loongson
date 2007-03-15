Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 13:40:21 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:7853 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021579AbXCONkQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2007 13:40:16 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id D65F4BA208;
	Thu, 15 Mar 2007 14:39:38 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HRqBK-0008Ph-AP; Thu, 15 Mar 2007 13:39:50 +0000
Date:	Thu, 15 Mar 2007 13:39:50 +0000
To:	Rajat Jain <rajat.noida.india@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: How does boot loader pass initrd address / size to kernel?
Message-ID: <20070315133950.GA25863@networkno.de>
References: <b115cb5f0703150143y46a1f877m9dbb43345721c355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115cb5f0703150143y46a1f877m9dbb43345721c355@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Rajat Jain wrote:
> Hi,
> 
> I'm running an ancient Linux kernel 2.4.20 (please don't ask me why
> :-( ) on a MIPS 4KEC. I am experimenting with initrd and my initrd
> fails to mount. My bootloader (U-BOOT) coorectly loads the initrd into
> RAM as I can see.
> 
> I am wondering how does the kernel get to know the address at which
> the initrd is loaded by boot loader? How does the boot loader
> communicate this to the kernel?
> 
> I can see that when emebedding root filesystem into kernel image, the
> symbols __rd_start and __rd_end are defined by the linker script and
> hence the kernel gets to know. However, how does this happen when
> bootloader loads the ramdisk and needs to tell the kernel?

http://www.linux-mips.org/wiki/Kernel_Command_Line_Arguments mentions
rd_start and rd_size which are used for this purpose.


Thiemo
