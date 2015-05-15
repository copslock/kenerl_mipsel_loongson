Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 17:08:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36523 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012469AbbEOPIob7iEX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 17:08:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4FF8j5w003657;
        Fri, 15 May 2015 17:08:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4FF8j90003656;
        Fri, 15 May 2015 17:08:45 +0200
Date:   Fri, 15 May 2015 17:08:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/9] MIPS: hazards: Add hazard macros for tlb read
Message-ID: <20150515150845.GB2322@linux-mips.org>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
 <1431514255-3030-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431514255-3030-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47406
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

On Wed, May 13, 2015 at 11:50:48AM +0100, James Hogan wrote:

> Add hazard macros to <asm/hazards.h> for the following hazards around
> tlbr (TLB read) instructions, which are used in TLB dumping code and
> some KVM TLB management code:
> 
> - mtc0_tlbr_hazard
>   Between mtc0 (Index) and tlbr. This is copied from mtc0_tlbw_hazard in
>   all cases on the assumption that tlbr always has similar data user
>   timings to tlbw.
> 
> - tlb_read_hazard
>   Between tlbr and mfc0 (various TLB registers). This is copied from
>   tlbw_use_hazard in all cases on the assumption that tlbr has similar
>   data writer characteristics to tlbw, and mfc0 has similar data user
>   characteristics to loads and stores.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
> Looking at r4000 manual, its tlbr had similar data user timings to tlbw,
> and mfc0 had similar data writer timings to loads and stores. Are there
> particular other cores that should be checked too?

The R4600 and R5000 CPUs are important.  The R4600 also covers the
R4700 and the R5000 the R52xx embedded cores.

For most cases the R4000/R4400 due to their long pipeline represent the
worst case but there are exceptions.

  Ralf
