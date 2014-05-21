Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 15:05:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51426 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6843037AbaEUNE7ECdHY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 15:04:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4LD4TPT023791;
        Wed, 21 May 2014 15:04:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4LD4K1Z023790;
        Wed, 21 May 2014 15:04:20 +0200
Date:   Wed, 21 May 2014 15:04:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, David Daney <ddaney.cavm@gmail.com>,
        kvm@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 05/15] MIPS: Don't build fast TLB refill handler with
 32-bit kernels.
Message-ID: <20140521130420.GR10287@linux-mips.org>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-6-git-send-email-andreas.herrmann@caviumnetworks.com>
 <537C741F.60104@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537C741F.60104@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40217
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

On Wed, May 21, 2014 at 10:38:39AM +0100, James Hogan wrote:

> On 20/05/14 15:47, Andreas Herrmann wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > The fast handler only supports 64-bit kernels.
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  arch/mips/mm/tlbex.c |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> > index ee88367..781e183 100644
> > --- a/arch/mips/mm/tlbex.c
> > +++ b/arch/mips/mm/tlbex.c
> > @@ -1250,13 +1250,17 @@ static void build_r4000_tlb_refill_handler(void)
> >  	unsigned int final_len;
> >  	struct mips_huge_tlb_info htlb_info __maybe_unused;
> >  	enum vmalloc64_mode vmalloc_mode __maybe_unused;
> > -
> > +#ifdef CONFIG_64BIT
> > +	bool is64bit = true;
> > +#else
> > +	bool is64bit = false;
> > +#endif
> >  	memset(tlb_handler, 0, sizeof(tlb_handler));
> >  	memset(labels, 0, sizeof(labels));
> >  	memset(relocs, 0, sizeof(relocs));
> >  	memset(final_handler, 0, sizeof(final_handler));
> >  
> > -	if ((scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
> > +	if (is64bit && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
> >  		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
> >  							  scratch_reg);
> >  		vmalloc_mode = refill_scratch;
> > 
> 
> This looks like a good place to use IS_ENABLED(CONFIG_64BIT) to reduce
> ifdefery.

Or even the classic "if (sizeof(unsigned long) == 8)" which is a little less
expressive but more portable.

  Ralf
