Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2012 01:56:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37626 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903671Ab2G3X4y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2012 01:56:54 +0200
Date:   Tue, 31 Jul 2012 00:56:54 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     =?ISO-8859-15?Q?Llu=EDs_Batlle_i_Rossell?= <viric@viric.name>
cc:     linux-mips@linux-mips.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH] MIPS: Add emulation for fpureg-mem unaligned access
In-Reply-To: <20120730194754.GA25996@vicerveza.homeunix.net>
Message-ID: <alpine.LFD.2.00.1207310032520.1586@eddie.linux-mips.org>
References: <20120615234641.6938B58FE7C@mail.viric.name> <CAOiHx==JS9KfPWxx+pyRNwvq-pWdhbZk+Q-qvRPsVGh90Xso9Q@mail.gmail.com> <20120616121513.GP2039@vicerveza.homeunix.net> <20120616124001.GQ2039@vicerveza.homeunix.net> <20120620190545.GV2039@vicerveza.homeunix.net>
 <alpine.LFD.2.00.1207090122240.12288@eddie.linux-mips.org> <20120730194754.GA25996@vicerveza.homeunix.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 34003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Lluís

> >  I suggest that for 32-bit kernels you simply reuse the existing snippets 
> > from that function and handle ldc1/sdc1 with a pair of lwl/ldr or swl/swr 
> > pairs ordered as appropriate for the endianness selected -- that should be 
> > fairly easy.
> 
> Hm I still don't understand well enough how to do that. Would I need to get some
> aligned memory (a stack automatic variable for example), copy the double word
> there with proper endianness, and then call again ldc1? (similar for sdc1)

 No need to copy anything to scratch space, you'd just handle the thing 
piecewise in 32-bit chunks, transferring one FPR first, followed with the 
other one -- this is exactly what LDC1/SDC1 logically do in the 32-bit 
mode anyway.  Of course FPR indices are swapped between endiannesses (or 
data in memory is swapped -- depending on how you look at it).

> >  Also regardless of that, please make sure that your code handles the two 
> > possible settings of CP0 Status register's bit FR correctly, as the 32-bit 
> > halves of floating-point data are distributed differently across 
> > floating-point registers based on this bit's setting (check if an o32 and 
> > an n64 or n32 program gets these values right).
> 
> Hm I'm failing to find in the mips-iv.pdf how to check that FR bit, although I
> see it mentioned there. Sorry.

 That'll be set in Linux's task status structure somewhere as the 
floating-point model is implied by the ABI (FR is clear for o32 and set 
for n32/n64) -- no need to poke at hardware.  Have a look at FP context 
switching code -- it has to take similar measures.  There may be some code 
that checks that in the FPU emulator as well.

> > > As Jonas reported, I think that maybe I should rework the patch for it to emit
> > > sigbus instead of sigill on ldc1,ldc1 for mips32. Do I understand it right?
> > 
> >  Have you checked your code against a non-FPU processor (or with the 
> > "nofpu" kernel option) too?
> 
> No. Would in that case the processor have the fpu disabled? I understand that
> the code path is called only in a particular case of 'unaligned access'
> exception.

 It may well possibly be, I'm not sure offhand, but unaligned access 
emulation just has to work the same for floating-point transfers 
regardless of whether the FPU has been enabled or is fully emulated.  
This just have to be verified.

 The MIPS/Linux user ABI specifies the presence of an FPU unconditionally 
and a missing or disabled unit is automatically emulated in software 
transparently (except for the performance loss of course).

  Maciej
