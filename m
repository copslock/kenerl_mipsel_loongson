Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 23:46:50 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:24536
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225240AbTBDXqt>; Tue, 4 Feb 2003 23:46:49 +0000
Received: from bogon.sigxcpu.org (kons-d9bb55c6.pool.mediaWays.net [217.187.85.198])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 046142BC2D
	for <linux-mips@linux-mips.org>; Wed,  5 Feb 2003 00:46:48 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 6BD144AF4C; Wed,  5 Feb 2003 00:45:29 +0100 (CET)
Date: Wed, 5 Feb 2003 00:45:29 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030204234529.GZ16674@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <20030204061323.GA27302@pureza.melbourne.sgi.com> <20030204092417.GR16674@bogon.ms20.nix> <20030204223930.GD27302@pureza.melbourne.sgi.com> <20030204231203.GY16674@bogon.ms20.nix> <20030204231909.GE27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204231909.GE27302@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 10:19:09AM +1100, Andrew Clausen wrote:
> Huh?  The firmware uses something looking like OSLoadPartition=dksc(0,1,2),
> not /dev/sda1.
Sure. But what we do on IP22 is to let the kernel look at OSLoadPartition and 
use that as the root device - so we're actually interested in
linux device names. This is basically done since we can't store the root
device in OSLoadOptions due to limited space.

> >  If you have a
> > bootloader (which is only true for IP22 [1]) it sets up the kernels
> > commandline properly anyway - so where's the problem? nfsroot?
> 
> The problem is the firmware (on my IP27, anyway) uses a different
> form to Linux for OSLoadPartition.  OSLoadPartition tells the
> firmware / bootloader (sash here) where to find the kernel.
Again: we don't care what the firmware wants here, we're interested what
the kernel expects. Why do you need sash for booting anyways? Can't
you let the PROM boot the kernel directly?

Anyways, I won't object to change OSLoadPartition, we have a bootloader
on IP22 so this isn't actually needed anymore.
 -- Guido
