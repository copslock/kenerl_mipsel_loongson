Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6IKrSX31703
	for linux-mips-outgoing; Wed, 18 Jul 2001 13:53:28 -0700
Received: from smtp8.xs4all.nl (smtp8.xs4all.nl [194.109.127.134])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6IKrQV31699
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 13:53:26 -0700
Received: from xs4.xs4all.nl (xs4.xs4all.nl [194.109.6.45])
	by smtp8.xs4all.nl (8.9.3/8.9.3) with ESMTP id WAA27139;
	Wed, 18 Jul 2001 22:53:22 +0200 (CEST)
Received: from localhost (knuffie@localhost)
	by xs4.xs4all.nl (8.9.0/8.9.0) with ESMTP id WAA07635;
	Wed, 18 Jul 2001 22:53:22 +0200 (CEST)
Date: Wed, 18 Jul 2001 22:53:22 +0200 (CEST)
From: Seth Mos <knuffie@xs4all.nl>
To: linux-mips@oss.sgi.com
cc: "H . J . Lu" <hjl@lucon.org>
Subject: Re: Updates on RedHat 7.1/mips
In-Reply-To: <3B55AA0B.42D212E@mips.com>
Message-ID: <Pine.BSI.4.10.10107182218050.23958-100000@xs4.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I am having trouble getting the mipsel packages installed using the
installer provided for 7.1.


I have hooked up a second disk to my i386 workstatition that will house
the filesystem for my mipsel box. Once everything is installed I will put
this disk back in my Qube2 for testing. In the worst case scenario I will
need to boot with the 2.0 kernel that came with the cube.

I have the original disk for the Qube2 so it isn't a big problem if it
takes 50 attempts. I have a lot of patience ;-)

Am I correct to assume that I need to use the install.i386.hd on my
workstation to install the mipsel packages on the second harddrive (hdd in
my case)

I have tried this approach using both the Makefile approach and by running
the install.i386.hd script.

Traceback (innermost, last):
  File "./findrpm", line 5, in ?
    import rpm
ImportError: No module named rpm

Does this ring any bells?
The mipsel packages are located in the RPMS directory which is in the same
directory as the installer and I edited the Makefile and changed ROOT and
REDHAT-ROOT

I wonder if anyone can provide a basic root tarbal which I can use to set
up the basics after which i can start adding stuff.

If I get it into a decent state I will probably make a dump of the fs so
other people with a Qube (1 or 2) can easily clone it.

I was working to use a 2.4 kernel on a standard Qube but
that was a big problem since 2.4 does not compile with the compiler that
came with it and the glibc did not have large file support.

A fs that I would like to put on the Qube is XFS which I already use on my
own i386 home machines and production machines at work.
Since XFS is also tested on mip64 Irix (IIRC) ai64 PPC ai32 and alpha
under linux I expect that it will probably more work but it is more
resilient and faster recovering after crashes.

So if anyone can give advice on installing using the toolkit or provide a
bootable dump image or root tarbal I would be most grateful.
The qube2 comes with a boot loader that understands ext2 and loads the
linux kernel it finds on the system it will probably make it easier to
boot afterwards.

Cheers
Seth
