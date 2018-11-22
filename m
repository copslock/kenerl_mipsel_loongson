Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2018 17:31:20 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992492AbeKVQbN60Bwv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2018 17:31:13 +0100
Date:   Thu, 22 Nov 2018 16:31:13 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH 2/7] MIPS: Remove unused PIC macros
In-Reply-To: <20181015183304.16782-3-paul.burton@mips.com>
Message-ID: <alpine.LFD.2.21.1811221608260.22145@eddie.linux-mips.org>
References: <20181015183304.16782-1-paul.burton@mips.com> <20181015183304.16782-3-paul.burton@mips.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67457
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

On Mon, 15 Oct 2018, Paul Burton wrote:

> asm/asm.h contains CPRESTORE, CPADD & CPLOAD macros that are intended
> for use with position independent code, but are not used anywhere in the
> kernel - along with a comment to that effect. Remove the dead code.

 FYI, this was I believe for consistency with the <sys/asm.h> glibc header 
and in the days since lost in the mist to time may have actually been used 
by the userland too.

 Overall the contents of this header used to be somewhat standardised in a 
platform-independent way, e.g. the IDT MIPS software manual says[1]:

"Many toolchains supply a header file <asm.h>, which provides C-style 
macros to generate the appropriate directives, as required [...]"

and then goes on to use <idtc/asm.h> across the many snippets of code 
included throughout.

References:

[1] "IDT MIPS Microprocessor Family Software Reference Manual", Integrated 
    Device Technology, Inc., Version 2.0, October 1996, Chapter 9 
    "Assembler Language Programming", p. 9-17

[Yes, it did have a chapter on the MIPS assembly language, including the 
syntax, which some people confuse with the syntax architecture manuals use 
for the instruction set.]

  Maciej
