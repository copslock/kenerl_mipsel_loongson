Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 16:59:59 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:39116 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225329AbSLRQ76>; Wed, 18 Dec 2002 16:59:58 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09963;
	Wed, 18 Dec 2002 18:00:10 +0100 (MET)
Date: Wed, 18 Dec 2002 18:00:09 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: remove warnings on promlib
In-Reply-To: <m2u1hcp0ds.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021218174743.5977E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 18 Dec 2002, Juan Quintela wrote:

> Index: arch/mips/lib/promlib.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/lib/promlib.c,v
> retrieving revision 1.1.2.1
> diff -u -r1.1.2.1 promlib.c
> --- arch/mips/lib/promlib.c	28 Sep 2002 22:28:38 -0000	1.1.2.1
> +++ arch/mips/lib/promlib.c	18 Dec 2002 00:49:18 -0000
> @@ -1,3 +1,7 @@
> +
> +#include <asm/sgialib.h>
> +#include <linux/kernel.h>
> +
>  #include <stdarg.h>
>  
>  void prom_printf(char *fmt, ...)

 A few comments:

1. <linux> includes first, <asm> ones following (hmm, shouldn't that be
obvious...).

2. <linux/kernel.h> is obviously OK for vsprintf().

3. I would hesitate using <asm/sgialib.h> here being too much platform
specific.  Either a separate generic <asm/prom.h> should be created for
primitives like prom_putchar(), prom_getchar(), etc. or a private
conservative declaration should be used here.  The reason is the functions
are much platform-specific, e.g. they may be pointers or even macros --
see <asm/dec/prom.h> for a not-so-trivial example (luckily, DECstations
support prom_printf() directly, so they don't have to use promlib.c).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
