Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:10:39 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:48806
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225198AbTBTVKi>; Thu, 20 Feb 2003 21:10:38 +0000
Received: from bogon.sigxcpu.org (kons-d9bb544b.pool.mediaWays.net [217.187.84.75])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 406FE2BC2D
	for <linux-mips@linux-mips.org>; Thu, 20 Feb 2003 22:10:37 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 6333B176DB; Thu, 20 Feb 2003 22:08:59 +0100 (CET)
Date: Thu, 20 Feb 2003 22:08:59 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: Ramdisk image on flash.
Message-ID: <20030220210859.GC27240@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com> <3E552CDF.ECD08EEF@freehandsystems.com> <20030220194115.2A21378A6D@deneb.localdomain> <3E55342D.6E1D36FF@freehandsystems.com> <20030220123732.F7466@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220123732.F7466@mvista.com>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 12:37:32PM -0800, Jun Sun wrote:
> 1) create kernel ELF as normal
> 2) outside the kernel, create .o file that is ramfs root
> 3) outside the kernel, we use a separate tool/program that combines
>    1) and 2) into a new ELF file.  The entry point of the new ELF file
>    would append ramfs parameters (such as "initrd=xxxx") to the args
>    and then jump to kernel_entry.
This is basically what we do for IP22 in debian. We embed kernel and
initrd together with a small loader into one ELF executable. The prom
tftboots and starts the loader. The loader then moves the kernel to it's
loadaddres, puts the initrd to an appropriate address and jumps into
the kernel passing all the necessary args.
 -- Guido
