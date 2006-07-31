Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 14:38:16 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:47331 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8126917AbWGaNiF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2006 14:38:05 +0100
Received: from localhost (p3075-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.75])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E77AD97CB; Mon, 31 Jul 2006 22:37:50 +0900 (JST)
Date:	Mon, 31 Jul 2006 22:39:23 +0900 (JST)
Message-Id: <20060731.223923.115609520.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44CDCA46.3030707@innova-card.com>
References: <cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>
	<20060729.010137.36922349.anemo@mba.ocn.ne.jp>
	<44CDCA46.3030707@innova-card.com>
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
X-archive-position: 12129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 31 Jul 2006 11:15:50 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > Yes, that is what I wanted.  Imagine if a exception happened on first
> > place on non-leaf function.  In this case, we must assume the function
> > is leaf since RA is not saved to the stack.
> 
> The only case I can imagine is when sp is corrupted which is unlikely.

Modern gcc somtimes do amazing optimization ;-)

> However an exception can occure just after a prologue of a nested
> function which is more likely. In that case you will assume wrongly
> that the function was a leaf one.

Why?  get_frame_info() should detect frame_size and pc_offset for that
case.

Is your objection against "info->func_size / 4" part?  the "4" comes
from size of a instruction.

Well, using "4" instead of "sizeof(union mips_instruction)" or
"sizeof(*ip)" was my old fault...

---
Atsushi Nemoto
