Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 14:33:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44840 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992571AbcITMdG6fTuH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Sep 2016 14:33:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8KCX2wI014077;
        Tue, 20 Sep 2016 14:33:02 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8KCX1rP014076;
        Tue, 20 Sep 2016 14:33:01 +0200
Date:   Tue, 20 Sep 2016 14:33:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: dec: Avoid la pseudo-instruction in delay slots
Message-ID: <20160920123301.GN5881@linux-mips.org>
References: <20160902141902.2478-1-paul.burton@imgtec.com>
 <alpine.LFD.2.20.1609192323450.19345@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1609192323450.19345@eddie.linux-mips.org>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55213
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

On Mon, Sep 19, 2016 at 11:30:25PM +0100, Maciej W. Rozycki wrote:

> > When expanding the la or dla pseudo-instruction in a delay slot the GNU
> > assembler will complain should the pseudo-instruction expand to multiple
> > actual instructions, since only the first of them will be in the delay
> > slot leading to the pseudo-instruction being only partially executed if
> > the branch is taken. Use of PTR_LA in the dec int-handler.S leads to
> > such warnings:
> > 
> >   arch/mips/dec/int-handler.S: Assembler messages:
> >   arch/mips/dec/int-handler.S:149: Warning: macro instruction expanded into multiple instructions in a branch delay slot
> >   arch/mips/dec/int-handler.S:198: Warning: macro instruction expanded into multiple instructions in a branch delay slot
> > 
> > Avoid this by placing nops in the delay slots of the affected branches,
> > leading to the PTR_LA macros being placed after the branches & their
> > delay slots. Although the nop isn't strictly needed, it's an
> > insignificant cost & satisfies the assembler easily with more
> > readable code than the possible alternative of manually expanding the
> > la/dla pseudo-instructions & placing the appropriate first instruction
> > into the delay slots.
> 
>  I take it it's a quest for a clean compilation with no warnings reported, 
> as the message is otherwise harmless and correct code is produced here.
> 
>  Some of the systems affected are not necessarily fast (e.g. clocked at 
> 12MHz), so I wonder if we shouldn't just bite the bullet and expand the 
> %hi/%lo pair here.  Even with R4k DECstations we only support `-msym32' 
> compilation only, due to R4k errata, so it's not like the higher parts 
> will ever be needed for address calculation.
> 
>  Alternatively we could have a `.set warn'/`.set nowarn' setting in GAS, 
> previously discussed I believe, although it would take a bit to propagate.

Yeah, I'm already looking into the other direction whenever this warning
pops up - and it does so often.  I've even pondered submitting something
like -Werror for gas ;-)

It's not very elegant but you could just open code everything, see below
patch.  Compiles but not runtime tested due to lack of hardware.

Maciej, can you test this?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/dec/int-handler.S | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/mips/dec/int-handler.S b/arch/mips/dec/int-handler.S
index d7b9918..20035fc 100644
--- a/arch/mips/dec/int-handler.S
+++ b/arch/mips/dec/int-handler.S
@@ -146,7 +146,25 @@
 		/*
 		 * Find irq with highest priority
 		 */
-		 PTR_LA	t1,cpu_mask_nr_tbl
+		# open coded PTR_LA t1, cpu_mask_nr_tbl
+#if (_MIPS_SZPTR == 32)
+		# open coded la t1, cpu_mask_nr_tbl
+		lui	t1, %hi(cpu_mask_nr_tbl)
+		addiu	t1, %lo(cpu_mask_nr_tbl)
+		
+#endif
+#if (_MIPS_SZPTR == 64)
+		# open coded dla t1, cpu_mask_nr_tbl
+		.set	push
+		.set	noat
+		lui	t1, %highest(cpu_mask_nr_tbl)
+		lui	AT, %hi(cpu_mask_nr_tbl)
+		daddiu	t1, t1, %higher(cpu_mask_nr_tbl)
+		daddiu	AT, AT, %lo(cpu_mask_nr_tbl)
+		dsll	t1, 32
+		daddu	t1, t1, AT
+		.set	pop
+#endif
 1:		lw	t2,(t1)
 		nop
 		and	t2,t0
@@ -195,7 +213,25 @@
 		/*
 		 * Find irq with highest priority
 		 */
-		 PTR_LA	t1,asic_mask_nr_tbl
+		# open coded PTR_LA t1,asic_mask_nr_tbl
+#if (_MIPS_SZPTR == 32)
+		# open coded la t1, asic_mask_nr_tbl
+		lui	t1, %hi(asic_mask_nr_tbl)
+		addiu	t1, %lo(asic_mask_nr_tbl)
+		
+#endif
+#if (_MIPS_SZPTR == 64)
+		# open coded dla t1, asic_mask_nr_tbl
+		.set	push
+		.set	noat
+		lui	t1, %highest(asic_mask_nr_tbl)
+		lui	AT, %hi(asic_mask_nr_tbl)
+		daddiu	t1, t1, %higher(asic_mask_nr_tbl)
+		daddiu	AT, AT, %lo(asic_mask_nr_tbl)
+		dsll	t1, 32
+		daddu	t1, t1, AT
+		.set	pop
+#endif
 2:		lw	t2,(t1)
 		nop
 		and	t2,t0
