Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 12:05:42 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:55460 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225845AbTLWMFd>; Tue, 23 Dec 2003 12:05:33 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 0B9E64781E; Tue, 23 Dec 2003 13:05:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 00FE03B036; Tue, 23 Dec 2003 13:05:29 +0100 (CET)
Date: Tue, 23 Dec 2003 13:05:29 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
In-Reply-To: <20031223114644.GA5458@sonycom.com>
Message-ID: <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl>
References: <20031223114644.GA5458@sonycom.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 23 Dec 2003, Dimitri Torfs wrote:

>   I just upgraded to the arch/mips/Makefile which adds support for newer
>   gcc/gas options. I now get the warning
> 
>   "cc1: warning: The -march option is incompatible to -mipsN and therefore
> +ignored."
> 
>   when compiling. I have the CONFIG_CPU_VR41XX option set, which sets
>   the c-flags to:
> 
>   "-I /home/dimitri/work/linux/include/asm/gcc -G 0 -mno-abicalls
>   -fno-pic -pipe  -finline-limit=100000 -mabi=32 -march=r4100 -mips3
>   -Wa,-32 -Wa,-march=r4100 -Wa,-mips3 -Wa,--trap"
> 
>   I suppose that for the newer gcc versions only -march= should be
>   set (I'm using gcc-3.2.2) ?

 Thanks for the report -- I suppose we can remove "-mips" whenever
"-mabi=" is supported by gcc.  I'll do an update in January after I am 
back from vacation.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
