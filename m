Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 20:40:54 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:39097 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20039922AbWJJTkw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 20:40:52 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GXMTC-0007vE-32; Tue, 10 Oct 2006 20:36:56 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>)
	id 1GXNT2-00060O-QB; Tue, 10 Oct 2006 21:40:44 +0200
Date:	Tue, 10 Oct 2006 21:40:44 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Dan Malek <dan@embeddedalley.com>
Cc:	linux-mips@linux-mips.org
Message-ID: <20061010194044.GD14539@enneenne.com>
References: <20061010182747.GA14539@enneenne.com> <29381BAC-4A96-4BFE-8E86-836A3564F2F5@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29381BAC-4A96-4BFE-8E86-836A3564F2F5@embeddedalley.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: Problem on au1100 USB device support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

On Tue, Oct 10, 2006 at 03:33:45PM -0400, Dan Malek wrote:
> 
> Many people, including myself, have spent way too many
> hours trying to make this device interface work.  There
> are some errata associated with it, along with some challenging
> design problems.  I have only been able to make it work
> in one instance, with a highly custom RTLinux driver,
> properly matched FIFOs and DMA, and running TCP/IP
> over the link.  It wasn't 100% reliable, but the TCP retries
> made it appear that way to the application (with tolerable
> delays).

May I have your setup sequence? At least I'd like to se some bus
activity...

> The device interface just requires too much babysitting
> by the CPU to function, and the Linux interrupts
> have too much latency to guarantee the CPU can do
> what is necessary in a timely fashion.  The same is
> true of not using DMA.  If you choose not to use the
> DMA for data transfer, the CPU just can't respond
> quickly enough to the interface state changes
> unless you just spend all of your time polling the
> interface.

Ok, but as first step I'd like having some functionality with FIFOs.

> IMHO, I wouldn't waste much time on this, but
> Good Luck if you choose to do so :-)

Thanks a lot!

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
