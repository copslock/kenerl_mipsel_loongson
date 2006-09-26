Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 17:33:51 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:41425 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037808AbWIZQdu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 17:33:50 +0100
Received: from localhost (p5240-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 42BDFA9EC; Wed, 27 Sep 2006 01:33:45 +0900 (JST)
Date:	Wed, 27 Sep 2006 01:35:53 +0900 (JST)
Message-Id: <20060927.013553.48803581.anemo@mba.ocn.ne.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <C13F744E.72CB%girishvg@gmail.com>
References: <20060926.180240.109570923.nemoto@toshiba-tops.co.jp>
	<C13F744E.72CB%girishvg@gmail.com>
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
X-archive-position: 12686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 27 Sep 2006 00:20:30 +0900, girish <girishvg@gmail.com> wrote:
> But, then again treating all addresses as above PAGE_OFFSET is also wrong :)

It would be a design not a bug :-)

> I looked at it just as a work around. These macros are called from so many
> other places that if an access is made at say 4000_0000 the kernel will oops
> telling it was C000_0000 access error. Now that confused me a lot! With this
> change now kernel oops on 4000_0000 :)

Yes, 4000_0000, which is wrong too.  And it _hides_ wrong usage of
vaddr/paddr.  Bad side effect :)

> Anyway, you may ignore __pa/__va macros.
> 
> Could you please look into other changes I proposed?

__pa() returns "unsigned long" and __va() returns "void *" so some
casts are also redundant.  

Other parts looks good for me.
---
Atsushi Nemoto
