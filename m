Received:  by oss.sgi.com id <S554068AbRAQOtb>;
	Wed, 17 Jan 2001 06:49:31 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:40717 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554063AbRAQOtM>;
	Wed, 17 Jan 2001 06:49:12 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C76347FC; Wed, 17 Jan 2001 15:49:02 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 75FD9F597; Wed, 17 Jan 2001 15:49:37 +0100 (CET)
Date:   Wed, 17 Jan 2001 15:49:37 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20010117154937.C2517@paradigm.rfc822.org>
References: <20001015021522.B3106@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001015021522.B3106@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Sun, Oct 15, 2000 at 02:15:23AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Oct 15, 2000 at 02:15:23AM +0200, Guido Guenther wrote:
> Hi,
> with the following two patches (first against dvhtool, second against
> current cvs kernel) it's possible to boot the Indy from a local harddisk
> without the need of IRIX to install it in the volume header. Set 
> setenv OSLoader linux 
> and 
> setenv OSLoadPartition /dev/sd(whatever)
> in the boot-prom and do a: 
> dvhtool -d /dev/sda(whatever) --unix-to-vh (your_favorite_ecoff_kernel) linux

I just retried to put the stuff into the volume header wich worked:

I set this in the prom:

OSLoadFilename=vmlinux
OSLoadPartition=/dev/sda1
OSLoader=vmlinux
SystemPartition=scsi(1)disk(4)rdisk(0)partition(0)

when now typing "boot" i get

Unable to load scsi(1)disk(4)rdisk(0)partition(0)/vmlinux: no recognizable
file system on device.

Whereas this is correct - scsi(1) is the extern SCSI Bus on the Indigo2
and disk(4) is therefor /dev/sde

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
