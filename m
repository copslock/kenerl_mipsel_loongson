Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 15:41:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:56797 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20029726AbXIZOlN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2007 15:41:13 +0100
Received: from localhost (p2188-ipad308funabasi.chiba.ocn.ne.jp [123.217.188.188])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DEA4FCF34; Wed, 26 Sep 2007 23:41:07 +0900 (JST)
Date:	Wed, 26 Sep 2007 23:42:46 +0900 (JST)
Message-Id: <20070926.234246.128619502.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	tbm@cyrius.com, linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46FA2307.3090600@gmail.com>
References: <20070925181353.GA15412@deprecation.cyrius.com>
	<20070926.110814.41629599.nemoto@toshiba-tops.co.jp>
	<46FA2307.3090600@gmail.com>
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
X-archive-position: 16695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 26 Sep 2007 11:14:47 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Ah but as I suggested I think we should get rid of
> KBUILD_64BIT_SYM32 in the code. This patchset won't work if the kernel
> symbols are modified latter through objcopy or whatever...
> 
> What do you think ?

Well, KBUILD_64BIT_SYM32 in stackframe.h is in critical path.

And for KBUILD_64BIT_SYM32 in pgtable-64, I'm not sure non-sym32
module can work on CKSSEG.  It might work but it seems XKSEG is more
natural for non-sym32 module.

So now I'm happy with your patchset as is in linux-queue tree ;)

---
Atsushi Nemoto
