Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6J0aBN20783
	for linux-mips-outgoing; Wed, 18 Jul 2001 17:36:11 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6J0aAV20780
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 17:36:10 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 15E7F125BD; Wed, 18 Jul 2001 17:36:09 -0700 (PDT)
Date: Wed, 18 Jul 2001 17:36:09 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Seth Mos <knuffie@xs4all.nl>
Cc: linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010718173609.A21139@lucon.org>
References: <3B55AA0B.42D212E@mips.com> <Pine.BSI.4.10.10107182218050.23958-100000@xs4.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSI.4.10.10107182218050.23958-100000@xs4.xs4all.nl>; from knuffie@xs4all.nl on Wed, Jul 18, 2001 at 10:53:22PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 18, 2001 at 10:53:22PM +0200, Seth Mos wrote:
> 
> I am having trouble getting the mipsel packages installed using the
> installer provided for 7.1.
> 
> 
> I have hooked up a second disk to my i386 workstatition that will house
> the filesystem for my mipsel box. Once everything is installed I will put
> this disk back in my Qube2 for testing. In the worst case scenario I will
> need to boot with the 2.0 kernel that came with the cube.
> 
> I have the original disk for the Qube2 so it isn't a big problem if it
> takes 50 attempts. I have a lot of patience ;-)
> 
> Am I correct to assume that I need to use the install.i386.hd on my
> workstation to install the mipsel packages on the second harddrive (hdd in
> my case)

No. It should be install.mipsel.nfs. install.mipsel.hd is for the
native mipsel machine install.

> 
> Traceback (innermost, last):
>   File "./findrpm", line 5, in ?
>     import rpm
> ImportError: No module named rpm
> 
> Does this ring any bells?

You need to install the rpm-python rpm.

> The mipsel packages are located in the RPMS directory which is in the same
> directory as the installer and I edited the Makefile and changed ROOT and
> REDHAT-ROOT

Sure.

> 
> I wonder if anyone can provide a basic root tarbal which I can use to set
> up the basics after which i can start adding stuff.
> 

install.mipsel.nfs is used to create a NFS root tree for mipsel. If
you tar it up, you get what you are asking for.



H.J.
