Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f44NvcN28470
	for linux-mips-outgoing; Fri, 4 May 2001 16:57:38 -0700
Received: from myth1.Stanford.EDU (myth1.Stanford.EDU [171.64.15.14])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f44NvbF28467
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 16:57:37 -0700
Received: (from johnd@localhost)
	by myth1.Stanford.EDU (8.11.1/8.11.1) id f44NvPB15778;
	Fri, 4 May 2001 16:57:25 -0700 (PDT)
Date: Fri, 4 May 2001 16:57:24 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: Bas Benschop <b.benschop@tn.utwente.nl>
cc: debian-mips <debian-mips@lists.debian.org>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Indy Linux Install problem
In-Reply-To: <Pine.LNX.4.21.0105040851230.14770-100000@chimay.tn.utwente.nl>
Message-ID: <Pine.GSO.4.31.0105041651270.15717-100000@myth1.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am using the recommended packages and the vmlinux kernel is on the IRIX
server.  I am currently getting the following error:

VFS: Mounted root (nfs filesystem) readonly.
Warning: unable to open an initial console.
Kernel panic: Attempted to kill init!

I don't know why the fs is readonly. I explicitly put rw in the
/etc/exports.  Is this why the initial console cannot be opened? I read
the nfsroot.txt and I have come across other people with the same problem,
but no soln.  What am I missing? I tried both the ecoff and normal
vmlinux, both panic.  This is my command line:

>bootp():vmlinux init=/bin/bash nfsroot=171.64.72.121:/ld2/linux/debian \
root=/dev/nfs

thank you for your assistance,
john davis


On Fri, 4 May 2001, Bas Benschop wrote:

> I also added root=/dev/nfs. Also check the config-2.4.0 to see if nfs root
> fs is compiled in to the kernel. I used
> kernel-image-2.4.0-test9-ip22-r4k, because 2.4.2 had no nfs root fs
> compiled in.
>
> Bas Benschop
> Faculty of Applied Physics
> University of Twente
> The Netherlands
>
> On Thu, 3 May 2001, John D. Davis wrote:
>
> >
> > I am trying to install Linux on an R4400 Indy from another R4400 Indy
> > running IRIX.  I have looked at the list archives at both debian and sgi
> > and found messages with the same kernel panic problem.  Is there a
> > solution?  dhcp_bootp and tftp seem to be configured right.  i don't get
> > any NFS errors in the SYSLOG.  I have also tried the instructions on the
> > digibel.org site and added the nfs_root info for the server.  I am using
> > the base.2.2.2 and kernel-image-2.4.0-ip22-r4k.tgz.  I had to explicitly
> > add /tftpboot directory with a link to the debian linux distribution to
> > rememdy the nfs errors from getfh.
> >
> > Any and all suggestions are greatly appreciated.
> > thanks,
> > john davis
> >
> >
> > --
> > To UNSUBSCRIBE, email to debian-mips-request@lists.debian.org
> > with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
> >
>
>
