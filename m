Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 20:38:32 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:43488 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992923AbeBQTiZ1MiuG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 20:38:25 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 19:38:17 +0000
Received: from [10.20.78.31] (10.20.78.31) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018 11:33:44 -0800
Date:   Sat, 17 Feb 2018 19:33:35 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [RFC] MIPS: R5900: Workaround for saving and restoring FPU
 registers
In-Reply-To: <20180217174715.GD2496@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1802171900360.3553@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk> <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain> <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk> <20180217144346.GC2496@localhost.localdomain> <alpine.DEB.2.00.1802171504320.3553@tp.orcam.me.uk>
 <20180217174715.GD2496@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1518896297-452059-7116-93780-1
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190133
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

> >  I thought we agreed the R5900 FPU is unusable for regular Linux software 
> > and decided to go for full FPU emulation unconditionally.
> 
> Yes, that's true, we are in agreement. I was unaware that the FPU emulation
> was complete enough to cover all registers (not only a set of instructions).
> Sorry about that. I will simply remove this patch then.

 The MIPS/Linux user ABI specifies a full architectural FPU, so not only 
we have to handle cases missing from hardware that cause an Unimplemented 
Operation exception, such as commonly operations on denormals, but (having 
not chosen, many years ago, to have the emulator in the userland) we have 
to emulate the whole FPU as well, for processors that do not have the unit 
at all.  We are accurate enough even to throw SIGILL for otherwise handled
FP instructions that are however supposed to be missing at the ISA level 
implemented by the CPU we are currently running on.

 We emulate a double unit, so operations on both double and single 
floating-point data types as well as corresponding fixed-point data types 
are supported.  We do not emulate extra stuff though, such as operations 
on the paired single data type or MIPS-3D instructions.  You have to 
access real FPU hardware to use them (and then you're in trouble if they 
cause an Unimplemented Operation exception).  It would be nice if someone 
contributed the missing bits.

> >  Etc. -- can you reuse MIPS I code here, i.e. use S.D?  GAS should be 
> > doing the right thing with `-march=r5900' (if not, then it has a bug).
> 
> Possibly, I am somewhat unfamiliar with this area. So let's revisit this FPU
> issue after the initial submission.

 Have a look at arch/mips/kernel/r2300_fpu.S; L.D and S.D are GAS macros 
which, depending on the architecture selected, expand to either LDC1 and 
SDC1 instructions or LWC1 and SWC1 instruction pairs, correctly ordered 
according to the endianness selected.  You can probably use that file as 
it stands for the R5900 FPU, when you get to it.

  Maciej
