Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 23:13:28 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:23256
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225240AbTBDXN1>; Tue, 4 Feb 2003 23:13:27 +0000
Received: from bogon.sigxcpu.org (kons-d9bb55c6.pool.mediaWays.net [217.187.85.198])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id F1FAF2BC2D
	for <linux-mips@linux-mips.org>; Wed,  5 Feb 2003 00:13:22 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 0FEB24AF4C; Wed,  5 Feb 2003 00:12:03 +0100 (CET)
Date: Wed, 5 Feb 2003 00:12:03 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030204231203.GY16674@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <20030204061323.GA27302@pureza.melbourne.sgi.com> <20030204092417.GR16674@bogon.ms20.nix> <20030204223930.GD27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204223930.GD27302@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 09:39:30AM +1100, Andrew Clausen wrote:
> It was blindly copying from the environment variable a string
> looking like dksc(0,1,2).  This should be translated (somehow)
> to something looking like /dev/sdb1.  This would have to be
> done after the hard disk probes.
If you set OSLoadPartition=/dev/sda1 (or whatever) - it allows you to
boot from hard disk without any boot loader involved. If you have a
bootloader (which is only true for IP22 [1]) it sets up the kernels
commandline properly anyway - so where's the problem? nfsroot?
 -- Guido

[1] talking only about SGI mips systems here
