Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 14:44:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47624 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028664AbcEJMotULsid (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 14:44:49 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4ACiapZ023553;
        Tue, 10 May 2016 14:44:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4ACiQm9023546;
        Tue, 10 May 2016 14:44:26 +0200
Date:   Tue, 10 May 2016 14:44:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Huacai Chen <chenhc@lemote.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 00/12] TLB/XPA fixes & cleanups
Message-ID: <20160510124426.GG16402@linux-mips.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53342
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

On Fri, Apr 15, 2016 at 11:36:48AM +0100, Paul Burton wrote:

> This series fixes up a number of issues introduced by commit
> c5b367835cfc ("MIPS: Add support for XPA."), including breakage of the
> MIPS32 with 36 bit physical addressing case & clobbering of $1 upon TLB
> refill exceptions. Along the way a number of cleanups are made, which
> leaves pgtable-bits.h in particular much more readable than before.
> 
> The series applies atop v4.6-rc3.
> 
> James Hogan (4):
>   MIPS: Separate XPA CPU feature into LPA and MVH
>   MIPS: Fix HTW config on XPA kernel without LPA enabled
>   MIPS: mm: Don't clobber $1 on XPA TLB refill
>   MIPS: mm: Don't do MTHC0 if XPA not present
> 
> Paul Burton (8):
>   MIPS: Remove redundant asm/pgtable-bits.h inclusions
>   MIPS: Use enums to make asm/pgtable-bits.h readable
>   MIPS: mm: Standardise on _PAGE_NO_READ, drop _PAGE_READ
>   MIPS: mm: Unify pte_page definition
>   MIPS: mm: Fix MIPS32 36b physical addressing (alchemy, netlogic)
>   MIPS: mm: Pass scratch register through to iPTE_SW
>   MIPS: mm: Be more explicit about PTE mode bit handling
>   MIPS: mm: Simplify build_update_entries

Applied - but "MIPS: Separate XPA CPU feature into LPA and MVH" causes
a massive conflict with Florian's RIXI patches

  [3/6] MIPS: Allow RIXI to be used on non-R2 or R6 core
  [4/6] MIPS: Move RIXI exception enabling after vendor-specific cpu_probe
  [5/6] MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI

I figured unapplying those three, applying Paul's series then re-applying
Florian's patch on top of the whole series will be the easier path as in
leaving me with the smaller rejects to manage.

  Ralf
