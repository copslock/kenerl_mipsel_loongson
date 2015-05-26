Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 14:36:40 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007089AbbEZMghw0U9- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 14:36:37 +0200
Date:   Tue, 26 May 2015 13:36:37 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 02/10] MIPS: hazards: Add hazard macros for tlb read
In-Reply-To: <1432025438-26431-3-git-send-email-james.hogan@imgtec.com>
Message-ID: <alpine.LFD.2.11.1505261311590.11225@eddie.linux-mips.org>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com> <1432025438-26431-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47663
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

On Tue, 19 May 2015, James Hogan wrote:

> - tlb_read_hazard
>   Between tlbr and mfc0 (various TLB registers). This is copied from
>   tlbw_use_hazard in all cases on the assumption that tlbr has similar
>   data writer characteristics to tlbw, and mfc0 has similar data user
>   characteristics to loads and stores.

 Be careful with this assumption, it does not stand for R4600/R4700 and 
R5000 processors (4 vs 3 intervening instructions), you need an extra NOP 
for them.  Likewise there is a difference with the 5K (1 vs 0 intervening 
instructions), but it's already buried in our pessimistic barrier that 
assumes 4 intervening instructions.

  Maciej
