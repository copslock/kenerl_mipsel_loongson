Received:  by oss.sgi.com id <S553848AbQLRLHf>;
	Mon, 18 Dec 2000 03:07:35 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:23305 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553831AbQLRLH2>;
	Mon, 18 Dec 2000 03:07:28 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 740657F9; Mon, 18 Dec 2000 12:07:25 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 398F28F74; Mon, 18 Dec 2000 11:59:19 +0100 (CET)
Date:   Mon, 18 Dec 2000 11:59:19 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "H.Heinold" <heinold@physik.tu-cottbus.de>, linux-mips@oss.sgi.com
Subject: Re: FAQ/
Message-ID: <20001218115919.B401@paradigm.rfc822.org>
References: <3A36AFFE.51C9F2B@web.de> <20001213135723.B3060@paradigm.rfc822.org> <3A3C0ACE.8A13EA97@web.de> <20001217020043.B29250@lug-owl.de> <20001217022955.A10064@physik.tu-cottbus.de> <20001217033438.B9742@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001217033438.B9742@bacchus.dhis.org>; from ralf@oss.sgi.com on Sun, Dec 17, 2000 at 03:34:38AM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Dec 17, 2000 at 03:34:38AM +0100, Ralf Baechle wrote:
> > Hm I am still working on the boot floppies for debian, when I have the time.
> > for mipsel they should work, but I only build them for mips.
> > the problem on mips was the sgi disklabel, but that isnt used on dec. 
> 
> But SGI's don't have floppies :-)
> 

The package is only called "boot-floppies" - It doesnt have much in common
with "floppy" images on architectures not having floppy drives. It more
or less the debian installer source package. They for example
build kernel/ramdisk images with the installer for architectures
capable of bootp/tftp like Sun SPARC. We will do similar for
Decstations and SGI and forget the "real" disk images. The problem is
that most of the software is more or less custom debian and will require
some work concerning SGI Disklabel, Kernel 2.4 etc - Henning has done
a lot in there and hopefully Decstations are much simpler (DOS Disklabel)

But still - The biggest problems are glibc, gcc + binutils.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
