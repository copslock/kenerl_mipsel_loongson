Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 17:07:38 +0000 (GMT)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:35737
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225414AbUANRHf>; Wed, 14 Jan 2004 17:07:35 +0000
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id MAA08534;
	Wed, 14 Jan 2004 12:07:23 -0500 (EST)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id MAA13945;
	Wed, 14 Jan 2004 12:07:22 -0500 (EST)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Wed, 14 Jan 2004 12:07:22 -0500 (EST)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: "Zajerko-McKee, Nick" <nmckee@telogy.com>,
	<linux-mips@linux-mips.org>
Subject: Re: Correct assembler/compiler options for 4KC core?
In-Reply-To: <20040114165025.GB22218@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.44.0401141200460.13057-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

If 2.95 is too old for him, where should he(and I) get the latest stable
packages. It seems like the MIPS environment is varied and there are
toolchains for various processors in different locations. Is the toolchain
and binutils for 4k/5k processors on the linux-mips.org ftp site?
Is the correct gcc 3.2.xx? Will it build 2.4.2x that is in linux-mips cvs?
Will it build 2.6? Will it build 64bit kernels? It would be nice if
someone in the know could create a chart or add the info to readme or
howto on linux-mips.org site.
Thanks for sharing what you know.
David


On Wed, 14 Jan 2004, Thiemo Seufer wrote:

> Zajerko-McKee, Nick wrote:
> > Hi,
> >
> > I'm trying to use the following opcodes: movz, movn, clo, clz, madd, msub on
> > both a 4KC and 4KeC core. What gas options should I use to get the above
> > opcodes to work (mips4?  mips32?)
>
> With a modern toolchain: -march=mips32.
>
> > How would one link against closed source
> > libraries that were compiled for mips2?
>
> This will just work if you use a recent binutils version, and if the
> libraries are O32 ABI conformant.
>
> > Is there a list of what opcodes
> > correspond to the various ISA's and gas flags?  The best reference I saw was
> > from fsf that just mentions the -mips1/-mips2/-mips3/-mips4. I did notice
> > in the latest gas docs -march option,
>
> -mips32 is retained as an alias for -march=mips32.
>
> > but I don't see that available in my
> > toolchain.  I'm running on a development system with gas 2.9.5 and gcc 2.96.
>
> gas 2.9.5 is _very_ old. It might be possible to use "-mips4 -mgp32" for
> movn, movz, but I'm not sure if this actually works. For the other opcodes
> the toolchain is just too old.
>
>
> Thiemo
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
