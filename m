Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2017 11:05:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1350 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990434AbdJBJFYWt27s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Oct 2017 11:05:24 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4AA4C8C0C9523;
        Mon,  2 Oct 2017 10:05:14 +0100 (IST)
Received: from [10.20.78.129] (10.20.78.129) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Mon, 2 Oct 2017
 10:05:15 +0100
Date:   Mon, 2 Oct 2017 10:05:02 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20170930065654.GA7714@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
References: <20170911151737.GA2265@localhost.localdomain> <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk> <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk> <20170920145440.GB9255@localhost.localdomain> <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk> <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.20.78.129]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Hi Fredrik,

> >  Getting a core dump and using it to figure out which specific instruction 
> > caused the exception would be interesting.
> 
> It's 72308802 as in "mul s1,s1,s0" which I believe is the DSP enhancement
> multiplication with register write in the MIPS32 architecture. The R5900
> doesn't have those DSP instructions, as far as I can tell.

 Umm, has Debian switched to MIPS32 as the base architecture?  That would 
be unfortunate, they used to support MIPS I or at worst MIPS II (ISTR 
voices to switch to the latter).  There's still plenty of MIPS III 
hardware around so for 32-bit support I would consider MIPS II the common 
denominator (the sole difference between MIPS II and MIPS III is 64-bit 
support).

 In any case you'll have to find a MIPS I or MIPS II distribution, like an 
older version of Debian.

 The three-argument MUL is a part of the base MIPS32 architecture BTW, 
originating from the IDT R4650 and the NEC Vr5500 processors.  It has 
nothing to do with the DSP ASE (though it may have been claimed originally 
to be a DSP enhancement).

> For this reason the R5900 patch modifies the __{save,restore}_dsp macros,
> mips_dsp_state::dspcontrol, DSP_INIT, sigcontext32::sc_dsp, etc. I've seen
> the cpu_has_dsp macro too, but haven't looked at the details of this yet.

 Given that the R5900 does not expand DSP support anyhow that sounds 
suspicious to me.

> Considering the lack of DSP instructions, would you know any commonly
> compiled mipsel distribution that could be made compatible with the R5900
> in a reasonable manner? I suppose Gentoo has an advantage here, given the
> ability to supply R5900 compilation flags.

 I don't know.  According to <https://www.debian.org/ports/mips/>:

"Debian GNU/Linux 8.9 supports the following machines:

  * SGI Indy with R4x00 and R5000 CPUs, and Indigo2 with R4400 CPU (IP22).
  * SGI O2 with R5000, R5200 and RM7000 CPU (IP32).
  * Broadcom BCM91250A (SWARM) evaluation board (big and little-endian).
  * MIPS Malta boards (big and little-endian, 32 and 64-bit).
  * Loongson 2e and 2f machines, including the Yeelong laptop (little-endian).
  * Loongson 3 machines (little-endian).
  * Cavium Octeon (big-endian).

In addition to the above machines, it is possible to use Debian on a lot 
more machines provided that a non-Debian kernel is used.  This is for 
example the case of the MIPS Creator Ci20 development board."

so your observation looks like a result of a package compilation bug in 
the program which crashed.  Among the systems listed above there are many 
which only support the MIPS III ISA (R4x00, R4400 and Loongson 2e CPUs) or 
the MIPS IV ISA (R5000, R5200, RM7000 CPUs).  I see the DECstation port 
along with R2000 and R3000 CPU support has been removed, so I gather the 
baseline is indeed supposed to be MIPS II.

 I haven't used Gentoo, but I'm told you can choose your compilation flags 
as you like with it.

> > Also make sure you have RDHWR instruction emulation in place for CP0
> > UserLocal register access.
> 
> Right. Debian's BusyBox has 857 of those. Jürgen Urban observed in the
> conversation with you in
> 
> https://gcc.gnu.org/ml/gcc-patches/2013-01/msg00658.html
> 
> that RDHWR has the same encoding as "sq v1,-6085(zero)" for the R5900,
> which luckily always gives an alignment exception so that the kernel is
> able to emulate RDHWR properly. I haven't verified this though.

 That instruction encoding (actually implemented by some MIPS32r2/MIPS64r2 
and newer hardware) is used under Linux for Thread Local Storage (TLS) 
access.  For hardware that does not have it the instruction is emulated in 
the Reserved Instruction (RI) exception handler, but obviously not the 
Address Error Store (AdES) exception.  So code to handle it as a special 
case with the R5900 has to be provided among the patches (and included 
with the initial series).

 Note that `rdhwr $3,$29' is the usual encoding, handled by a fastpath in 
arch/mips/kernel/genex.S (see `handle_ri_rdhwr'), however all `rt' 
encodings (covered in `simulate_rdhwr' in arch/mips/kernel/traps.c) have 
to be handled for completeness.  Fortunately RDHWR and SQ both use the 
same bits for `rt', and the `-6085(zero)' encoding of the memory reference 
makes no sense, so we can safely rely on the AdES exception.

  Maciej
