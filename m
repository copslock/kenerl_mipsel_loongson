Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 19:33:52 +0200 (CEST)
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47903 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995047AbdH2Rdnzf36E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 19:33:43 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1B1B43F36B;
        Tue, 29 Aug 2017 19:33:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id exrBbNsNR3MU; Tue, 29 Aug 2017 19:33:26 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 09BA33F34B;
        Tue, 29 Aug 2017 19:33:21 +0200 (CEST)
Date:   Tue, 29 Aug 2017 19:33:18 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add basic R5900 support
Message-ID: <20170829173318.GA2130@localhost.localdomain>
References: <20170827132309.GA32166@localhost.localdomain>
 <20170828135305.GA20466@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170828135305.GA20466@linux-mips.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

On Mon, Aug 28, 2017 at 03:53:05PM +0200, Ralf Baechle wrote:
> Patch is looking perfect at a glance but without support for an R5900
> system that is the PS2 it kinda pointless so I'd like to wait and
> review and apply everything at once.

Thanks for your quick feedback! Everything else is here:

https://github.com/frno7/linux/tree/ps2-v4.12-squashed

This is GPL work by Sony, Jürgen Urban, Rick Gaiser, and others. About 40000
lines of code with drivers etc. and unpostable in current form. I've updated
it from 2.6.35 to 4.12 and it's running with workarounds and a few reverts.
I believe the patch can be improved in several areas. Some notes:

- The R5900 has 128 bit registers. In the patch this is implemented by
  replacing __u64 pt_regs::regs[32] with r5900_reg_t { __u64 lo, hi; }, and
  consequently replacing all 300+ register reads and writes with macros such
  as MIPS_READ_REG, MIPS_WRITE_REG, etc. Perhaps a less intrusive way is to
  store the most significant 64 bits separately and only use the least 64 bits
  in the rest of the kernel, without modification?
- MFC0/MTC0 and a few other instructions need additional SYNC. The patch uses
  ifdefs but perhaps macros are better? (See p. C-28 in TX79 Core Architecture
  manual by Toshiba, for example.)
- A new SYNC.P instruction is added to arch/mips/mm/uasm-mips.c.
- According to the same manual, the "first two instructions in an exception
  handler are executed as NOP when a bus error occurs (FLX05)" with the
  corrective measure to "place NOP in the first two instruction locations in
  all exception handlers" (p. 1-11).
- The memcpy/strlen/etc. family of functions need short loop NOP padding to
  avoid hardware bugs. Perhaps it's less fragile to rely on the compiler and
  use C implementations instead of assembly for R5900?
- A few other places apparently also need NOP padding.
- I'm unusure about arch/mips/kernel/scall32-n32.S.
- LL, SC, LLD and SCD etc. are not implemented in R5900 and are emulated.
- FPU needs special save/restore.
- arch/mips/include/asm/r4kcache.h is modified with special cache macros.
- arch/mips/mm/tlbex.c is updated with scratch pad memory map.
- The USB driver in the patch broke on 6f65126c7 "USB: OHCI: add SG support"
  and 6894258ed "dma-mapping: consolidate dma_{alloc,free}_{attrs,coherent}".
- The patch also broke on a6335fa1 "MIPS: bootmem: Don't use memory holes for
  page bitmap", as well as 084a7cf7 "MIPS: IRQ Stack: Unwind IRQ stack onto
  task stack".
- One should look at the 2.6.35 patch series to make sense of some of the
  changes in this updated patch. These parts need to be reworked, of course.

That's a start and some design choices need to be made to continue. What are
your thoughts?

Fredrik
