Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 16:54:59 +0200 (CEST)
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:29685 "EHLO
        ste-ftg-msa2.bahnhof.se" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993938AbdITOyw3jbOK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 16:54:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTP id 8E8653F644;
        Wed, 20 Sep 2017 16:54:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-ftg-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nhoj3ZdYd-Cv; Wed, 20 Sep 2017 16:54:45 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-ftg-msa2.bahnhof.se (Postfix) with ESMTPA id 8A9D63F5E4;
        Wed, 20 Sep 2017 16:54:42 +0200 (CEST)
Date:   Wed, 20 Sep 2017 16:54:41 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170920145440.GB9255@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Maciej,

> > Given the R5900 patch I believe this can be done somewhat simpler, since
> > register access macros have been implemented in C (in this way the physical
> > registers become in some sense separated from the logical registers in the
> > kernel).
> > 
> > The transition from 128-bit registers to 64-bit registers was easy (in a
> > 32-bit kernel) by changing the LONGD_{L,S} macros in asm.h from quadword
> > {L,S}Q to doubleword {L,S}D instructions, and changing pt_regs::regs[32]
> > from r5900_reg_t to unsigned long long.
> 
>  But why did you have to change anything there in the first place?  All 
> that's there is generic stuff.

The 128-bit register save/restore infrastructure is part of the original
2.6.35 patch for R5900 support, that I ported to 4.12 and we're about to
disentangle. The original patch crashes similarly unless full 128-bit GPRs
are handled in 32-bit or 64-bit kernels, so this particular issue appears
to remain intact. Hopefully we will be able to figure out cause and fix.

> > (The patch replaces LONG_* with
> > three variants: LONGD_*, LONGH_* and LONGI_*. It also forces LD and SD
> > via a ".set push/.set mips3/.set pop" combination like you outline below.)
> 
>  I don't remember suggesting anything like that.

Well, I was referring to similar use of the .set pseudo-op.

> > The patch has full 64-bit registers accessible in C too, which is why I
> > propose to do the diagnostic consistency check in C. (Macros truncate to
> > 32 bits everywhere in the kernel except for save/restore.)
> 
>  You need to figure out the semantics of 128-bit registers and describe it 
> in details (to be provided in the relevant commit's description), in 
> particular any interaction 32-bit and 64-bit instructions have with the 
> upper 64-bit half, before we can accept any change to support these 
> extended registers.
>   
>  Barring evidence otherwise I think updating macros in <asm/asm.h> is not 
> enough, because our syscalls rely on the standard MIPS psABI's calling 
> convention and call-saved registers will only be saved and restored on an 
> as-needed basis, in the prologue/epilogue of any kernel's C functions that 
> actually use them.  And GCC will only use save and restore call-saved 
> registers using regular 32-bit or 64-bit operations, according to the ABI 
> the kernel has been compiled for.  So if there's a need to preserve the 
> upper 64-bit halves, then it has to be done explicitly, possibly in an 
> extra <asm/stackframe.h> macro.
> 
>  But all that is something for a later stage; right now I suggest that you 
> figure out what's causing registers to become clobbered and fix it there.

My thinking was simply that we could try to use the (already patched up)
128-bit infrastructure, that seems to work quite well, as a debug tool in
this particular case. I understand that merging it is another matter.

> > I'm using a BusyBox binary from the Debian-based Black Rhino distribution,
> > so I'm not entirely sure how it was compiled, and it might contain 64-bit
> > instructions that are not caught by the (unavailable) UX bit.
> 
>  Use `file' or `readelf -h' on the BusyBox binary to double-check the ABI 
> it has been built for.  Although I doubt there will be issues with the 
> executable, as it would crash on any of the other MIPS processors which 
> implement the 32-bit mode correctly.

As previously mentioned all binaries I've tested so far declare "ELF 32-bit
LSB, MIPS, MIPS-III version 1" with file. mipsel-linux-readelf says

ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x402d90
  Start of program headers:          52 (bytes into file)
  Start of section headers:          276156 (bytes into file)
  Flags:                             0x20920003, noreorder, pic, unknown CPU, mips3
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         7
  Size of section headers:           40 (bytes)
  Number of section headers:         25
  Section header string table index: 24

but it's unclear to me whether it's generic or somehow tailored for R5900.

Fredrik
