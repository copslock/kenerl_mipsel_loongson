Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 21:32:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58255 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008059AbaLDUcYnI91q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 21:32:24 +0100
Date:   Thu, 4 Dec 2014 20:32:24 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, Zubair.Kakakhel@imgtec.com,
        geert+renesas@glider.be, peterz@infradead.org,
        paul.gortmaker@windriver.com, chenhc@lemote.com, cl@linux.com,
        Ingo Molnar <mingo@kernel.org>, richard@nod.at,
        zajec5@gmail.com, james.hogan@imgtec.com, keescook@chromium.org,
        tj@kernel.org, alex@alex-smith.me.uk, pbonzini@redhat.com,
        blogic@openwrt.org, paul.burton@imgtec.com, qais.yousef@imgtec.com,
        linux-kernel@vger.kernel.org, markos.chandras@imgtec.com,
        dengcheng.zhu@imgtec.com, manuel.lauss@gmail.com,
        lars.persson@axis.com, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/3] MIPS: Add full ISA emulator.
In-Reply-To: <54809C88.8060601@caviumnetworks.com>
Message-ID: <alpine.LFD.2.11.1412042006560.22073@eddie.linux-mips.org>
References: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com> <1417650258-2811-3-git-send-email-ddaney.cavm@gmail.com> <547FA2E5.1040105@imgtec.com> <547FA8D2.2030703@caviumnetworks.com> <alpine.LFD.2.11.1412040310100.22073@eddie.linux-mips.org>
 <54809C88.8060601@caviumnetworks.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44578
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

On Thu, 4 Dec 2014, David Daney wrote:

> >   GAS will happily schedule any instruction into a branch delay slot as
> > long as the instruction is not architecturally forbidden there (e.g.
> > ERET), there is no data dependency with the branch that would affect the
> > result produced and the instruction is not an explicit exception trap
> > operation (BREAK, SYSCALL, TEQ, etc.).  For some reason, unknown to me all
> > MT ASE instructions are disallowed too.  Anything else -- free to go in!
> >
> >   Of course instructions can be scheduled into branch delay slots manually
> > too, in handcoded assembly, and that has to continue working.
> >
> 
> It is not difficult to also emulate the trapping instructions.  In order to
> move forward, I will implement the trapping instructions in my emulator for
> the next patch.

 I'd be more concerned about getting the more exotic instructions or cases 
right (did you get MADDU right for SmartMIPS processors and set the ACX 
register on them?) -- how do you propose to validate and regression-test 
the emulator in a reproducible manner?

 The combination of the rare case of an instruction being placed in an FP 
branch delay slot and the rarity of some instructions themselves makes me 
scared of bugs lurking there forever and occasionally biting people -- who 
may not be aware that software emulation is involved let alone be capable 
to track them down -- in the most frustrating way.  To say nothing of the 
infinite amount of effort to maintain the emulator associated with adding 
architectural and vendor-specific instructions.  See how much effort has 
been put into QEMU and still it does not get all the MIPS instruction set 
bits right.

  Maciej
