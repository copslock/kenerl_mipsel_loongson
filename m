Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2KN51k13375
	for linux-mips-outgoing; Wed, 20 Mar 2002 15:05:01 -0800
Received: from granite.he.net (granite.he.net [216.218.226.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2KN4n913367
	for <linux-mips@oss.sgi.com>; Wed, 20 Mar 2002 15:04:49 -0800
Received: from w2k30g (209-142-39-228.stk.inreach.net [209.142.39.228]) by granite.he.net (8.8.6/8.8.2) with SMTP id PAA26908 for <linux-mips@oss.sgi.com>; Wed, 20 Mar 2002 15:06:17 -0800
Message-ID: <029001c1d063$b5886880$0b01a8c0@w2k30g>
From: "David Christensen" <dpchrist@holgerdanske.com>
To: <linux-mips@oss.sgi.com>
Subject: Fw: Fw: hello
Date: Wed, 20 Mar 2002 15:04:51 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

linux-mips@oss.sgi.com:

Thank you all for your replies.  :-)


Ralf Baechle <ralf@oss.sgi.com> wrote:
>> As an aside, is anybody using a VMware virtual machine for their
>> development host?
> While it can be done there is not much point in doing so unless you
> hate performance ;)

I have three boxes (RH7.1 firewall, SuSE 7.3 server, and W2k
workstation) and a shelf of OS's.  My needs seem to be constantly
changing.  VMware allows me to build a virtual machine that is
configured specifically for one purpose (such as linux-mips development)
without having to sacrifice any hardware (and associated functionality).
I am willing to trade a large gain in flexibility for a small loss in
performance.

For those of you who haven't tried VMware, they offer a 30-day
evaluation:

    http://www.vmware.com/

> mips-elf-gcc however should not be used, there are subtle differences
> between the various ELF/MIPS targets that would turn your life into
> hell ...

OK  It appears that people are pulling in source and/or binary pieces
from various places -- MIPS (cross) compiler, linux-mips kernel,
linux-mips root filesystem, linux userland filesystem, etc..  Mismatches
between tools are definitely going to cause grief.

It would be nice if a person could start with a blank host, install the
host OS, download the MIPS cross compiler source, build the MIPS (cross)
compiler, download the linux-mips kernel, rootfs, userland, etc.,
sources, and build those using their (cross) compiler.  Can this be one
an x86 host using a commercial Linux distribution (my situation)?  Is
there one HOWTO or README that describes such?


Hartvig Ekner <hartvige@mips.com> wrote:
>>>> 2.  What is the preferred host OS...
>>> We use Linux/x86 for kernel compiles,
>> Which Linux distribution does MIPS use?  Since I'm going to be
>> working on an Atlas board using software from MIPS, I would like to
>> match things up exactly.
> Internally for development we use H.J's RedHat 7.1/MIPS miniport.
> Ready-to-go kernel images and installation instructions (via NFS or
> CDROM) for Atlas and Malta boards can be found on ftp.mips.com.

Hmmm.  I guess I was assuming that you were doing MIPS Linux cross
development on x86 hosts using a commercial Linux distribution such as
Red Hat 7.1.  So, let me be more specific.  What host hardware
platform(s) and host operating system(s) does MIPS use to build their
MIPS Linux distribution as found on ftp://ftp.mips.com/pub/linux/mips/?

> For kernel cross compilation we use the following binary RPM's (LE
> shown only):
>
> binutils-mipsel-linux-2.9.5-3
> egcs-mipsel-linux-1.1.2-4
>
> They can be found on:
>
> ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/

OK  Thanks for the link!


Karsten Merker <karsten@excalibur.cologne.de> wrote:
>> Which Linux distribution does MIPS use?  Since I'm going to be
>> working on an Atlas board using software from MIPS, I would like to
>> match things up exactly.
> Several different - there is a Debian port (big and little endian),
> H.J. Lu's RedHat mini-port (big endian AFAIK), Karel van Houten's
> RedHat-based rootfs (little endian), Keith M. Wesolwski's Simple
> Linux (big-endian). I think the most complete of all is Debian.

Please see my comment to Hartvig (above).

>> As an aside, is anybody using a VMware virtual machine for their
>> development host?
> Why should we? VMware emulates i386 on i386, so it would be of no
> help for mips development.

Please see my comment to Ralf (above).

>> 3.  What is the preferred toolchain...
> I always build natively:
> gcc version 2.95.4 20011002 (Debian prerelease)
> GNU ld version 2.11.93.0.2 20020207 Debian/GNU Linux

>>> Yep - The Debian autobuilder run native on little and big endian.
>> Hmmm.  Do you mean GNU autoconf running natively on MIPS, or
>> something running on a Debian x86 host, or something else?
> The autobuilder is a system that checks for new Debian packages which
> are not yet built for mips/mipsel and automatically builds and uploads
> them into the Debian archive. It runs natively (in our case on a
> Lasat Masquerade Pro for little endian and on an SGI Indigo2 for big
> endian).

OK  It looks like you've got a build farm with MIPS/Debian boxes --
nice.


David
