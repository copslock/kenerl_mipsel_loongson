Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78NNZ704086
	for linux-mips-outgoing; Wed, 8 Aug 2001 16:23:35 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78NNXV04077
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 16:23:33 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5F8661184; Thu,  9 Aug 2001 01:23:32 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8A5403F1C; Thu,  9 Aug 2001 01:23:18 +0200 (CEST)
Date: Thu, 9 Aug 2001 01:23:18 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ian <ian@WPI.EDU>
Cc: Guido Guenther <guido.guenther@gmx.net>,
   Soeren Laursen <soeren.laursen@scrooge.dk>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
Message-ID: <20010809012318.A23123@paradigm.rfc822.org>
References: <20010808174351.C17694@paradigm.rfc822.org> <Pine.OSF.4.33.0108081532180.2274-100000@grover.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.OSF.4.33.0108081532180.2274-100000@grover.WPI.EDU>; from ian@WPI.EDU on Wed, Aug 08, 2001 at 03:35:22PM -0400
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 03:35:22PM -0400, Ian wrote:
> > tftp/nfs-root boot ? The prom is enough.
> 
> When I type "boot bootp():/tftpboot/kernel-hardhat" at the PROM command
> monitor, I get an error that it can't find Sash (the Irix [6.2]
> bootloader).  Sash appears to be necessary to do a netboot.

Try to delete the "boot" at the beginning - That means to start the
sash bootloader which will do the bootp request which the prom is
able to do itself.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
