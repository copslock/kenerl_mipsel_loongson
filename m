Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:06:40 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44806 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825733AbaA0UGiqcbDu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:06:38 +0100
Date:   Mon, 27 Jan 2014 20:06:07 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 15/15] mips: save/restore MSA context around signals
Message-ID: <20140127200607.GM970@pburton-linux.le.imgtec.org>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
 <1390836194-26286-16-git-send-email-paul.burton@imgtec.com>
 <52E6B887.2070605@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <52E6B887.2070605@gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_06_08
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Mon, Jan 27, 2014 at 11:50:31AM -0800, David Daney wrote:
> ....
> On 01/27/2014 07:23 AM, Paul Burton wrote:
> >This patch extends sigcontext in order to hold the most significant 64
> >bits of each vector register in addition to the MSA control & status
> >register. The least significant 64 bits are already saved as the scalar
> >FP context. This makes things a little awkward since the least & most
> >significant 64 bits of each vector register are not contiguous in
> >memory. Thus the copy_u & insert instructions are used to transfer the
> >values of the most significant 64 bits via GP registers.
> >
> 
> Interesting.
> 
> This very much touches the userspace ABI of the kernel, so it merits very
> careful consideration.
> 

Absolutely :)

> 
> >Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >---
> >  arch/mips/include/asm/sigcontext.h      |   2 +
> >  arch/mips/include/uapi/asm/sigcontext.h |   8 ++
> >  arch/mips/kernel/asm-offsets.c          |   3 +
> >  arch/mips/kernel/r4k_fpu.S              | 213 ++++++++++++++++++++++++++++++++
> >  arch/mips/kernel/signal.c               |  71 +++++++++--
> >  arch/mips/kernel/signal32.c             |  71 +++++++++--
> >  6 files changed, 352 insertions(+), 16 deletions(-)
> >
> [...]
> >diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
> >index 6c9906f..681c176 100644
> >--- a/arch/mips/include/uapi/asm/sigcontext.h
> >+++ b/arch/mips/include/uapi/asm/sigcontext.h
> >@@ -12,6 +12,10 @@
> >  #include <linux/types.h>
> >  #include <asm/sgidefs.h>
> >
> >+/* Bits which may be set in sc_used_math */
> >+#define USEDMATH_FP	(1 << 0)
> >+#define USEDMATH_MSA	(1 << 1)
> >+
> 
> How is this going to interact with existing userspace applications?
> 
> Is the current behavior to use / manipulate sc_used_math?
> 
> How will USEDMATH_MSA interact with existing code?
> 

My belief is that since previously sc_used_math was either 0 or 1, any
code using this is likely to simply check for it being non-zero and
continue to work just fine. The only issue would be if code explicitly
checks for sc_used_math==1. Even then it's only an issue if your program
also uses MSA, so there should certainly be no issue with old binaries.
If you can think of or find any uses of sc_used_math which would cause a
problem please do let me know.

Thanks,
    Paul
