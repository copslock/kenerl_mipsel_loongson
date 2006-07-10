Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2006 15:33:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:48872 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133454AbWGJOdl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2006 15:33:41 +0100
Received: from localhost (p8142-ipad212funabasi.chiba.ocn.ne.jp [58.91.172.142])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6B9F1A8B5; Mon, 10 Jul 2006 23:33:36 +0900 (JST)
Date:	Mon, 10 Jul 2006 23:34:54 +0900 (JST)
Message-Id: <20060710.233454.39153668.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80607100434h13831eb7rc6eda13a0d9e373f@mail.gmail.com>
References: <cda58cb80607060805yc656114p53516b904188c20f@mail.gmail.com>
	<20060707.002602.75184460.anemo@mba.ocn.ne.jp>
	<cda58cb80607100434h13831eb7rc6eda13a0d9e373f@mail.gmail.com>
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
X-archive-position: 11963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 10 Jul 2006 13:34:06 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> could you put the diffstat next time ?

Sure.  I'll do it.

> can we use pfn_valid() instead of page_is_ram() ? bootmem_init() and
> sparse_init() have already been called so pfn_valid() should be safe
> here....

We can, but we can get more precise value using page_is_ram().  The
pfn_valid() returns true for _all_ pages on present section, and
currently the section size is 256MB.

> > -       max_mapnr = num_physpages = highend_pfn;
> > +       max_mapnr = highend_pfn;
> >  #else
> > -       max_mapnr = num_physpages = max_low_pfn;
> > +       max_mapnr = max_low_pfn;
> 
> this is not always true, specially if FLATMEM set and your physical mem
> do not start at 0.

Yes, and I think you are preparing a patch for these systems ;-)

---
Atsushi Nemoto
