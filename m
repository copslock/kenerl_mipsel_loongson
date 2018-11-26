Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 21:46:09 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993069AbeKZUpoLiMCZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 21:45:44 +0100
Date:   Mon, 26 Nov 2018 20:45:44 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: Re: [PATCH 2/7] MIPS: Remove unused PIC macros
In-Reply-To: <20181126181718.ub4djz3x2dyffy7m@pburton-laptop>
Message-ID: <alpine.LFD.2.21.1811262029480.29116@eddie.linux-mips.org>
References: <20181015183304.16782-1-paul.burton@mips.com> <20181015183304.16782-3-paul.burton@mips.com> <alpine.LFD.2.21.1811221608260.22145@eddie.linux-mips.org> <20181126181718.ub4djz3x2dyffy7m@pburton-laptop>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67518
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

Hi Paul,

> In today's reality though the macros are dead code, we never do
> synchronize the header with anything external, and I doubt anyone
> looking to work on the kernel will start by reading the IDT MIPS
> Microprocessor Family Software Reference Manual. If, bizarrely, someone
> did that & got stuck because these macros aren't defined then I suspect
> it would be among the least of their problems.

 Sure, I have no problem to see these go nowadays, my reply was merely 
informational.

 In the 1990s and the libc 5 era (let alone a.out libc 4) user headers 
were mostly missing for Linux kernel interfaces and there was much higher 
reliance on <asm/foo.h> stuff (and pain with namespace clashes and other 
anomalies, the much more recent UAPI effort has meant to address) in the 
userland, so it was reasonable to have stuff included in a single header 
that would not only serve the kernel, but userland as well.

 I believe glibc 2 (aka libc 6) has imported their version of <sys/asm.h> 
directly from our <asm/asm.h> back in 1997, some 3 years after our port's 
creation.

  Maciej
