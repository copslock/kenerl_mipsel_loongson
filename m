Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 18:42:52 +0100 (BST)
Received: from col0-omc2-s15.col0.hotmail.com ([65.55.34.89]:10105 "EHLO
	col0-omc2-s15.col0.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S28580648AbYGYRmu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jul 2008 18:42:50 +0100
Received: from COL102-DS3 ([65.55.34.73]) by col0-omc2-s15.col0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 25 Jul 2008 10:42:43 -0700
X-Originating-IP: [90.212.251.215]
X-Originating-Email: [danieljlaird@hotmail.com]
Message-ID: <COL102-DS32614E51D494DDF91E561DC860@phx.gbl>
From:	<danieljlaird@hotmail.com>
In-Reply-To: <64660ef00807250921h75ec4e48v92ef964e1c1185f4@mail.gmail.com>
To:	"Daniel Laird" <daniel.j.laird@nxp.com>
Cc:	<linux-mips@linux-mips.org>
References: <64660ef00807250921h75ec4e48v92ef964e1c1185f4@mail.gmail.com>
X-Unsent: 1
Subject: Re: Is the new generic KGDB patch in upstream-akpm?
Date:	Fri, 25 Jul 2008 18:42:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 12.0.1606
X-MimeOLE: Produced By Microsoft MimeOLE V12.0.1606
X-OriginalArrivalTime: 25 Jul 2008 17:42:43.0476 (UTC) FILETIME=[D78D8D40:01C8EE7D]
Return-Path: <danieljlaird@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips

Ignore, suffering from friday stupidity, sorting it now 
Cheers
Dan

--------------------------------------------------
From: "Daniel Laird" <daniel.j.laird@nxp.com>
Sent: Friday, July 25, 2008 5:21 PM
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Subject: Is the new generic KGDB patch in upstream-akpm?

> I am trying to respin the patch to add pnx833x support to linux 2.6.27.
> I wanted to patch against the new generic kernel KGDB patch.
> So I removed gdb-hook etc.
> 
> However when I compile I get
> arch/mips/kernel/built-in.o: In function `early_console_write':
> early_printk.c:(.init.text+0x1450): undefined reference to `prom_putchar'
> early_printk.c:(.init.text+0x1450): relocation truncated to fit:
> R_MIPS_26 against `prom_putchar'
> early_printk.c:(.init.text+0x145c): undefined reference to `prom_putchar'
> early_printk.c:(.init.text+0x145c): relocation truncated to fit:
> R_MIPS_26 against `prom_putchar'
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> These functions were defined in my gdb-hook.c.  Do I need to move
> these somewhere else now? Or just not support EARLY_PRINTK etc.
> 
> Is this true?
> Cheers
> Daniel Laird
> 
> 
