Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 01:17:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34994 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903648Ab2EUXRI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2012 01:17:08 +0200
Date:   Tue, 22 May 2012 00:17:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Deng-Cheng Zhu <dczhu@mips.com>
cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        kevink@paralogos.com
Subject: Re: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP)
 functionalities
In-Reply-To: <4FB9B52F.908@mips.com>
Message-ID: <alpine.LFD.2.00.1205212350070.3701@eddie.linux-mips.org>
References: <1337244680-29968-1-git-send-email-dczhu@mips.com> <1337244680-29968-2-git-send-email-dczhu@mips.com> <4FB4EF81.10005@phrozen.org> <4FB60403.3080700@mips.com> <4FB68FA2.1030404@phrozen.org> <alpine.LFD.2.00.1205202231400.3701@eddie.linux-mips.org>
 <4FB9B52F.908@mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 21 May 2012, Deng-Cheng Zhu wrote:

> >   What's so Malta-specific in the VPE loader anyway?  It's a CPU feature,
> > not a board-specific one.
> 
> Well, first off, for VPE loader itself, when it comes to CPS we have
> vpe_run() that derives from amon_cpu_start() in arch/mips/mti-malta/malta-
> amon.c. There is no implementation of amon_cpu_start() on other platforms.

 Hmm, there's nothing platform-specific there, the file is pretty generic, 
it could be moved to arch/mips/kernel/ or thereabouts.  That applies to 
<asm/mips-boards/launch.h> too, before you ask (you may want to use 
alloc_bootmem or suchlike instead of hardcoding the trampoline page, 
though it's probably pretty safe to assume the end of the exception 
handler page is available everywhere).

> Secondly, I suppose VPE loader works uniquely for APRP, and part of APRP
> (such as IRQ related stuff) depends on platform code. So it makes sense
> (IMO) to impose the dependency of APRP on the root (VPE loader).

 Hmm, does it really?  It sounds wrong to me, it shouldn't use any 
hardware interrupts, and software interrupts again are available 
everywhere, at least on the MT processors now in existence.

 There's nothing platform-specific referred to from arch/mips/kernel/vpe.c 
AFAICT (and I trust in Beth having got this piece right).  I reckon it 
used to work with CONFIG_MIPS_SIM too, though I could imagine the 
configuration got neglected a bit as it is somewhat unusual.

  Maciej
