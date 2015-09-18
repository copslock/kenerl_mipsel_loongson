Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2015 18:56:27 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27013698AbbIRQ4YyKRoJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2015 18:56:24 +0200
Date:   Fri, 18 Sep 2015 17:56:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Luis Machado <lgustavo@codesourcery.com>
cc:     gdb-patches@sourceware.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
In-Reply-To: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com>
Message-ID: <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org>
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49236
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

Hi Luis,

> I tracked this down to the lack of a proper definition of what MIPS' kernel
> returns in the si_code for a software breakpoint trap.
> 
> Though i did not find documentation about this, tests showed that we should
> check for SI_KERNEL, just like i386. I've cc-ed Maciej, just to be sure this
> is indeed correct.

 Hmm, the MIPS/Linux port does not set any particular code for SIGTRAP, 
all such signals will have the SI_KERNEL default, so you may well return 
TRUE unconditionally.

 I'm not convinced however that it is safe to assume all SIGTRAPs come 
from breakpoints -- this signal is sent by the kernel for both BREAK and 
trap (multiple mnemonics, e.g. TEQ, TGEI, etc.) instructions which may 
have been placed throughout code for some reason, for example to serve as 
cheap assertion checks.

 Is there a separate check made afterwards like `bpstat_explains_signal' 
to validate the source of the signal here?

 Perhaps we should make it a part of the ABI and teach MIPS/Linux about 
the breakpoint encoding used by GDB, which is `BREAK 5' (aka BRK_SSTEPBP 
in kernel-speak, a misnomer I'm afraid), and make it set `si_code' to 
TRAP_BRKPT, as expected.  This won't fix history of course, but at least 
it will make debugging a little bit easier to handle in the future.  
Cc-ing `linux-mips' for further input.

 I was wondering where these SIGTRAPs come from too BTW, thanks for 
investigating it.  And thanks for the heads-up!

  Maciej
