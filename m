Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2003 02:40:03 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:7888 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225261AbTBFCkC>;
	Thu, 6 Feb 2003 02:40:02 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h160e6G8021756;
	Wed, 5 Feb 2003 16:40:07 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id NAA12628; Thu, 6 Feb 2003 13:39:54 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h162ds8G001758;
	Thu, 6 Feb 2003 13:39:54 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h162dqtK001756;
	Thu, 6 Feb 2003 13:39:52 +1100
Date: Thu, 6 Feb 2003 13:39:52 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Guido Guenther <agx@sigxcpu.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: debian installer on mips64 (origin 200)
Message-ID: <20030206023952.GC1278@pureza.melbourne.sgi.com>
References: <20030203041432.GF967@pureza.melbourne.sgi.com> <20030205092800.GD16674@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205092800.GD16674@bogon.ms20.nix>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 10:28:00AM +0100, Guido Guenther wrote:
> > Perhaps a better approach is to get the kernel to prompt users to
> > change disks, and stick in the vanilla debian CD?  i.e. have a
> > "mips64-bootstrap.img" CD image, which prompts for install-1 afterwards.
>
> Why not use the CONFIG_EMBEDDED_RAMDISK option to append the installer
> image as initrd to the kernel and dump this into the vh? To build the vh
> on the CD you can probably use the same script Flo made for IP22:
>  http://www.silicon-verl.de/home/flo/software/genisovh-0.1.tgz

Sounds sane :)

Unfortunately, I haven't been able to boot kernels stored in the volume
header :(

Cheers,
Andrew
