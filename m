Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 17:12:14 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:49654 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022947AbXJPQMG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2007 17:12:06 +0100
Received: from localhost (p2111-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.111])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7A7D49B28; Wed, 17 Oct 2007 01:12:01 +0900 (JST)
Date:	Wed, 17 Oct 2007 01:13:49 +0900 (JST)
Message-Id: <20071017.011349.03977690.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix aliasing bug in copy_user_highpage, take 2.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071016153806.GA23986@linux-mips.org>
References: <20071015182811.GA20157@linux-mips.org>
	<20071017.002916.07645039.anemo@mba.ocn.ne.jp>
	<20071016153806.GA23986@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 16 Oct 2007 16:38:06 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Hmm, setting SetPageDcacheDirty() will not make sure the modified data
> > flushed before reading via the kernel mapping.  The flush_dcache_page()
> > should be used for such case, shouldn't it?
> 
> You're right - and the intent is to _not_ flush the page.  But we're
> bringing it into the cache, so we better flush it before it will be mapped
> to userspace.  We want to delay the flush operation.

I see, but I'm afraid of unnecessary flushing might hide another
bug...

Setting SetPageDcacheDirty() for non-modified page looks a bit
overkill for me.  For example, in copy_user_highpage() we do not flush
the source page if the page was not mapped to userspace.

---
Atsushi Nemoto
