Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 17:17:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36690 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012469AbbEOPRLLJIXO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 17:17:11 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4FFHCM6003832;
        Fri, 15 May 2015 17:17:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4FFHC31003831;
        Fri, 15 May 2015 17:17:12 +0200
Date:   Fri, 15 May 2015 17:17:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/9] MIPS: dump_tlb: Use tlbr hazard macros
Message-ID: <20150515151711.GC2322@linux-mips.org>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
 <1431514255-3030-4-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431514255-3030-4-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47407
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

On Wed, May 13, 2015 at 11:50:49AM +0100, James Hogan wrote:

> Use the new tlb read hazard macros from <asm/hazards.h> rather than the
> local BARRIER() macro which uses 7 ops regardless of the kernel
> configuration.
> 
> We use mtc0_tlbr_hazard for the hazard between mtc0 to the index
> register and the tlbr, and tlb_read_hazard for the hazard between the
> tlbr and the mfc0 of the TLB registers written by tlbr.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Only to repeat for the benefit of the mailing list readers what I already
wrote on IRC recently.  The 7 NOPs sequence will send the uncached
write-back buffer of the R4400 but not R4000 off-chip.  This operation
of course is entirely irrelevant to what the TLB dumper does - but it
just so happens that seven NOPs are also sufficient to deal with TLB
hazards on most CPUs.  If we're lucky - it doesn't use SSNOPs or EHBs.

  Ralf
