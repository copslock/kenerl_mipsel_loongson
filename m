Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 19:18:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60369 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007457AbbE1RSPtBm4v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 May 2015 19:18:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4SHIInL010683;
        Thu, 28 May 2015 19:18:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4SHII3l010682;
        Thu, 28 May 2015 19:18:18 +0200
Date:   Thu, 28 May 2015 19:18:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: strnlen_user.S: Fix a CPU_DADDI_WORKAROUNDS
 regression
Message-ID: <20150528171817.GD7012@linux-mips.org>
References: <alpine.LFD.2.11.1505271631400.21603@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1505271631400.21603@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, May 28, 2015 at 05:46:49PM +0100, Maciej W. Rozycki wrote:

> Correct a regression introduced with 8453eebd [MIPS: Fix strnlen_user() 
> return value in case of overlong strings.] causing assembler warnings 
> and broken code generated in __strnlen_kernel_nocheck_asm:
> 
> arch/mips/lib/strnlen_user.S: Assembler messages:
> arch/mips/lib/strnlen_user.S:64: Warning: Macro instruction expanded into multiple instructions in a branch delay slot
> 
> with the CPU_DADDI_WORKAROUNDS option set, resulting in the function 
> looping indefinitely upon mounting NFS root.
> 
> Use conditional assembly to avoid a microMIPS code size regression.  
> Using $at unconditionally would cause such a regression as there are no 
> 16-bit instruction encodings available for ALU operations using this 
> register.  Using $v1 unconditionally would produce short microMIPS 
> encodings, but would prevent this register from being used across calls 
> to this function.
> 
> The extra LI operation introduced is free, replacing a NOP originally 
> scheduled into the delay slot of the branch that follows.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> Ralf,
> 
>  The jump to the delay slot combined with the unusual register usage 
> convention taken here made it trickier than it would normally be to make a 
> fix that does not regress -- in terms of code size -- unaffected microMIPS 
> systems.  I tried several versions and eventually I came up with this one 
> that I believe produces the best code in all cases, at the cost of these 
> #ifdefs.  I hope they are acceptable.

I think it's all a hint to rewrite the thing in a language that
transparently handles the DADDIU issue.  Such as C.  Which would also
make using a better algorithm easier.

  Ralf
