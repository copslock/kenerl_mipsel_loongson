Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2009 07:57:40 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:34964 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366147AbZAXH5X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jan 2009 07:57:23 +0000
Received: (qmail 22699 invoked from network); 24 Jan 2009 08:57:20 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 24 Jan 2009 08:57:20 +0100
Date:	Sat, 24 Jan 2009 08:57:34 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Frank Neuber <linux-mips@kernelport.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1550 with kernel linux-2.6.28.1
Message-ID: <20090124085734.5b6b5c66@scarran.roarinelk.net>
In-Reply-To: <1232739600.28527.289.camel@t60p>
References: <1232739600.28527.289.camel@t60p>
Organization: Private
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.14.5; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hallo Frank,

On Fri, 23 Jan 2009 20:40:00 +0100
Frank Neuber <linux-mips@kernelport.de> wrote:
> at the moment I run a 2.6.16.11 on this core. Because of some trouble
> with the USB 2.0 EHCI controller (which is wired on the internal PCI
> bus) I am thinking about running a more recent kernel. 
> It was easy to build linux-2.6.28.1 based on the db1550_defconfig using
> the mips_4KCle-gcc (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) toolchain.
> But I see nothing on the serial console after starting the kernel. Some
> time ago (10 month I think) I was testing the head of the git mips
> kernel and the system was booting with some trouble on the pci bus but I
> was able so see someting on the serial console.
> 
> A quick search on this list show me
> http://www.linux-mips.org/archives/linux-mips/2008-11/msg00099.html
> the last activity on the alchemy chip.

That stuff went in in time for 2.6.29-rc2, so it's unlikely to be the
cause of your problems.


> I just want to ask who is working with the au1550 on a more recent
> kernel than 2.6.16.11. 
> I'll start now with some early printk to solve booting problems and than
> we will see .....

I know of at least one person running 2.6.26 or .27 on a Au1550.
You should start by throwing away the defconfig ;-).  Create a new
config with only au1x00 serial and serial console enabled and then add
new devices one at a time and see where it breaks.

(Btw, which board?  I'd love to get my hands on other alchemy boards to
test on).

Thanks!
	Manuel Lauss
