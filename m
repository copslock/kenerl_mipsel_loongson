Received:  by oss.sgi.com id <S42310AbQI0KIN>;
	Wed, 27 Sep 2000 03:08:13 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:58531 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42278AbQI0KHn>;
	Wed, 27 Sep 2000 03:07:43 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA26405;
	Wed, 27 Sep 2000 12:06:32 +0200 (MET DST)
Date:   Wed, 27 Sep 2000 12:06:31 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     "Kevin D. Kissell" <kevink@mips.com>, ralf@oss.sgi.com,
        Dominic Sweetman <dom@algor.co.uk>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
In-Reply-To: <39D0E51C.79A0BE50@mvista.com>
Message-ID: <Pine.GSO.3.96.1000927112232.25150A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 26 Sep 2000, Jun Sun wrote:

> --- linux/include/asm-mips/unaligned.h.orig     Mon Sep 25 14:02:52 2000
> +++ linux/include/asm-mips/unaligned.h  Tue Sep 26 10:53:31 2000
> @@ -19,7 +19,7 @@
>  {
>         unsigned long long __res;
>  
> -       __asm__("uld\t%0,(%1)"
> +       __asm__(".set\tmips3\n\tuld\t%0,(%1)"
>                 :"=&r" (__res)
>                 :"r" (__addr));
>  
[etc.]

 Please don't.  Gcc already has means to generate proper unaligned
accesses.  See include/asm-alpha/unaligned.h for how to achieve them in a
portable way (i.e. using packed structs) without the problematic inline
asm.

 And please use ".set mips0" (or ".set push" and ".set pop",
appropriately) after using any ".set mips*" directive (or any other ".set"
directive to that matter) not to adversly affect any other code.  Improper
coding of such constructs bites R3K people badly.

 Better yet, configure your compiler appropriately and avoid switching ISA
levels in the code if at all possible.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
