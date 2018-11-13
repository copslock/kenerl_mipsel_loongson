Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 17:34:15 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993048AbeKMQdmj6ry9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 17:33:42 +0100
Date:   Tue, 13 Nov 2018 16:33:42 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 1/7] MIPS: Add support for the Lexra LX5280 CPU
In-Reply-To: <20181001102952.7913-2-yasha.che3@gmail.com>
Message-ID: <alpine.LFD.2.21.1811131513070.9637@eddie.linux-mips.org>
References: <20181001102952.7913-1-yasha.che3@gmail.com> <20181001102952.7913-2-yasha.che3@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67258
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

On Mon, 1 Oct 2018, Yasha Cherikovsky wrote:

> The Lexra LX5280 CPU [1][2] implements the MIPS-I ISA,
> without unaligned load/store instructions (lwl, lwr, swl, swr).

 I think you actually need to emulate these missing instructions for user 
programs, so that the 32-bit MIPS psABI is supported and standard software 
can run unmodified.  There'll be a performance hit and software will best 
be recompiled for the limited instruction set provided by actual hardware, 
however rebuilding is not always possible or feasible (also handcoded 
assembly may require actual reimplementation here and there).

> - RDHWR instruction emulation from the page fault handler
>   (more details in a code comment)

 The details are lacking I am afraid and I think it would be good to have 
them provided for long-term support to be feasible.

 First, the MIPS architecture does not have a single "page fault" 
exception.  There are three MMU exception codes defined: Mod, TLBL and 
TLBS, and also two vectors, either the TLB Refill or the General 
Exception.  So please be specific which of those are taken by the LX5280 
with the RDHWR instruction.

 Second, please explain why this MMU exception happens, i.e. does the CPU 
decode the SPECIAL3 major opcode as an I-Type memory access instruction, 
and then faults on `GPR[0] + offset' pointing to an unmapped page?

 If documentation is publicly available this information can be inferred 
from, then please provide a reference; otherwise please just describe the 
observed behaviour as you know it.

  Maciej
