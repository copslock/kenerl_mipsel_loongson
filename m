Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2006 02:19:37 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:2627 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039076AbWKBCTf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Nov 2006 02:19:35 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 2 Nov 2006 11:19:34 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 627D141C67;
	Thu,  2 Nov 2006 11:19:27 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 554D5417CA;
	Thu,  2 Nov 2006 11:19:27 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kA22JQW0029257;
	Thu, 2 Nov 2006 11:19:26 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 02 Nov 2006 11:19:26 +0900 (JST)
Message-Id: <20061102.111926.25910639.nemoto@toshiba-tops.co.jp>
To:	Trevor_Hamm@pmc-sierra.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <E8C8A5231DDE104C816ADF532E0639120194F4B2@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
References: <E8C8A5231DDE104C816ADF532E0639120194F4B2@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
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
X-archive-position: 13145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 1 Nov 2006 12:06:15 -0800 , Trevor Hamm <Trevor_Hamm@pmc-sierra.com> wrote:
> My investigation shows this behaviour was introduced between
> 2.6.17.10 and 2.6.17.12 (2.6.17.11 failed to build, so I didn't test
> that version).  In fact, the patch below, applied against 2.6.17.10,
> is sufficient to cause the boot problem.  The bulk of this patch
> includes a fix from Aug. 31, 2006 for dcache aliasing on fork.  If I
> exclude the dcache aliasing fix from this patch, the boot problem
> apparently disappears.
> 
> Some more interesting details:
> - We're using a squashfs root filesystem in RAM (squashfs 3.1-r2).
>   We have not been able to reproduce with cramfs.

If dcache aliasing patch caused this problem, it might be due to
missing flush_dcache_page() in squashfs.

With a quick look at squashfs/inode.c, it seems flush_dcache_page() is
needed at end of squashfs_symlink_readpage() as other functions.
Could you try it?

skip_read:
	memset(pageaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
	kunmap(page);
	flush_dcache_page(page);	/* THIS */
	SetPageUptodate(page);
	unlock_page(page);

---
Atsushi Nemoto
