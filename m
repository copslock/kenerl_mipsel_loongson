Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 00:08:55 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:26072
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225240AbTBEAIz>; Wed, 5 Feb 2003 00:08:55 +0000
Received: from bogon.sigxcpu.org (kons-d9bb55c6.pool.mediaWays.net [217.187.85.198])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id B3EC32BC2D
	for <linux-mips@linux-mips.org>; Wed,  5 Feb 2003 01:08:53 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 1F26C4AF4C; Wed,  5 Feb 2003 01:07:35 +0100 (CET)
Date: Wed, 5 Feb 2003 01:07:35 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030205000734.GA16674@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <20030204061323.GA27302@pureza.melbourne.sgi.com> <20030204092417.GR16674@bogon.ms20.nix> <20030204223930.GD27302@pureza.melbourne.sgi.com> <20030204231203.GY16674@bogon.ms20.nix> <20030204231909.GE27302@pureza.melbourne.sgi.com> <20030204234529.GZ16674@bogon.ms20.nix> <20030204235543.GG27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204235543.GG27302@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 10:55:43AM +1100, Andrew Clausen wrote:
> No.  I can't figure out why.  In any case, the PROM uses OSLoadPartition
> to find the kernel.
On IP22 the PROM uses SystemPartition to find the kernel/bootloader.
We set it to something like scsi(0)disk(1)rdisk(0)partition(8) to grab
it from the vh. Is SystemPartition used differently on IP27?

[..snip..]
> So, we should obviously support OSLoadPartition=/dev/sda1 (=> root=/dev/sda1),
> but it would also be nice to support OSLoadPartition=dksc(0,1,3).
Well we could either check if OSLoadPartition matches the linux device
naming scheme or the other way around and see if it looks like a valid
device identifier used by the PROM (I'd prefer the later, though) - or
simply make the OSLoadPartition <-> root= mapping '#ifdef CONFIG_SGI_IP22'.
 -- Guido
