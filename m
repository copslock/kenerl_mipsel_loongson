Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 03:02:41 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27026747AbbEPBCieHUNz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 03:02:38 +0200
Date:   Sat, 16 May 2015 02:02:38 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/9] MIPS: dump_tlb: Take global bit into account
In-Reply-To: <alpine.LFD.2.11.1505160137150.4923@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1505160155080.4923@eddie.linux-mips.org>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com> <1431514255-3030-6-git-send-email-james.hogan@imgtec.com> <alpine.LFD.2.11.1505160137150.4923@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47428
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

On Sat, 16 May 2015, Maciej W. Rozycki wrote:

> > +		if (!(entrylo0 & 1) && (entryhi & 0xff) != asid)
> 
>  Hmm, it looks like r3k_dump_tlb.c will need a similar update.  I suggest 
> using _PAGE_GLOBAL and ASID_MASK rather than hardcoded 1 and 0xff.

 Umm, _PAGE_GLOBAL won't work here as the R4k TLB model uses 
`pte_to_entrylo' that shifts PTEs.  So it looks we need another set of 
macros (beyond ASID_MASK) to describe bits in EntryLo registers.

  Maciej
