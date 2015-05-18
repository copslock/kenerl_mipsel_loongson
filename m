Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 16:19:15 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012399AbbEROTNCCKxD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2015 16:19:13 +0200
Date:   Mon, 18 May 2015 15:19:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/9] MIPS: dump_tlb: Take global bit into account
In-Reply-To: <5559EE0E.5030606@imgtec.com>
Message-ID: <alpine.LFD.2.11.1505181503470.4923@eddie.linux-mips.org>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com> <1431514255-3030-6-git-send-email-james.hogan@imgtec.com> <alpine.LFD.2.11.1505160137150.4923@eddie.linux-mips.org> <5559EE0E.5030606@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47461
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

On Mon, 18 May 2015, James Hogan wrote:

> >> +		if (!(entrylo0 & 1) && (entryhi & 0xff) != asid)
> > 
> >  Hmm, it looks like r3k_dump_tlb.c will need a similar update.  I suggest 
> 
> Yes, quite possibly. Would you be happy to test such a patch (assuming
> you have r3000 hardware available)? Patch 1 should allow the code to be
> easily triggered.

 I'll test the change when you have it, no problem with that.

> > using _PAGE_GLOBAL and ASID_MASK rather than hardcoded 1 and 0xff.
> 
> Yeh, as you mentioned these describe the PTE rather than what goes in
> EntryLo. Perhaps it makes sense to have a few more TLB dependent
> definitions in mipsregs.h (patch 7 already adds a couple for RI/XI bits).

 I think so.  Hardcoded magic values are a pain to track down when you 
need to do so.

 Will you be able to add MIPS_ENTRYLO_G and R3K_ENTRYLO_G, etc. macros 
then please?  I think you can reorder all mipsregs.h changes ahead of the 
series as a single patch.

 Thanks,

  Maciej
