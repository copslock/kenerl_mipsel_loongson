Received:  by oss.sgi.com id <S553721AbRATXpV>;
	Sat, 20 Jan 2001 15:45:21 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:18183 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553717AbRATXow>; Sat, 20 Jan 2001 15:44:52 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14K7ga-0004a1-00; Sun, 21 Jan 2001 00:44:44 +0100
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14K7ga-0008IP-00; Sun, 21 Jan 2001 00:44:44 +0100
Date:   Sun, 21 Jan 2001 00:44:44 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20010121004444.A31862@bilbo.physik.uni-konstanz.de>
References: <20001015021522.B3106@bilbo.physik.uni-konstanz.de> <20010117154937.C2517@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117154937.C2517@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Jan 17, 2001 at 03:49:37PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 17, 2001 at 03:49:37PM +0100, Florian Lohoff wrote:
> On Sun, Oct 15, 2000 at 02:15:23AM +0200, Guido Guenther wrote:
> > Hi,
> > with the following two patches (first against dvhtool, second against
> > current cvs kernel) it's possible to boot the Indy from a local harddisk
> > without the need of IRIX to install it in the volume header. Set 
> > setenv OSLoader linux 
> > and 
> > setenv OSLoadPartition /dev/sd(whatever)
> > in the boot-prom and do a: 
> > dvhtool -d /dev/sda(whatever) --unix-to-vh (your_favorite_ecoff_kernel) linux

I just noticed that the kernel patch is slightly broken, it fails when
you specify additional boot parameters. Fixed one is at:
    http://honk.physik.uni-konstanz.de/linux-mips/indy-boot/linux-2001-01-20.diff
