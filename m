Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78KdhR11811
	for linux-mips-outgoing; Wed, 8 Aug 2001 13:39:43 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78KdgV11803
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 13:39:42 -0700
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 15Ua7A-0004AX-00; Wed, 08 Aug 2001 22:39:40 +0200
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15Ua7A-0003Gl-00; Wed, 08 Aug 2001 22:39:40 +0200
Date: Wed, 8 Aug 2001 22:39:40 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: Ian <ian@WPI.EDU>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
Message-ID: <20010808223940.B12550@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: Ian <ian@WPI.EDU>, linux-mips <linux-mips@oss.sgi.com>
References: <20010808174351.C17694@paradigm.rfc822.org> <Pine.OSF.4.33.0108081532180.2274-100000@grover.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.OSF.4.33.0108081532180.2274-100000@grover.WPI.EDU>; from ian@WPI.EDU on Wed, Aug 08, 2001 at 03:35:22PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 03:35:22PM -0400, Ian wrote:
> > tftp/nfs-root boot ? The prom is enough.
> 
> When I type "boot bootp():/tftpboot/kernel-hardhat" at the PROM command
> monitor, I get an error that it can't find Sash (the Irix [6.2]
> bootloader).  Sash appears to be necessary to do a netboot.
Try just "bootp():". The prom is clever enough to figure out the rest. 
>
> HardHat will a sufficient base to build a new system on (i.e. LFS) from
> scratch.  LFS is a program where you simply build a complete Linux system
I doubt that. You can't compile a recent glibc with that outdated toolchain.
 -- Guido
