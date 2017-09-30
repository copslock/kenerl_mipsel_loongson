Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Sep 2017 08:57:16 +0200 (CEST)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:57318 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdI3G5J2j05R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Sep 2017 08:57:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 397B63F64F;
        Sat, 30 Sep 2017 08:57:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zq1vWDoWqaZg; Sat, 30 Sep 2017 08:57:01 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A74573F3AA;
        Sat, 30 Sep 2017 08:56:56 +0200 (CEST)
Date:   Sat, 30 Sep 2017 08:56:55 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170930065654.GA7714@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
 <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60209
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

> > Hmm... What about a 32-bit kernel and bits 63:32 sign-extended by kernel
> > instructions? LONG_{L,S} saves/restores 31:0 using LW/SW thus 63:32 will
> > be lost in exceptions?
> 
>  You mean for use with MMI instructions?  Offhand I think we have two 
> options:
> 
> 1. Declaring the lack of support for MMI instructions in o32 software.
> 
> 2. Switching to using LD/SD in <asm/stackframe.h> and preserving statics 
>    across syscalls with SAVE_STATIC/RESTORE_STATIC at the cost of
>    performance loss.
> 
> I'm open for a better suggestion though.  I propose that we start with #1, 
> as the zero performance cost and zero effort solution.

Sure. I would eventually like to explore solutions to efficiently support
the full register range in applications with both 32- and 64-bit kernels.

> > BusyBox at
> > 
> > https://packages.debian.org/stretch/mipsel/busybox-static/download
> > 
> > seemed appropriate but yields "illegal instruction" which I suppose is
> > interesting in itself. My MIPS toolchain is somewhat limited at the moment
> > so I will need to get back on this.
> 
>  Getting a core dump and using it to figure out which specific instruction 
> caused the exception would be interesting.

It's 72308802 as in "mul s1,s1,s0" which I believe is the DSP enhancement
multiplication with register write in the MIPS32 architecture. The R5900
doesn't have those DSP instructions, as far as I can tell.

For this reason the R5900 patch modifies the __{save,restore}_dsp macros,
mips_dsp_state::dspcontrol, DSP_INIT, sigcontext32::sc_dsp, etc. I've seen
the cpu_has_dsp macro too, but haven't looked at the details of this yet.

Considering the lack of DSP instructions, would you know any commonly
compiled mipsel distribution that could be made compatible with the R5900
in a reasonable manner? I suppose Gentoo has an advantage here, given the
ability to supply R5900 compilation flags.

> Also make sure you have RDHWR instruction emulation in place for CP0
> UserLocal register access.

Right. Debian's BusyBox has 857 of those. Jürgen Urban observed in the
conversation with you in

https://gcc.gnu.org/ml/gcc-patches/2013-01/msg00658.html

that RDHWR has the same encoding as "sq v1,-6085(zero)" for the R5900,
which luckily always gives an alignment exception so that the kernel is
able to emulate RDHWR properly. I haven't verified this though.

Fredrik
