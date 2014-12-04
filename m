Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 12:49:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56259 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007012AbaLDLt1vO950 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 12:49:27 +0100
Date:   Thu, 4 Dec 2014 11:49:27 +0000 (GMT)
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
In-Reply-To: <547FA8D2.2030703@caviumnetworks.com>
Message-ID: <alpine.LFD.2.11.1412040310100.22073@eddie.linux-mips.org>
References: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com> <1417650258-2811-3-git-send-email-ddaney.cavm@gmail.com> <547FA2E5.1040105@imgtec.com> <547FA8D2.2030703@caviumnetworks.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44576
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

On Wed, 3 Dec 2014, David Daney wrote:

> > but it doesn't support customized instructions,
> 
> GCC will never put these in the delay slot of a FPU branch, so it is not
> needed.
> 
> > multiple ASEs,
> 
> Same as above.  But any instructions that are deemed necessary can easily be
> added.

 GAS will happily schedule any instruction into a branch delay slot as 
long as the instruction is not architecturally forbidden there (e.g. 
ERET), there is no data dependency with the branch that would affect the 
result produced and the instruction is not an explicit exception trap 
operation (BREAK, SYSCALL, TEQ, etc.).  For some reason, unknown to me all 
MT ASE instructions are disallowed too.  Anything else -- free to go in!

 Of course instructions can be scheduled into branch delay slots manually 
too, in handcoded assembly, and that has to continue working.

  Maciej
