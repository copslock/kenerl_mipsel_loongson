Received:  by oss.sgi.com id <S42225AbQFIPwx>;
	Fri, 9 Jun 2000 08:52:53 -0700
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.30]:28200 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S42199AbQFIPwm>; Fri, 9 Jun 2000 08:52:42 -0700
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 130R3M-0007L7-00; Fri, 9 Jun 2000 17:50:36 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Fri, 9 Jun 2000 17:46:35 +0200
Date:   Fri, 9 Jun 2000 17:46:35 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     Ian Chilton <mailinglist@ichilton.co.uk>,
        Linux-MIPS Mailing List <linux-mips@oss.sgi.com>
Subject: Re: Linux on Indy
Message-ID: <20000609174635.A25844@bert.physik.uni-konstanz.de>
References: <NAENLMKGGBDKLPONCDDOGEBOCMAA.mailinglist@ichilton.co.uk> <Pine.SGI.4.10.10006091025370.1120-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <Pine.SGI.4.10.10006091025370.1120-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Fri, Jun 09, 2000 at 10:31:05AM -0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jun 09, 2000 at 10:31:05AM -0300, J. Scott Kasten wrote:
> 
[..snip..] 
> >From what I have observed, the 5.1 tarball has under the mipseb directory
> a minimal root file system with etc, sbin, lib, etc. in addition to the
> RedHat/RPMS directory.  I suspect that you will need to get that minimal
> root file system mounted, and then use that to run the install and explode
> the RPMS to the disk.  I'm further going to speculate that you will
> probably netboot the thing the first time and do an NFS mounted root to
> make that happen.  But again, this is pure speculation...
That's the way to go. As far as I remember the hardhat installer fires
up automatically when you mount the rootfs per nfs. It will create a fs
on the disk and unpack the rpms. As I did that, most of the scripts failed so
I had to fix up some things by hand(the mailing list archive is a good
read on that). I wrote a short description of what I did after the
hardhat installer finished: 
http://honk.physik.uni-konstanz.de/~agx/mipslinux/install/fix-install.txt
I partitioned the disk from within irix but I can't remember that
cryptic irix device names. Recently someone posted about a mini-distro
he built(search the archives on that). This one might be easier to
install than hardhat.
Regards,
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
