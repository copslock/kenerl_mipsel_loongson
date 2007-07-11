Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 15:53:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:59849 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021506AbXGKOxb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 15:53:31 +0100
Received: from localhost (p7242-ipad32funabasi.chiba.ocn.ne.jp [221.189.139.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 32602A96E; Wed, 11 Jul 2007 23:53:26 +0900 (JST)
Date:	Wed, 11 Jul 2007 23:54:20 +0900 (JST)
Message-Id: <20070711.235420.18311683.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Workaround for a sparse warning in
 include/asm-mips/io.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0707111516250.26459@blysk.ds.pg.gda.pl>
References: <20070711.231200.05599385.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0707111516250.26459@blysk.ds.pg.gda.pl>
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
X-archive-position: 15694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jul 2007 15:28:19 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  It looks like a bug in sparse.  The result of CKSEG1ADDR() has the same 
> size as the pointer.  Perhaps we could append 'L' to the expansion of 
> KSEG1 et al, but that should not really matter.

Yes, adding 'L' to KSEG1 is another way to silence the warnings.  But
I just thought it was a bit intrusive.  And I'm not sure all code are
OK if KSEG1 is 'signed' ...

>  But -- I have just checked two example calls to this function, one with a 
> 32-bit configuration and another one with a 64-bit one and sparse did not 
> complain.  The cpp expansions of the expression in question are:
> 
> return (void *)((((int)(int)(phys_addr)) & 0x1fffffff) | 0xa0000000);
> 
> and:
> 
> return (void *)((((long int)(int)(phys_addr)) & 0x1fffffff) | 0xffffffffa0000000L);
> 
> respectively, so your cast is definitely redundant in these cases.  What 
> sort of configuration are you using?  What's the preprocessor output for 
> the problematic case?

I see the warnings on 32-bit qemu kernel.  drivers/serial/8250.c,
lib/devres.c, etc.

I think sparse complains on casting to "void __iomem *" from "int".
It looks sparse accepts casting from "long".

---
Atsushi Nemoto
