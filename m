Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 14:53:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46234 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007242AbbEZMxnduwJh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 May 2015 14:53:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4QCrjYv014807;
        Tue, 26 May 2015 14:53:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4QCrjV2014806;
        Tue, 26 May 2015 14:53:45 +0200
Date:   Tue, 26 May 2015 14:53:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 02/10] MIPS: hazards: Add hazard macros for tlb read
Message-ID: <20150526125344.GD13022@linux-mips.org>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
 <1432025438-26431-3-git-send-email-james.hogan@imgtec.com>
 <alpine.LFD.2.11.1505261311590.11225@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1505261311590.11225@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47664
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

On Tue, May 26, 2015 at 01:36:37PM +0100, Maciej W. Rozycki wrote:

> > - tlb_read_hazard
> >   Between tlbr and mfc0 (various TLB registers). This is copied from
> >   tlbw_use_hazard in all cases on the assumption that tlbr has similar
> >   data writer characteristics to tlbw, and mfc0 has similar data user
> >   characteristics to loads and stores.
> 
>  Be careful with this assumption, it does not stand for R4600/R4700 and 
> R5000 processors (4 vs 3 intervening instructions), you need an extra NOP 
> for them.  Likewise there is a difference with the 5K (1 vs 0 intervening 
> instructions), but it's already buried in our pessimistic barrier that 
> assumes 4 intervening instructions.

The TLB write hazard is 4 cycles on the 8 stage R4000 pipeline but 2 cycles
on the R4600 pipeline.  We handle this in a particularly non-obvious but
optimized way by exploiting the fact that the R4000 pipeline kills two
instructions following the branch delay slot like:

	.set	noreorder
	MTC0	$reg, c0_sometlbregister
	B	1f
1:	 NOP
	TLBW

where the branch-nop sequence will cost 4 cycles on the R4000's eight-stage
pipeline but only two on the R4600 pipeline.

  Ralf
