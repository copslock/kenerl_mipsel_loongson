Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 10:38:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50048 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028767AbcEUIiLNOTdn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 10:38:11 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 8725A37C43635;
        Sat, 21 May 2016 09:38:02 +0100 (IST)
Received: from [10.20.78.16] (10.20.78.16) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Sat, 21 May 2016
 09:38:04 +0100
Date:   Sat, 21 May 2016 09:37:55 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/5] MIPS: Simplify DSP instruction encoding macros
In-Reply-To: <7CA8BFBF-73A8-4699-975E-79BDC383C2E4@imgtec.com>
Message-ID: <alpine.DEB.2.00.1605210844150.6794@tp.orcam.me.uk>
References: <1463783321-24442-1-git-send-email-james.hogan@imgtec.com> <1463783321-24442-6-git-send-email-james.hogan@imgtec.com> <alpine.DEB.2.00.1605210742260.6794@tp.orcam.me.uk> <7CA8BFBF-73A8-4699-975E-79BDC383C2E4@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.16]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53575
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

On Sat, 21 May 2016, James Hogan wrote:

> >More importantly the use of `.insn' prevents execution from going
> >astray 
> >if there's a label being jumped to at the handcoded instruction.
> 
> Right. in my builds i couldn't find any examples of this happening, only 
> relative branches (the only diff when adding .insn seemed to be objdump 
> -d printing as microMIPS, but tbh i didn't compare data sections), but 
> perhaps it could still happen with a different configuration or 
> toolchain?

 It would have to be a JAL instruction (relaxed to JALX as necessary) or 
one of the register jumps.  The J instruction would cause an assembly or 
link error, depending on the symbol binding (a global or weak symbol may 
yet be preempted), as there's no way to switch modes with a direct jump.

 Branches however currently ignore the ISA bit, which I consider a bug, as 
it makes binutils silently produce broken code in regular MIPS and 
microMIPS interlinking if a branch target turns out to be the other ISA. 
Therefore I have a binutils patch in the works to correct this problem and 
make GAS and LD, as applicable, diagnose unsupported mode switches with 
branches and fail, but it will make `.insn' annotation even more necessary 
for handcoded machine code and other such odd cases.

 I would have actually pushed this change this week already if not for a 
microMIPS JALX encoding bug I've encountered, which would require me to 
write nonsensical code if not handled first.  That bug has now been fixed, 
so I expect to push said branch diagnostics sometime next week.  You may 
want try building with binutils master afterwards to see if any further 
cases of missing `.insn' annotation have been revealed.

 FAOD (of the other readers) none of this affects regular MIPS kernel 
builds.  It's all about microMIPS code, so there's no concern about 
toolchain compatibility with regular (classic) MIPS kernel configurations.

  Maciej
