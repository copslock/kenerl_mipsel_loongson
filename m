Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 May 2006 22:15:03 +0200 (CEST)
Received: from eastrmmtao05.cox.net ([68.230.240.34]:61648 "HELO
	eastrmmtao05.cox.net") by ftp.linux-mips.org with SMTP
	id S8133554AbWENUOz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 May 2006 22:14:55 +0200
Received: from hermes.mountolympos.net ([70.160.186.45])
          by eastrmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514201448.SPBZ26910.eastrmmtao05.cox.net@hermes.mountolympos.net>;
          Sun, 14 May 2006 16:14:48 -0400
Received: from zeus.mountolympos.net (zeus.mountolympos.net [192.168.2.2])
	by hermes.mountolympos.net (Postfix) with ESMTP id 619081677B;
	Sun, 14 May 2006 16:14:48 -0400 (EDT)
Received: from [192.168.2.3] (kronos.mountolympos.net [192.168.2.3])
	by zeus.mountolympos.net (Postfix) with ESMTP id 6A032100A11D;
	Sun, 14 May 2006 16:14:48 -0400 (EDT)
Message-ID: <44678FB8.4070104@mountolympos.net>
Date:	Sun, 14 May 2006 16:14:48 -0400
From:	John Miller <jamiller1110@cox.net>
User-Agent: Thunderbird 1.5 (X11/20060402)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Instruction error with cache opcode
References: <446735C6.2080306@mountolympos.net> <002a01c67761$253e97f0$0202a8c0@Ulysses> <4467796E.8060000@mountolympos.net> <009501c6778e$947c3ff0$10eca8c0@grendel>
In-Reply-To: <009501c6778e$947c3ff0$10eca8c0@grendel>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jamiller1110@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamiller1110@cox.net
Precedence: bulk
X-list: linux-mips


>
> Have you got your sources properly installes so that include/asm is
> a symlink to include/asm-mips?  
Yes, include/asm is symlinked to include/asm-mips.  Let me provide a
little more detail.  I did not want to modify head.S (since this is a
kernel file) but I noticed an undefined macro,

    kernel_entry_setup            # cpu specific setup

and the include #include <kernel-entry-init.h>

I found at least one kernel-entry-init.h file in a hardware specific
directory so I made my own under include/asm-mips/rb500 and added a line
to the Makefile.  Within kernel-entry-init.h are the include for
cacheops.h as well as the macro definition.  regdef.h is included in
head.s.
> I've done the experiment at my end,
> and it builds just fine so long as regdef.h and cacheops.h are really
> on the include path of the compilation.  If they're not, I get:
>
> [kevink@cthulhu tmp]$ mipsel-linux-gcc -I ~/smtchead/include -c cacheop.S
> cacheop.S: Assembler messages:
> cacheop.S:4: Error: Instruction cache requires absolute expression
> cacheop.S:4: Error: Instruction cache requires absolute expression
> cacheop.S:4: Error: illegal operands `cache'
>
>   

Well, it looks like I am missing something somewhere, just need to pin
down what I did wrong.
