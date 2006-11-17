Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2006 10:13:24 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:33173 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037715AbWKQKNU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Nov 2006 10:13:20 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 17 Nov 2006 19:13:18 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B4FAF202AC;
	Fri, 17 Nov 2006 19:13:15 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A0F20201D2;
	Fri, 17 Nov 2006 19:13:15 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kAHADEW0000881;
	Fri, 17 Nov 2006 19:13:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 17 Nov 2006 19:13:14 +0900 (JST)
Message-Id: <20061117.191314.88700615.nemoto@toshiba-tops.co.jp>
To:	Trevor_Hamm@pmc-sierra.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <E8C8A5231DDE104C816ADF532E0639120194F4D0@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
References: <E8C8A5231DDE104C816ADF532E0639120194F4D0@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
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
X-archive-position: 13212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 15 Nov 2006 11:23:58 -0800, Trevor Hamm <Trevor_Hamm@pmc-sierra.com> wrote:
> > Just for confirm:
> > 1. This can happen on latest lmo git tree or 2.6.19-rc5.
> > 2. UP kernel.
> > 3. No L2 cache.
> > 4. icache and dcache are both virtually indexed and physically tagged.
> > All correct?
> > 
> 
> Except for #1 which I haven't tried (we need to get this working
> with 2.6.18), all correct.  The caches are 64k, 4-way.

Thanks.  I re-read your report and wonder why this happens only on
power-up time.

If flush_data_cache_page or update_mmu_cache were broken, the problem
can happen on every restart.

The entire icache/dcache should be cleared at end of r4k_cache_init()
at least.  MIPS34K could have some magical state (lock bit or
something) which is not initialized by local_r4k___flush_cache_all()?

---
Atsushi Nemoto
