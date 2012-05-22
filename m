Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 00:12:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47956 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903704Ab2EVWMT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2012 00:12:19 +0200
Date:   Tue, 22 May 2012 23:12:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Deng-Cheng Zhu <dczhu@mips.com>
cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        kevink@paralogos.com
Subject: Re: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP)
 functionalities
In-Reply-To: <4FBB3AD2.1040802@mips.com>
Message-ID: <alpine.LFD.2.00.1205222251580.3701@eddie.linux-mips.org>
References: <1337244680-29968-1-git-send-email-dczhu@mips.com> <1337244680-29968-2-git-send-email-dczhu@mips.com> <4FB4EF81.10005@phrozen.org> <4FB60403.3080700@mips.com> <4FB68FA2.1030404@phrozen.org> <alpine.LFD.2.00.1205202231400.3701@eddie.linux-mips.org>
 <4FB9B52F.908@mips.com> <alpine.LFD.2.00.1205212350070.3701@eddie.linux-mips.org> <4FBB3AD2.1040802@mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 22 May 2012, Deng-Cheng Zhu wrote:

> >   Hmm, there's nothing platform-specific there, the file is pretty generic,
> > it could be moved to arch/mips/kernel/ or thereabouts.  That applies to
> > <asm/mips-boards/launch.h>  too, before you ask
> 
> Yeah, agree with you. I didn't do it simply because I'm not sure :)

 I can see you've copied the whole contents over to arch/mips/kernel/vpe.c 
now.  Please don't do that.  This code is modular for a reason.  Either 
modify original code to suit your needs while preserving functionality or, 
if infeasible, copy it over to a new module selected based on 
configuration.  Common parts should be abstracted and extracted to a 
common dependency, either a shared header or another module, as 
applicable.

> > (you may want to use alloc_bootmem or suchlike instead of hardcoding the
> > trampoline page, though it's probably pretty safe to assume the end of
> > the exception handler page is available everywhere).
> 
> I'm not quite clear about this. Do you mean to bypass the arbitrary monitor
> in vpe_run() (in other words, to directly bring up the vpe in vpe_run())?
> Why do we need to worry about writing to the cpulaunch data?

 The location of RAM is platform-specific, CKSEG0ADDR mustn't be used to 
"allocate" kernel memory.  But as I say the exception handlers' page is 
generally pretty safe, although the addition of the CP0 EBase register to 
the architecture stopped it being guaranteed at one point.

 Ultimately I think this memory should be properly allocated, but this is 
preexisting code, so there is no requirement that you fix that on this 
occasion (or at all), unless you'd really like to.

> >   There's nothing platform-specific referred to from arch/mips/kernel/vpe.c
> > AFAICT (and I trust in Beth having got this piece right).  I reckon it
> > used to work with CONFIG_MIPS_SIM too, though I could imagine the
> > configuration got neglected a bit as it is somewhat unusual.
> 
> Oh, When I said IRQ related stuff I meant the interrupt specific changes in
> rtlx.c (not vpe.c) which correspond to those in malta-int.c. They are
> there to resolve some issues (Please refer to the code changes and added
> comments in these 2 files in PATCH #1 and #2.).

 I still can't see anything platform-specific in rtlx.c (also written by 
Beth, BTW) -- it's all software interrupts that are architectural.  What 
pieces of code and comments are you specifically referring to?

 Also in some places you do stuff like:

#ifdef CONFIG_MIPS_CMP
int foo(void)
{
[something...]
}
#else
int foo(void)
{
[something else...]
}
#endif

Please don't.  Again these pieces should be separate modules selected by 
configuration, e.g. rtlx.c, rtlx-mt.c and rtlx-cmp.c with the former 
holding the common stuff, and the two latters non-CMP- and CMP-specific 
pieces, respectively (assuming that they are mutually exclusive and can't 
be enabled both at a time in a single kernel binary for some reason).

 It may make sense to move this whole stuff to a subdirectory at one 
point.

  Maciej
