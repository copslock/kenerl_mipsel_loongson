Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JL3Uk22072
	for linux-mips-outgoing; Thu, 19 Jul 2001 14:03:30 -0700
Received: from mail.coltex.nl (edge.coltex.nl [194.151.97.115])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JL3SV22067
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 14:03:28 -0700
Received: from auto-nb1.xs4all.nl (perle-wan1.coltex.nl [10.0.1.177])
	by mail.coltex.nl (8.11.2/8.11.2) with ESMTP id f6JL3Me07114;
	Thu, 19 Jul 2001 23:03:23 +0200
Message-Id: <4.3.2.7.2.20010719225315.03c4a878@pop.xs4all.nl>
X-Sender: knuffie@pop.xs4all.nl
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 19 Jul 2001 23:03:07 +0200
To: "H . J . Lu" <hjl@lucon.org>
From: Seth Mos <knuffie@xs4all.nl>
Subject: Re: Updates on RedHat 7.1/mips
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20010718173609.A21139@lucon.org>
References: <Pine.BSI.4.10.10107182218050.23958-100000@xs4.xs4all.nl>
 <3B55AA0B.42D212E@mips.com>
 <Pine.BSI.4.10.10107182218050.23958-100000@xs4.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At 17:36 18-7-2001 -0700, H . J . Lu wrote:
>On Wed, Jul 18, 2001 at 10:53:22PM +0200, Seth Mos wrote:
> >
> > I am having trouble getting the mipsel packages installed using the
> > installer provided for 7.1.
> >
> >
> > I have hooked up a second disk to my i386 workstatition that will house
> > the filesystem for my mipsel box. Once everything is installed I will put
> > this disk back in my Qube2 for testing. In the worst case scenario I will
> > need to boot with the 2.0 kernel that came with the cube.
> >
> > I have the original disk for the Qube2 so it isn't a big problem if it
> > takes 50 attempts. I have a lot of patience ;-)
> >
> > Am I correct to assume that I need to use the install.i386.hd on my
> > workstation to install the mipsel packages on the second harddrive (hdd in
> > my case)
>
>No. It should be install.mipsel.nfs. install.mipsel.hd is for the
>native mipsel machine install.

Thank you, it worked :-)

> > Traceback (innermost, last):
> >   File "./findrpm", line 5, in ?
> >     import rpm
> > ImportError: No module named rpm
> >
> > Does this ring any bells?
>
>You need to install the rpm-python rpm.

And again, thank you.

>install.mipsel.nfs is used to create a NFS root tree for mipsel. If
>you tar it up, you get what you are asking for.

Will do once it works.
Everythinhg seems to be installed like it should and I copied the 2.0.34 
cobalt kernel to /boot on the Qube2. I have enabled the serial console of 
the Qube2 and see the firmware scroll along.

BOOTLOADER ramcode: selected partition /dev/hda1
Decompressing done
Executing bootloader kernel...
Jump_to_Real_Kernel: disk error, trying BFD again.
BOOTLOADER ramcode: selected partition /dev/hdc1

etc.. Qubes don't have the second IDE controller so this is nonsense ;-)
Does anybody know what's missing? Do I need to format the ext2 root fs in a 
special way? Do I need to pass on other bootoptions and if so. How do I get 
to a command line prompt of the firmware?
I see that the NetBSD people did that to make it boot another kernel.

I thought that the firmware from the Qubes just boot the vmlinux.gz image 
that it finds in the /boot directory on hda1?

Any help appreciated.

Cheers


--
Seth
Every program has two purposes one for which
it was written and another for which it wasn't
I use the last kind.
