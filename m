Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 11:33:00 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:50024 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225072AbTDHKc7>;
	Tue, 8 Apr 2003 11:32:59 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id 927D56EE; Tue,  8 Apr 2003 12:32:50 +0200 (CEST)
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Aliasing in pgtable-bits.h (CONFIG_64BIT_PHYS_ADDR)
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3E9274F0.227008F7@ekner.info> (Hartvig Ekner's message of
 "Tue, 08 Apr 2003 09:06:24 +0200")
References: <3E9274F0.227008F7@ekner.info>
Date: Tue, 08 Apr 2003 12:32:50 +0200
Message-ID: <868yul2sa5.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "hartvig" == Hartvig Ekner <hartvig@ekner.info> writes:

hartvig> From pgtable-bits.h:
hartvig> #if defined(CONFIG_CPU_MIPS32) && defined(CONFIG_64BIT_PHYS_ADDR)

hartvig> #define _PAGE_PRESENT               (1<<6)  /* implemented in software
hartvig> */
hartvig> #define _PAGE_READ                  (1<<7)  /* implemented in software
hartvig> */
hartvig> #define _PAGE_WRITE                 (1<<8)  /* implemented in software
hartvig> */
hartvig> #define _PAGE_ACCESSED              (1<<9)  /* implemented in software
hartvig> */
hartvig> #define _PAGE_MODIFIED              (1<<10) /* implemented in software
hartvig> */

hartvig> #define  _PAGE_R4KBUG                (1<<0)  /* workaround for r4k bug
hartvig> */
hartvig> #define _PAGE_GLOBAL                (1<<0)

hartvig> Is  the aliasing between R4KBUG & GLOBAL intentional? This is the only
hartvig> CONFIG case where it
hartvig> is  done. Superficially, I can't see R4KBUG used anywhere, so maybe it
hartvig> doesn't matter. But
hartvig> if R4KBUG truly isn't used, why not consider removing it entirely from
hartvig> all PTE layouts?

I will bet that this is related to the comment in
arch/mips/mm/tlb-r4k.c workaround that is unimplemented:

/* We will need multiple versions of update_mmu_cache(), one that just
 * updates the TLB with the new pte(s), and another which also checks
 * for the R4k "end of page" hardware bug and does the needy.
 */

Anyways, it appears that affected CPUS are only r4k and r4400 or so,
no big deal for rest of CPU's.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
