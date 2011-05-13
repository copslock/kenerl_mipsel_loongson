Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:54:39 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42870 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491855Ab1EMPyg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 17:54:36 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4DFu67Q010784;
        Fri, 13 May 2011 16:56:06 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4DFu5J9010782;
        Fri, 13 May 2011 16:56:05 +0100
Date:   Fri, 13 May 2011 16:56:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
Message-ID: <20110513155605.GA30674@linux-mips.org>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
 <20110513150707.GA26389@linux-mips.org>
 <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 08:46:18AM -0700, Kevin Cernekee wrote:

> >> On hardware that does not support RI/XI, EntryLo bits 31:30 / 63:62 will
> >> remain unset and RI/XI permissions will not be enforced.
> >
> > Nice idea but it breaks on 64-bit hardware running 32-bit kernels. �On
> > those the RI/XI bits written to c0_entrylo0/1 31:30 will be interpreted as
> > physical address bits 37:36.
> 
> Hmm, are you sure?  (Unfortunately I do not have a 64-bit machine to
> test it on.)
> 
> I did not touch David's existing build_update_entries(), which makes a
> point not to set the RI/XI bits when the RIXI feature is disabled:
> 
>         if (kernel_uses_smartmips_rixi) {
>                 UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_NO_EXEC));
>                 UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_NO_EXEC));
>                 UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL) -
> ilog2(_PAGE_NO_EXEC));
>                 if (r4k_250MHZhwbug())
>                         UASM_i_MTC0(p, 0, C0_ENTRYLO0);
>                 UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
>                 UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL) -
> ilog2(_PAGE_NO_EXEC));
>         } else {
>                 UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /*
> convert to entrylo0 */
>                 if (r4k_250MHZhwbug())
>                         UASM_i_MTC0(p, 0, C0_ENTRYLO0);
>                 UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
>                 UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_GLOBAL)); /*
> convert to entrylo1 */
>                 if (r45k_bvahwbug())
>                         uasm_i_mfc0(p, tmp, C0_INDEX);
>         }
> 
> If RIXI is enabled, it shifts the SW bits off the end of the register,
> then rotates the RI/XI bits into place.
> 
> If RIXI is disabled, it shifts the SW bits + RI/XI bits off the end of
> the register.  It should not be setting bits 31:30 or 63:62, ever.
> 
> (A side issue here is that ROTR is a MIPS R2 instruction, so we could
> never remove the old handler and use the RIXI version of the TLB
> handler on an R1 machine.)
> 
> If setting EntryLo bits 31:30 for RI/XI is illegal on a 64-bit system
> running a 32-bit kernel, I suspect we will have a problem with the
> existing RIXI TLB update code, regardless of whether my changes are
> applied.

I'm not totally certain with my explanation but it seemed like a good
working hypothesis.  Jayachandran C. bisected this morning's linux-queue
on his Netlogic XLR which is MIPS64 R1 and found this comment causing
the problem.

  Ralf
