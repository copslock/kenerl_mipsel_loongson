Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 09:29:42 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:45272
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225200AbTBEJ3l>; Wed, 5 Feb 2003 09:29:41 +0000
Received: from bogon.sigxcpu.org (unknown [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 4BC712BC2D
	for <linux-mips@linux-mips.org>; Wed,  5 Feb 2003 10:29:39 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id B38234AF4C; Wed,  5 Feb 2003 10:28:00 +0100 (CET)
Date: Wed, 5 Feb 2003 10:28:00 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: debian installer on mips64 (origin 200)
Message-ID: <20030205092800.GD16674@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
References: <20030203041432.GF967@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203041432.GF967@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 03, 2003 at 03:14:32PM +1100, Andrew Clausen wrote:
> Anyway, in principle, I should be able write a shell script to
> create the above image, and add an isofs partition containing the debian
> mips install cd.  Just, I bet it can't deal with sash / the prom
> properly - it's probably dependent on arcboot.  Also, it would need
> different kernel packages.
It only makes sense to build 'native' kernel packages if we have the
corresponding toolchain packaged. Nobody ever packaged the mips64
binutils/egcs from oss for debian.

[..snip..] 
> Perhaps a better approach is to get the kernel to prompt users to
> change disks, and stick in the vanilla debian CD?  i.e. have a
> "mips64-bootstrap.img" CD image, which prompts for install-1 afterwards.
Why not use the CONFIG_EMBEDDED_RAMDISK option to append the installer
image as initrd to the kernel and dump this into the vh? To build the vh
on the CD you can probably use the same script Flo made for IP22:
 http://www.silicon-verl.de/home/flo/software/genisovh-0.1.tgz
Regards,
 -- Guido
