Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2003 19:08:44 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:8638
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225203AbTCRTIn>; Tue, 18 Mar 2003 19:08:43 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18vMS1-001wwg-00; Tue, 18 Mar 2003 20:08:41 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18vMS1-0004xw-00; Tue, 18 Mar 2003 20:08:41 +0100
Date: Tue, 18 Mar 2003 20:08:41 +0100
To: linux-mips@linux-mips.org
Cc: Guido Guenther <agx@sigxcpu.org>
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318174241.GG2613@bogon.ms20.nix>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:
> On Tue, Mar 18, 2003 at 05:03:03PM +0100, Thiemo Seufer wrote:
> > Try
> >    -mabi=o32 -march=r5000 -Wa,--trap
> > This may fail if the compiler is very old, though.
> > 
> > > for IP22? -mips2 conflicts with -march=r5000 since this implies -mips4.
> > 
> > This was fixed in very recent gcc. -mips2 should be an alias for -march=r6000
> > and -mips4 one for -march=r8000.
> Is it correct that -mipsX in contrast to -march=rXXXX has the difference
> of not only selecting a specific CPU instruction set but also an abi
> (o32 or n64)?

Only for old compilers, an only for some cases. :-/

-mipsX is the old method for selecting both CPU and ABI, resembling the way
SGI did it for their toolchain. Then there was the need to support different
CPUs, which led to -mcpu/-mXXXX. The result was an inconsistent mess,
especially -mips2 has multiple overloaded semantics.

> If so wouldn't it be cleaner to remove -mipsX altogether
> and use -march=rXXXX and -mabi=o32, etc?

This would be nice, but older compilers don't have -march/-mtune.
IIRC gcc 3.0.X is the first one to employ these. Similiar for -mabi.

> The different meanings of these
> options in different toolchain versions confuse me a lot. What is the
> final intended usage of these options?

For usual userland the ABI defines everything needed. This means

No options at all:
Produce, hosted on a single ABI system, a userland binary with the lowest
possible ISA.

-mabi=FOO: 
Produce, hosted on a multi ABI system, a userland binary with the lowest
possible ISA for the selected ABI.

Then there are optimizations for different CPUs.

-march=BAR:
Allow opcodes for CPU BAR in addition to the ISA ones.

-mtune=BAZ:
Optimize opcode scheduling for CPU BAZ.

Some embedded systems don't care much about ABI compatibility, they
use also

-mgp32/-mfp32:
Restrict register width to 32 bits on 64 bit CPUs.

Then, there are the backward compatibility options.

-mipsX:
Is an alias for -march=QUUX, where QUUX is the CPU closest to the respective
ISA. Note that this is only backward compatible for the assembler, not for
the compiler which implied some o32 features for -mips2.

-mcpu=XXX, -mYYYY:
Old CPU selection code, mostly gone now. Superseded by -march/-mtune.


For my private linux kernels, I use a new CONFIG_MIPS_NEW_TOOLCHAIN in the
Makefile. I don't see a better way around it.


Thiemo
