Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f440G8L21675
	for linux-mips-outgoing; Thu, 3 May 2001 17:16:08 -0700
Received: from myth1.Stanford.EDU (myth1.Stanford.EDU [171.64.15.14])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f440G6F21672
	for <linux-mips@oss.sgi.com>; Thu, 3 May 2001 17:16:06 -0700
Received: (from johnd@localhost)
	by myth1.Stanford.EDU (8.11.1/8.11.1) id f440FxX14778;
	Thu, 3 May 2001 17:15:59 -0700 (PDT)
Date: Thu, 3 May 2001 17:15:59 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: Guido Guenther <guido.guenther@gmx.net>, <linux-mips@oss.sgi.com>
Subject: Re: NFS -13 error
In-Reply-To: <20010502155424.A9256@bilbo.physik.uni-konstanz.de>
Message-ID: <Pine.GSO.4.31.0105031707340.14342-100000@myth1.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have downloaded the linux stuff and a kernel image(2.4.0-ip22) from the
site listed below.  I am getting a kernel panic.  I am nolonger getting
nfs errors. I added a link from /tftpboot/to the debian linux directory on
the server.  I guess dhcp_bootp doesn't have the right flag set or
something.  However, the message is:

>Kernel panic: I have no root and I want to scream.

Is there a flag that I need to set for the root? I have /etc/exports with
the -root=sgilinuxIPaddress,rw for the parent directory of the linux
distribution?  I have tried other vmlinux kernels and gotten the same type
of problem.  THe one from sgi says it can't mount fs and ask for root=.  I
have tried to set that at the bootp():vmlinux root=/linux but that did not
help either. Furthermore, I am not getting an mountd error on the SGI
server.  Any and all suggestions would be greatly appreciated.

I am trying to install linux from an SGI Indy running IRIX over the
network.

thanks,
john davis

On Wed, 2 May 2001, Guido Guenther wrote:

> On Tue, May 01, 2001 at 04:29:18PM -0700, John D. Davis wrote:
> >
> > I am having a problem installing linux on a 4400 indy.  I downloaded a
> > "fixed" version from: honk.physik.uni-konstanz,de/linux-mips/install
> > and downloaded :
> > root-be-0.04.cpio
> This one is *very* outdated. Don't use it. It's there for purely
> "historic reasons".
> See
>   ftp://ftp.uni-mainz.de/pub/Linux/debian-local/mips/
> for an up to date root image.
>  -- Guido
>
