Received:  by oss.sgi.com id <S305175AbPL3A6S>;
	Wed, 29 Dec 1999 16:58:18 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:45153 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305166AbPL3A6C>;
	Wed, 29 Dec 1999 16:58:02 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08171; Wed, 29 Dec 1999 16:58:14 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA40461
	for linux-list;
	Wed, 29 Dec 1999 16:48:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA18474
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Dec 1999 16:48:21 -0800 (PST)
	mail_from (conradp@cse.unsw.edu.au)
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU [129.94.242.29]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id QAA03578
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Dec 1999 16:48:17 -0800 (PST)
	mail_from (conradp@cse.unsw.edu.au)
Received: From ives With LocalMail ; Thu, 30 Dec 99 11:47:36 +1100 
From:   Conrad Parker <conradp@cse.unsw.edu.au>
To:     Jeff Harrell <jharrell@ti.com>, linux@cthulhu.engr.sgi.com
Date:   Thu, 30 Dec 1999 11:47:36 +1100
Message-ID: <19991230114736.C18261@cse.unsw.edu.au>
Subject: Re: question concerning serial console setup
References: <386A5F9B.50B4AFEF@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <386A5F9B.50B4AFEF@ti.com>; from Jeff Harrell on Wed, Dec 29, 1999 at 12:23:07PM -0700
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Dec 29, 1999 at 12:23:07PM -0700, Jeff Harrell wrote:
> I wonder if anybody might have some information concerning the setup of
> a serial console device
> on the MIPS/Linux platform.  I have been looking at the sgi (indy)
> source code to determine how to
> setup a serial console device.  The file arch/mips/sgi/kernel/setup.c
> contains a call to "console_setup"
> passing the parameters "ttys0" and NULL.  I have had some trouble
> locating the routine that this is
> actually calling (file, directory?).  It looks like there is a version
> in printk.c and in one of  the char drivers (serial167.c).
> These do not seem like the correct routines.

the version in serial167.c is commented out and looks like it was once
there only as a placeholder.

console_setup() in printk.c is the correct one, but it doesn't do everything
you want. It simply determines which of the possible consoles is the system
("preferred") console. Normally this is called via parse_options in
init/main.c so you can set it on booting by passing the kernel parameter
console=blah, but it can be called any time before the kernel calls
console_init() (which it does immediately after calling parse_options, in
order to get the console up asap). If you've configured the kernel to run a
serial console, console_init() (which is in drivers/char/tty_io.c) will call
serial_console_init().

For the SGI/MIPS, (the code you're looking at in
arch/mips/sgi/kernel/setup.c) the choice of serial console can be
determined by querying the prom settings, so rather than forcing this to be
a boot parameter the correct console is set up at runtime. (If I'm not
mistaken, this can still be overriden by passing a kernel parameter, as
this bit of setup is called way before init/main.c calls parse_options()).
However, you don't need to call console_setup() in your platform setup
routine -- it's only done here for convenience.

> In our architecture we are
> using the 85C30 (SCC) driver
> (zs.c, zs.h),  can I use the serial_console_init routines from this code
> to accomplish the same thing?  Is
> serial_console setting up additional information that won't get setup
> elsewhere?   Any help would be
> greatly appreciated.
> 

using zs.c and zs.h from where? (ie. your own code, or from somewhere like
drivers/tc?) drivers/sgi/char/sgiserial.c also implements Z8530 support
nicely.

The serial console routines set up linux console functions that happen
to use the serial device; a console is something that basically provides
a write function, possibly a read function, and some other stuff like
special key settings. So, eg. your console write function (like
zs_console_write in sgiserial.c) does a few serial put_chars and so on.

You need to set up a struct console with these fields (as defined in
<linux/console.h>), then make a serial_console_init() function that
calls register_console (defined in printk.c). It'll become the default
system console if it's the first console to be registered (and nothing
then calls console_setup), or if you pass the console=ttyS? parameter to
the kernel.

Conrad.
