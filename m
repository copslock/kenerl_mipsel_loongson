Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 17:19:27 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:9372 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIDPT0>; Wed, 4 Sep 2002 17:19:26 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA15360;
	Wed, 4 Sep 2002 17:19:51 +0200 (MET DST)
Date: Wed, 4 Sep 2002 17:19:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020904163101.C32519@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1020904170056.10619H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 78
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Ralf Baechle wrote:

> >  It would be nice if we could keep a single set of syscalls for both (n)64
> > and n32.  The address crop for n32 may be handled the Alpha way.  I will
> > investigate the topic soon.
> 
> Can you describe how this is handled on the  Alpha?

 I'm referring mostly to OSF/1 here as it was first to implement it. 
Linux followed it in the sense it is able to execute OSF/1 binaries marked
as "32-bit", but native ELF binaries used to be fully 64-bit always.  I
think by a popular demand GNU binutils are now able to create "cropped"
Alpha/Linux ELF binaries as well, but this is unverified for sure.  The
implementation is two-fold. 

 First, the static linker (if given the "-taso" option) maps an executable
into the low 31-bit address space (coincidentally, this will probably be
suitable for MIPS as well) and sets a special flag in the executable (it
does it in a weird place, but this is ECOFF and we have suitable flags in
the ELF header already).

 Second, seeing the "31-bit" flag set, the kernel returns any maps
requested within the low 31-bit address space.  This way both shared
libraries (which thus need not be special, i.e. may be regular 64-bit
ones) and areas allocated by mmap() are addressable by the executable.

 To summarize, nothing much complicated.

> The primary problem is the differnet calling sequence for o32 and N64.

 But we handle that already.

> As it looks we'll be able to use either the o32 function or the native
> syscall to implement all of the necessary N32 syscalls.

 The (n)64 versions seem suitable and the o32 ones do not as n32 only
crops addresses to 32-bit -- data may still be 64-bit (e.g. file position
pointers).

> The question is if we want to reserve another 1000 entries in our already
> huge syscall table for N32 or if we got a better solution ...

 Aaarrgh, no more entries, please...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
