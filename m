Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 17:50:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53126 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012309AbbA3QutYDRso (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 17:50:49 +0100
Date:   Fri, 30 Jan 2015 16:50:49 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Makefile: Set correct ISA level for MIPS
 ASEs
In-Reply-To: <54CBB0D4.1040506@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501301638050.28301@eddie.linux-mips.org>
References: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501301606470.28301@eddie.linux-mips.org> <54CBB0D4.1040506@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45584
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

On Fri, 30 Jan 2015, Markos Chandras wrote:

> >>  cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
> >>  				   -fno-omit-frame-pointer
> >>  
> >>  ifeq ($(CONFIG_CPU_HAS_MSA),y)
> >> -toolchain-msa	:= $(call cc-option-yn,-mhard-float -mfp64
> -Wa$(comma)-mmsa)
> >> +toolchain-msa	:= $(call cc-option-yn,-march=mips32r2 -mhard-float
> -mfp64 -Wa$(comma)-mmsa)
> >>  cflags-$(toolchain-msa)		+= -DTOOLCHAIN_SUPPORTS_MSA
> >>  endif
> > 
> >  Similarly here, is CPU_HAS_MSA incompatible with `-march=mips64r2'?
> I am not sure but like I explained above, it does not have to be 100%
> accurate. Just something to keep your toolchain happy and really enable
> MSA support even if you happen and old ISA level as the default one for
> your toolchain.
> 
> for example, if your toolchain has -march=mips2 as default then
> 
> -mhard-float -mfp64 will fail
> 
> but
> 
> -march=mips32r2 -mhard-float -mfp64
> 
> will pass. Your toolchain does support MSA, but because you combined the
> check with incompatible flags, then the end result is not what you want.

 Hmm doesn't `cc-option-yn' pull options accumulated in $(cflags-y) 
already for the check it makes?  If not, then it's rather less than useful 
for us and I can see two options here:

1. Find or make a version of the function that does.

2. Find or make a version of the function that takes extra options used 
   for the duration of the check only and not propagated to its output.

I think the latter option might be a bit better as we can choose a set of 
options that guarantees success with a sufficiently modern toolchain so 
that the option intended is included regardless of any configuration fault 
elsewhere, that will then likely manifest itself loudly rather than 
lingering unnoticed and possibly only causing issues at the run time.

  Maciej
