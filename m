Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 08:41:34 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:34018 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122958AbSIEGld>;
	Thu, 5 Sep 2002 08:41:33 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g856emXb012593;
	Wed, 4 Sep 2002 23:40:49 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA00256;
	Wed, 4 Sep 2002 23:40:44 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g856eib08243;
	Thu, 5 Sep 2002 08:40:44 +0200 (MEST)
Message-ID: <3D76FC6B.C9AA72F3@mips.com>
Date: Thu, 05 Sep 2002 08:40:43 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
References: <Pine.GSO.3.96.1020904170056.10619H-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 94
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" wrote:

> On Wed, 4 Sep 2002, Ralf Baechle wrote:
>
> > >  It would be nice if we could keep a single set of syscalls for both (n)64
> > > and n32.  The address crop for n32 may be handled the Alpha way.  I will
> > > investigate the topic soon.
> >
> > Can you describe how this is handled on the  Alpha?
>
>  I'm referring mostly to OSF/1 here as it was first to implement it.
> Linux followed it in the sense it is able to execute OSF/1 binaries marked
> as "32-bit", but native ELF binaries used to be fully 64-bit always.  I
> think by a popular demand GNU binutils are now able to create "cropped"
> Alpha/Linux ELF binaries as well, but this is unverified for sure.  The
> implementation is two-fold.
>
>  First, the static linker (if given the "-taso" option) maps an executable
> into the low 31-bit address space (coincidentally, this will probably be
> suitable for MIPS as well) and sets a special flag in the executable (it
> does it in a weird place, but this is ECOFF and we have suitable flags in
> the ELF header already).
>
>  Second, seeing the "31-bit" flag set, the kernel returns any maps
> requested within the low 31-bit address space.  This way both shared
> libraries (which thus need not be special, i.e. may be regular 64-bit
> ones) and areas allocated by mmap() are addressable by the executable.
>
>  To summarize, nothing much complicated.
>
> > The primary problem is the differnet calling sequence for o32 and N64.
>
>  But we handle that already.
>
> > As it looks we'll be able to use either the o32 function or the native
> > syscall to implement all of the necessary N32 syscalls.
>
>  The (n)64 versions seem suitable and the o32 ones do not as n32 only
> crops addresses to 32-bit -- data may still be 64-bit (e.g. file position
> pointers).
>

Please notice, that a 'long' is 32-bit for n32, so we need to do the same
conversion for a lot of syscalls, as we already do for o32.


>
> > The question is if we want to reserve another 1000 entries in our already
> > huge syscall table for N32 or if we got a better solution ...
>
>  Aaarrgh, no more entries, please...
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
