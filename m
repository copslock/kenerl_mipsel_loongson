Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2006 01:58:04 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:44845 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038597AbWKIB6A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Nov 2006 01:58:00 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 9 Nov 2006 10:57:59 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2B9B123ECE;
	Thu,  9 Nov 2006 10:57:55 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1817620377;
	Thu,  9 Nov 2006 10:57:55 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kA91vqW0061048;
	Thu, 9 Nov 2006 10:57:52 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 09 Nov 2006 10:57:52 +0900 (JST)
Message-Id: <20061109.105752.25910642.nemoto@toshiba-tops.co.jp>
To:	Trevor_Hamm@pmc-sierra.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <E8C8A5231DDE104C816ADF532E0639120194F4C6@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
References: <E8C8A5231DDE104C816ADF532E0639120194F4C6@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
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
X-archive-position: 13166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 8 Nov 2006 11:09:37 -0800 , Trevor Hamm <Trevor_Hamm@pmc-sierra.com> wrote:
> So just for fun, I built a linux image to use a write-through
> caching policy, and it boots from power-up every time.
> 
> With this information, I would conclude the problem is due to cache
> management, either in the way we're initializing the cache, or
> something else in the squashfs code.  Or is there another
> explanation that I'm overlooking?

Hmm, could you try init=/bin/sh?  If the shell invoked successfully it
might be COW issue.  In this case, could you try deleting
__HAVE_ARCH_COPY_USER_HIGHPAGE in include/asm-mips/page.h?

If init=/bin/sh not worked, COW is irrelevant and something would be
wrong around flush_dcache_page/update_mmu_cache.  But no idea now ...

---
Atsushi Nemoto
