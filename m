Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f450SH729743
	for linux-mips-outgoing; Fri, 4 May 2001 17:28:17 -0700
Received: from myth1.Stanford.EDU (myth1.Stanford.EDU [171.64.15.14])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f450SGF29740
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 17:28:16 -0700
Received: (from johnd@localhost)
	by myth1.Stanford.EDU (8.11.1/8.11.1) id f450S9L16283;
	Fri, 4 May 2001 17:28:09 -0700 (PDT)
Date: Fri, 4 May 2001 17:28:09 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: Keith M Wesolowski <wesolows@foobazco.org>
cc: Bas Benschop <b.benschop@tn.utwente.nl>,
   debian-mips <debian-mips@lists.debian.org>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Indy Linux Install problem
In-Reply-To: <Pine.GSO.4.31.0105041713320.16128-100000@myth1.Stanford.EDU>
Message-ID: <Pine.GSO.4.31.0105041727200.16219-100000@myth1.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I created a new dev/console wiht c 5 1 and I have a shell.  I am going to
continue the install process.  Thank you all for your assistance!
john davis

On Fri, 4 May 2001, John D. Davis wrote:

>
> This is who recommended the image. I grabbed base2_2.2 and uncompressed it
> on an IRIX box using gzip -dc and tar xopf - .
>
> >>See
> >>  ftp://ftp.uni-mainz.de/pub/Linux/debian-local/mips/
> >>for an up to date root image.
> >> -- Guido
>
>
>
> On Fri, 4 May 2001, Keith M Wesolowski wrote:
>
> > On Fri, May 04, 2001 at 04:57:24PM -0700, John D. Davis wrote:
> >
> > > I am using the recommended packages and the vmlinux kernel is on the IRIX
> > > server.  I am currently getting the following error:
> >
> > Recommended by whom?
> >
> > > VFS: Mounted root (nfs filesystem) readonly.
> > > Warning: unable to open an initial console.
> > > Kernel panic: Attempted to kill init!
> > >
> > > I don't know why the fs is readonly. I explicitly put rw in the
> > > /etc/exports.  Is this why the initial console cannot be opened? I read
> >
> > No.  That usually indicates that your root filesystem is defective.
> > See if /dev/console exists and is c 5 1.  If not, that's the source of
> > your console problem.
>
> So dev console is one problem.
>
> littledipper 13% ls -l dev/console
> crw-rw-rw-    1 root     sys        0,  0 Jan 24 06:18 dev/console
>
> Can I just use mknod and change it to c 5 1 ?
>
> > The init death problem seems more insidious.  Try passing init=/bin/sh
> > or so - this will be even more effective if you have a statically
> > linked shell like ash or sash to use.  Where did you get this
> > filesystem?  For that matter, where did you get this kernel?  There
> > are *lots* of both floating around, even on oss, that may be broken or
> > out of date.
>
> The kernel was downloaded from :
> ftp://ftp.rfc822.org/pub/local/debian-mips/kernel/
> and I am using:  kernel-image-2.4.0-test9 both the ecoff and elf format
> one fail.  In bin, sh is linked to bash:
>
> littledipper 16% ls -l bin/*sh
> -rwxr-xr-x    1 root     sys       724072 Dec 27 04:44 bin/bash
> lrwxr-xr-x    1 root     sys            4 May  3 15:11 bin/rbash -> bash
> lrwxr-xr-x    1 root     sys            4 May  4 16:08 bin/sh -> bash
>
> There is no s/ash.  I can get another copy of the root image if that is
> neceassry or use an older verison.
>
> thanks,
> john
>
>
