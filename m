Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2006 14:04:06 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:15857 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038671AbWKOOEB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2006 14:04:01 +0000
Received: from localhost (p6123-ipad25funabasi.chiba.ocn.ne.jp [220.104.84.123])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B2B13BA42; Wed, 15 Nov 2006 23:03:55 +0900 (JST)
Date:	Wed, 15 Nov 2006 23:06:33 +0900 (JST)
Message-Id: <20061115.230633.41198511.anemo@mba.ocn.ne.jp>
To:	Trevor_Hamm@pmc-sierra.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <E8C8A5231DDE104C816ADF532E0639120194F4CD@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
References: <E8C8A5231DDE104C816ADF532E0639120194F4CD@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 14 Nov 2006 13:47:41 -0800, Trevor Hamm <Trevor_Hamm@pmc-sierra.com> wrote:
> > Could you confirm that removing whole "if (mapping ..." block from
> > __flush_dcache_page can hide your problem?
> 
> Yes, removing this block seems to hide the problem.  I can boot
> completely to a login prompt.

Thank you for testing.  So we can omit "missing fludh_dcache_page()" case.

> > Or if you changed a line in __update_cache():
> > 
> > 	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
> > 
> > to
> > 
> > 	int exec = 1;
> > 
> > then your problem still happen?
> 
> Yes, with this change, the boot-up problem persists.

Then, I can imagine three (hardly possible) case:

A.  PG_dcache_dirty bit was cleared accidently.

B.  The page is accessed by user process without page_mapping()

C.  kernel forgot to call update_mmu_cache() at somewhere.

If case A, removing "&& Page_dcache_dirty(page)" condition from
__update_cache() will hide your problem.  If case B, calling
flush_dcache_page() unconditionally in __update_cache() will hide your
problem.

Anyway for now I can not see why this can happen...

Just for confirm:
1. This can happen on latest lmo git tree or 2.6.19-rc5.
2. UP kernel.
3. No L2 cache.
4. icache and dcache are both virtually indexed and physically tagged.
All correct?

---
Atsushi Nemoto
