Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78GDmm21375
	for linux-mips-outgoing; Wed, 8 Aug 2001 09:13:48 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78GDiV21371
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 09:13:44 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6091810CF; Wed,  8 Aug 2001 18:13:42 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5E1D53F24; Wed,  8 Aug 2001 17:43:51 +0200 (CEST)
Date: Wed, 8 Aug 2001 17:43:51 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ian <ian@WPI.EDU>
Cc: Guido Guenther <guido.guenther@gmx.net>,
   Soeren Laursen <soeren.laursen@scrooge.dk>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
Message-ID: <20010808174351.C17694@paradigm.rfc822.org>
References: <20010808154246.A25205@gandalf.physik.uni-konstanz.de> <Pine.OSF.4.33.0108081039480.6638-100000@grover.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.OSF.4.33.0108081039480.6638-100000@grover.WPI.EDU>; from ian@WPI.EDU on Wed, Aug 08, 2001 at 10:46:24AM -0400
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 10:46:24AM -0400, Ian wrote:
> 
> > You simply need to recreate a sgi partition table which is no problem
> > with a current fdisk. That's all you need  to make linux bootable from
> > harddisk.
> 
> Right.  But how to I get to that point?  There is NO bootloader?  I have
> no Irix 6.x media available to restore those partitions.
> 

tftp/nfs-root boot ? The prom is enough.

> I was planning to use HardHat as a basis to build a custom LFS
> (http://www.linuxfromscrtach.org) system from.  It would be sufficient.

Hardhat is VERY old and you will get really in trouble to get any
current software integrated into the distribution.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
