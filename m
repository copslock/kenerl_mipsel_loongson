Received:  by oss.sgi.com id <S305156AbQAQDty>;
	Sun, 16 Jan 2000 19:49:54 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41515 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQAQDte>; Sun, 16 Jan 2000 19:49:34 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA06744; Sun, 16 Jan 2000 19:53:37 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA37479
	for linux-list;
	Sun, 16 Jan 2000 19:39:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA78118
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 16 Jan 2000 19:39:51 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from jester.ti.com (jester.ti.com [192.94.94.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA05447
	for <linux@cthulhu.engr.sgi.com>; Sun, 16 Jan 2000 19:39:50 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by jester.ti.com (8.9.3/8.9.3) with ESMTP id VAA28914;
	Sun, 16 Jan 2000 21:38:58 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id VAA19931;
	Sun, 16 Jan 2000 21:39:12 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id VAA19925;
	Sun, 16 Jan 2000 21:39:12 -0600 (CST)
Received: from ti.com (IDENT:jharrell@pcp97780pcs.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id VAA10635;
	Sun, 16 Jan 2000 21:39:34 -0600 (CST)
Message-ID: <38828F72.F0FA585@ti.com>
Date:   Sun, 16 Jan 2000 20:41:38 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Conrad Parker <conradp@cse.unsw.edu.au>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: question concerning serial console setup
References: <386A5F9B.50B4AFEF@ti.com> <19991230114736.C18261@cse.unsw.edu.au>
Content-Type: multipart/alternative;
 boundary="------------BF0E0AD9983241233F42A942"
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--------------BF0E0AD9983241233F42A942
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Conrad Parker wrote:

> On Wed, Dec 29, 1999 at 12:23:07PM -0700, Jeff Harrell wrote:
> > I wonder if anybody might have some information concerning the setup of
> > a serial console device
> > on the MIPS/Linux platform.  I have been looking at the sgi (indy)
> > source code to determine how to
> > setup a serial console device.  The file arch/mips/sgi/kernel/setup.c
> > contains a call to "console_setup"
> > passing the parameters "ttys0" and NULL.  I have had some trouble
> > locating the routine that this is
> > actually calling (file, directory?).  It looks like there is a version
> > in printk.c and in one of  the char drivers (serial167.c).
> > These do not seem like the correct routines.
>
> the version in serial167.c is commented out and looks like it was once
> there only as a placeholder.
>
> console_setup() in printk.c is the correct one, but it doesn't do everything
> you want. It simply determines which of the possible consoles is the system
> ("preferred") console. Normally this is called via parse_options in
> init/main.c so you can set it on booting by passing the kernel parameter
> console=blah, but it can be called any time before the kernel calls
> console_init() (which it does immediately after calling parse_options, in
> order to get the console up asap). If you've configured the kernel to run a
> serial console, console_init() (which is in drivers/char/tty_io.c) will call
> serial_console_init().
>

Hmmm....strange I tried to use console_setup  in the same way that  setup.c
called
it in ../arch/mips/sgi/kernel/setup.c and ran into linker problems.  It looks
like
setup_console is defined statically (sp?) in printk.c.

Here is how it is called in setup.c:

     #if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_PROM_CONSOLE)
     extern void console_setup(char *, int *);
     #endif
     ...
     ....
     #ifdef CONFIG_SERIAL_CONSOLE
      /* ARCS console environment variable is set to "g?" for
       * graphics console, it is set to "d" for the first serial
       * line and "d2" for the second serial line.
       */
      ctype = prom_getenv("console");
      if(*ctype == 'd') {
       if(*(ctype+1)=='2')
        console_setup ("ttyS1", NULL);
       else
        console_setup ("ttyS0", NULL);
      }

Here is how it looks in printk.c:

     static int __init console_setup(char *str)
     { .....

I guess I am seeing the error that I would expect to see,  i.e.,  the linker
gives me an
undefined reference.  Any ideas how this worked in the sgi code?

>
> For the SGI/MIPS, (the code you're looking at in
> arch/mips/sgi/kernel/setup.c) the choice of serial console can be
> determined by querying the prom settings, so rather than forcing this to be
> a boot parameter the correct console is set up at runtime. (If I'm not
> mistaken, this can still be overriden by passing a kernel parameter, as
> this bit of setup is called way before init/main.c calls parse_options()).
> However, you don't need to call console_setup() in your platform setup
> routine -- it's only done here for convenience.

Unfortunately I am working on an embedded platform, only using this code
as a starting point for our design.  If possible I would like to initialize the

console w/o the use of command line parameters.

Any insight that you can provide would be greatly appreciated.

Thanks,
Jeff


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



--------------BF0E0AD9983241233F42A942
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Conrad Parker wrote:
<blockquote TYPE=CITE>On Wed, Dec 29, 1999 at 12:23:07PM -0700, Jeff Harrell
wrote:
<br>> I wonder if anybody might have some information concerning the setup
of
<br>> a serial console device
<br>> on the MIPS/Linux platform.&nbsp; I have been looking at the sgi
(indy)
<br>> source code to determine how to
<br>> setup a serial console device.&nbsp; The file arch/mips/sgi/kernel/setup.c
<br>> contains a call to "console_setup"
<br>> passing the parameters "ttys0" and NULL.&nbsp; I have had some trouble
<br>> locating the routine that this is
<br>> actually calling (file, directory?).&nbsp; It looks like there is
a version
<br>> in printk.c and in one of&nbsp; the char drivers (serial167.c).
<br>> These do not seem like the correct routines.
<p>the version in serial167.c is commented out and looks like it was once
<br>there only as a placeholder.
<p>console_setup() in printk.c is the correct one, but it doesn't do everything
<br>you want. It simply determines which of the possible consoles is the
system
<br>("preferred") console. Normally this is called via parse_options in
<br>init/main.c so you can set it on booting by passing the kernel parameter
<br>console=blah, but it can be called any time before the kernel calls
<br>console_init() (which it does immediately after calling parse_options,
in
<br>order to get the console up asap). If you've configured the kernel
to run a
<br>serial console, console_init() (which is in drivers/char/tty_io.c)
will call
<br>serial_console_init().
<br>&nbsp;</blockquote>
Hmmm....strange I tried to use console_setup&nbsp; in the same way that&nbsp;
setup.c called
<br>it in ../arch/mips/sgi/kernel/setup.c and ran into linker problems.&nbsp;
It looks like
<br>setup_console is defined statically (sp?) in printk.c.
<p>Here is how it is called in setup.c:
<blockquote><font size=-1>#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_PROM_CONSOLE)</font>
<br><font size=-1>extern void console_setup(char *, int *);</font>
<br><font size=-1>#endif</font>
<br><font size=-1>...</font>
<br><font size=-1>....</font>
<br><font size=-1>#ifdef CONFIG_SERIAL_CONSOLE</font>
<br><font size=-1>&nbsp;/* ARCS console environment variable is set to
"g?" for</font>
<br><font size=-1>&nbsp; * graphics console, it is set to "d" for the first
serial</font>
<br><font size=-1>&nbsp; * line and "d2" for the second serial line.</font>
<br><font size=-1>&nbsp; */</font>
<br><font size=-1>&nbsp;ctype = prom_getenv("console");</font>
<br><font size=-1>&nbsp;if(*ctype == 'd') {</font>
<br><font size=-1>&nbsp; if(*(ctype+1)=='2')</font>
<br><font size=-1>&nbsp;&nbsp; console_setup ("ttyS1", NULL);</font>
<br><font size=-1>&nbsp; else</font>
<br><font size=-1>&nbsp;&nbsp; console_setup ("ttyS0", NULL);</font>
<br><font size=-1>&nbsp;}</font></blockquote>

<p><br>Here is how it looks in printk.c:
<blockquote><font size=-1>static int __init console_setup(char *str)</font>
<br><font size=-1>{ .....</font></blockquote>
I guess I am seeing the error that I would expect to see,&nbsp; i.e.,&nbsp;
the linker gives me an
<br>undefined reference.&nbsp; Any ideas how this worked in the sgi code?
<blockquote TYPE=CITE>&nbsp;
<br>For the SGI/MIPS, (the code you're looking at in
<br>arch/mips/sgi/kernel/setup.c) the choice of serial console can be
<br>determined by querying the prom settings, so rather than forcing this
to be
<br>a boot parameter the correct console is set up at runtime. (If I'm
not
<br>mistaken, this can still be overriden by passing a kernel parameter,
as
<br>this bit of setup is called way before init/main.c calls parse_options()).
<br>However, you don't need to call console_setup() in your platform setup
<br>routine -- it's only done here for convenience.</blockquote>
Unfortunately I am working on an embedded platform, only using this code
<br>as a starting point for our design.&nbsp; If possible I would like
to initialize the
<br>console w/o the use of command line parameters.
<p>Any insight that you can provide would be greatly appreciated.
<p>Thanks,
<br>Jeff
<br>&nbsp;
<pre>--&nbsp;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Work:&nbsp; (801) 619-6104&nbsp;
Broadband Access group/TI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</pre>
&nbsp;</html>

--------------BF0E0AD9983241233F42A942--
