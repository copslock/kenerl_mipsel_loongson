Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 17:38:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36989 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012469AbbEOPh7kC8TN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 17:37:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4FFc1G4004220;
        Fri, 15 May 2015 17:38:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4FFc0Ma004219;
        Fri, 15 May 2015 17:38:00 +0200
Date:   Fri, 15 May 2015 17:38:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 5/9] MIPS: dump_tlb: Take global bit into account
Message-ID: <20150515153800.GD2322@linux-mips.org>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
 <1431514255-3030-6-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431514255-3030-6-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47409
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

On Wed, May 13, 2015 at 11:50:51AM +0100, James Hogan wrote:

> The TLB only matches the ASID when the global bit isn't set, so
> dump_tlb() shouldn't really be skipping global entries just because the
> ASID doesn't match. Fix the condition to read the TLB entry's global bit
> from EntryLo0. Note that after a TLB read the global bits in both
> EntryLo registers reflect the same global bit in the TLB entry.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/lib/dump_tlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
> index 17d05caa776d..70e0a6bdb322 100644
> --- a/arch/mips/lib/dump_tlb.c
> +++ b/arch/mips/lib/dump_tlb.c
> @@ -73,7 +73,8 @@ static void dump_tlb(int first, int last)
>  		 */
>  		if ((entryhi & ~0x1ffffUL) == CKSEG0)
>  			continue;
> -		if ((entryhi & 0xff) != asid)
> +		/* ASID takes effect in absense of global bit */
> +		if (!(entrylo0 & 1) && (entryhi & 0xff) != asid)
>  			continue;

Note the architecture mandates that there only is one global bit per
TLB entry and its written as the logic and of the two global bits in
the entrylo0 and entrylo1 registers.  On TLB read the G bits of both
entrylo registers will return the same value.

In reality some implementations differ in hardware, for example the
SB1 core where the TLB entries both have their separate G bit.  Both
will be written with the logic and of the G bits of the entrylo registers
so the existence of multiple G bits per TLB entry should never become
visible.

Except when writing a duplicate TLB entry where certain revisions will
write the entrylo0 half of the TLB entry, then take the machine check
exception leaving the entrylo1 half of the TLB entry unchanged.  At
this point one may end up with architecturally undefined TLB entries
with one G bit set and one clear.

There may be other CPUs where such invalid TLB entries are possible
therfore think we should check for entries with mismatching global
bits and print those anyway.

  Ralf
