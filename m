Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Dec 2004 09:55:38 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:11387
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225074AbULKJzZ>; Sat, 11 Dec 2004 09:55:25 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Cd3xv-000685-00; Sat, 11 Dec 2004 10:55:03 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Cd3xb-0001W0-00; Sat, 11 Dec 2004 10:54:43 +0100
Date: Sat, 11 Dec 2004 10:54:43 +0100
To: engel@mathematik.uni-marburg.de
Cc: linux-mips@linux-mips.org
Subject: Re: Recommended gcc/binutils Versions for mips64 target?
Message-ID: <20041211095443.GA26784@rembrandt.csv.ica.uni-stuttgart.de>
References: <57004.62.226.168.187.1102755045.squirrel@62.226.168.187>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57004.62.226.168.187.1102755045.squirrel@62.226.168.187>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

engel@mathematik.uni-marburg.de wrote:
> 
> Hi,
> 
> I'm currently trying to cross-compile a kernel (2.6.10-pre3 from cvs with
> the IP30 patch from Stanislaw) for my Octane (IP30) on Linux/amd64.
> 
> What versions of gcc and binutils are currently recommended
> for crosscompiling? The target should simply be mips64-linux if I read the
> Makefile correctly? This has caused problems as my binutils version
> 2.15.92.0.2 configured with mips64-linux didn't produce a linker that was
> capable of using elf64btsmip, mips64-linux-gnu did work.

Unless 2.15.92.0.2 deviates significantly from the GNU version, both
mips64-linux and mips64-linux-gnu should have the same capabilities.

> I'm also a bit confused as to why IP30 support is located in the arch/mips/
> hierarchy and not arch/mips64/. IIRC, the Octane definitely needs a 64 bit
> kernel to boot?

arch/mips64 doesn't exist an more for 2.6, the 64bit support was moved
to arch/mips.


Thiemo
