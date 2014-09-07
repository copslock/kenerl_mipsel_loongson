Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Sep 2014 10:25:33 +0200 (CEST)
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:59024
        "EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007396AbaIGIZag5p86 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 7 Sep 2014 10:25:30 +0200
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
        by qmta06.westchester.pa.mail.comcast.net with comcast
        id o8RQ1o0011wpRvQ568RQdA; Sun, 07 Sep 2014 08:25:24 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta18.westchester.pa.mail.comcast.net with comcast
        id o8RP1o00G0JZ7Re3e8RQTX; Sun, 07 Sep 2014 08:25:24 +0000
Message-ID: <540C165F.7030307@gentoo.org>
Date:   Sun, 07 Sep 2014 04:25:03 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: gcc-4.8+ and R10000+
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1410078324;
        bh=/3ypfJRvXSIvqRFiS4Odl5lFScQgypAq2zwtYAnTwHY=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=jVZxJse0omCqv65Nl6xBSlZK3VlUJl5LUpZ5sQufnqZbSTtJpjAmczNItlRCeosL2
         YmH7W8JniZ7uUDMkjv9YFNY+Yni5jglzkJPV6tk4KVFDu7dtBGAuEmbOBoQ7AJwD7L
         wmWu7+3srBr5zchte2CUcNBcnqnm3BAG17OyL7/cZsb5WGbv5jrNsOvAV1as8tLOYT
         nJZoMipfyO2u69iScaEGvHDxM+UG05ufJuVvUCR8SamaatlAL87eEa7+lr1Jg+FBBr
         hsUNGMJOdQnVAGJeaOtepM2qBEgU6gmyo0HkDJwcSVeahTpy4UxeAqfu/5NNJfD6L1
         4ntSTkXSjPLkw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

I've been banging my head on the desk over gcc PR61538 [1] the last few
months, and talking to the gcc people, I went looking through the R10000
manual again to try and see if some kind of errata sticks out.  I found this
bit:

"""
Load Linked and Store Conditional instructions (LL, LLD,
SC, and SCD) do not implicitly perform SYNC operations in
the R10000.  Any of the following events that occur between
a Load Linked and a Store Conditional will cause the Store
Conditional to fail: an exception; execution of an ERET,
a load, a store, a SYNC, a CacheOp, a prefetch, or an
external intervention/invalidation on the block containing
the linked address. Instruction cache misses do not cause
the Store Conditional to fail.
"""

The regression happens inside glibc's __lll_lock_wait_private routine:

void
__lll_lock_wait_private (int *futex)
{
  if (*futex == 2)
    lll_futex_wait (futex, 2, LLL_PRIVATE);

  while (atomic_exchange_acq (futex, 2) != 0)
    lll_futex_wait (futex, 2, LLL_PRIVATE);
}

It appears to hang forever on the "atomic_exchange_acq" function call.

Disassembling a statically-built copy of the "sln" binary generated by
glibc's compile phase, there are slight differences in how gcc-4.7 and
gcc-4.8 are compiling the __lll_lock_wait_private function.  The key
differences in the output asm are
this:

gcc-4.7:
   x+4   <START>
         ...
   x+24  bne     v1,v0,<x+56>
         ...
   x+32  0x7c03e83b /* rdhwr */
   x+36  li      a2,2
   x+40  lw      a1,-29832(v1)
   x+44  move    a3,zero
   x+48  li      v0,4238
   x+52  syscall
*  x+56  li      v0,2
*  x+60  ll      v1,0(s0)
*  x+64  move    a0,v0
*  x+68  sc      a0,0(s0)
   x+72  beqzl   a0,<x+56>
   x+76  nop
   x+80  sync
   x+84  bnez    v1,<x+32>

gcc-4.8:
   x+4   <START>
         ...
   x+24  bne     v1,v0,<x+56>
         ...
   x+32  0x7c03e83b /* rdhwr */
   x+36  li      a2,2
   x+40  lw      a1,-29832(v1)
   x+44  move    a3,zero
   x+48  li      v0,4238
   x+52  syscall
*  x+56  ll      v0,0(s0)
*  x+60  li      at,2
*  x+64  sc      at,0
   x+68  beqzl   at,<x+56>
   x+72  nop
   x+76  sync
   x+80  bnez    v0,<x+32>

Using gdb, if I step through 'sln', the gcc-4.7 copy never calls
__lll_lock_wait_private, so I have no idea how the insns are being executed.
 But the 4.8 copy does get into this function, and stepping each instruction
at a time yields this execution path:

   x+4   <START>
         ...
   x+24  bne     v1,v0,<x+56>
   x+56  ll      v0,0(s0)
   x+68  beqzl   at,<x+56> /* beqzl check fails -> x+76 */
   x+76  sync
   x+80  bnez    v0,<x+32>
   x+32  0x7c03e83b /* rdhwr */
   x+36  li      a2,2
   x+40  lw      a1,-29832(v1)
   x+44  move    a3,zero
   x+48  li      v0,4238
   x+52  syscall
   x+56  ll      v0,0(s0)
   <HANG>

Executing the 'bnez' insn puts us at the rdhwr insn (x+32), then stepping
through, the 'syscall' (x+56) returns and leaves us at the 'll' a second
time, where the program just hangs.

I am guessing at a few things here:

- Because ll/sc are atomic, gdb doesn't let you step through them, which is
why the instruction pointer jumps over the 'li' and 'sc' insns.

- The 'li' after 'll' triggers the 'sc' to fail on R10K.

Does this look correct for an R10000, given the above statement from the
manual?  I'm not sure how or why this would cause the program to hang, but
it seems to directly correlate.

Anyone from Debian able to test building gcc-4.8 (or greater) and glibc-2.19
on an R10K system and see if it hangs at the end of glibc's compile phase
using the 'sln' binary to generate symlinks?  I've ran into this on R12000
and R14000 systems.  I am assuming it'll happen on an R10000 system as well.

1: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61538

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
