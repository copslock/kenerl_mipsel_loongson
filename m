Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:09:10 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:779
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225204AbUDXHJJ>; Sat, 24 Apr 2004 08:09:09 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BHHHf-0003Pg-00
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 09:09:07 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BHHHf-0002ys-00
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 09:09:07 +0200
Date: Sat, 24 Apr 2004 09:09:07 +0200
To: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424070906.GN22147@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.55.0404231849480.14494@jurand.ds.pg.gda.pl> <Pine.GSO.4.10.10404240825540.10762-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404240825540.10762-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek wrote:
> Hello,
> 
> why do we attempt to compile the kernel with 32-bit GAS abi and 64-bit GCC
> abi?

It optimizes away a few hundred kB of kernel code, but requires in turn
a sign-extended load-address plus ugly objcopy hacks.

> Is it because the module loader is broken and supports only 32-bit
> ELFs? Then what about machines which load their kernels at weird 64-bit
> addresses, like 0xa800000020004000 (Octane)?

Ah, the same as for IP28. :-) They can't be supported by the current
scheme.

> I have changed it to 64-bit abi in my Octane kernel, because it won't even
> compile otherwise. I've got gcc 3.3.2, gas 2.14.

You'll have to extend all the hand-coded asm memory accesses to do
64bit adressing as well.


Thiemo
