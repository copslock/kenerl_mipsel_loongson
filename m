Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2006 03:16:35 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:50768 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038424AbWKJDQb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Nov 2006 03:16:31 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 10 Nov 2006 12:16:29 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id C9D8C205E9;
	Fri, 10 Nov 2006 12:16:26 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B69F02048B;
	Fri, 10 Nov 2006 12:16:26 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kAA3GNW0066099;
	Fri, 10 Nov 2006 12:16:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 10 Nov 2006 12:16:23 +0900 (JST)
Message-Id: <20061110.121623.26097731.nemoto@toshiba-tops.co.jp>
To:	Trevor_Hamm@pmc-sierra.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <E8C8A5231DDE104C816ADF532E0639120194F4CC@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
References: <E8C8A5231DDE104C816ADF532E0639120194F4CC@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 9 Nov 2006 09:20:12 -0800 , Trevor Hamm <Trevor_Hamm@pmc-sierra.com> wrote:
> > Hmm, could you try init=/bin/sh?  If the shell invoked successfully it
> > might be COW issue.  
> 
>  Yes, /bin/sh works.  I've also run different /sbin/init programs
> successfully (sysvinit, busybox; I think I mentioned sysvinit worked
> in my original post).  It's just with simpleinit from util-linux
> 2.12r that we've seen this issue.

Oh, I had missed that point.  And I realize you said the fault was
happend in /sbin/init itself.  So it should not be COW issue.

> > In this case, could you try deleting
> > __HAVE_ARCH_COPY_USER_HIGHPAGE in include/asm-mips/page.h?
> 
> Okay, I did this, but /sbin/init still hangs in the same place.  I
> also had to delete the copy_user_highpage function in
> arch/mips/mm/init.c to get the kernel to build.  It's now using the
> copy_user_highpage from include/linux/highmem.h.  I assume this was
> your intention?

Yes, then copy_user_highpage would not be guilty.  Your trial
confirmed this.  Thanks anyway.

So now I doubt flush_dcache_page/update_mmu_cache change caused your
problem, which was happen during 2.6.17.8 and 2.6.17.9.  This is a bit
inconsistent from your analysis (2.6.17.10 was OK), but in general
cache troubles are very sensitive anyway...


Could you confirm that removing whole "if (mapping ..." block from
__flush_dcache_page can hide your problem?

Or if you changed a line in __update_cache():

	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;

to

	int exec = 1;

then your problem still happen?


---
Atsushi Nemoto
