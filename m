Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 13:49:18 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:64015 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225234AbTCGNtR>;
	Fri, 7 Mar 2003 13:49:17 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 17BCD7BC; Fri,  7 Mar 2003 14:48:56 +0100 (CET)
To: "Kip Walker" <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3E677B94.AE22C65D@broadcom.com> ("Kip Walker"'s message of
 "Thu, 06 Mar 2003 08:47:16 -0800")
References: <20030220113404.E7466@mvista.com> <3E63B047.D3BA2A2C@broadcom.com>
	<86d6l8fcvv.fsf@trasno.mitica> <3E677B94.AE22C65D@broadcom.com>
Date: Fri, 07 Mar 2003 14:48:56 +0100
Message-ID: <86u1efp9rr.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "kip" == Kip Walker <kwalker@broadcom.com> writes:

Hi again

kip> diff -u -r1.78.2.23 Makefile
kip> --- arch/mips/Makefile	26 Feb 2003 21:14:23 -0000	1.78.2.23
kip> +++ arch/mips/Makefile	6 Mar 2003 16:43:59 -0000
kip> @@ -41,11 +41,11 @@
kip> LINKFLAGS	+= -G 0 -static # -N
kip> MODFLAGS	+= -mlong-calls
 
kip> -ifdef CONFIG_KGDB
kip> +ifdef CONFIG_DEBUG_INFO
kip> GCCFLAGS	+= -g
kip> +endif
kip> ifdef CONFIG_SB1XXX_CORELIS
kip> GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer
kip> -endif
kip> endif
 
I have no idea what the Corelis debugger is, but I assume that putting
it configuration out of the CONFIG_KGDB is intentional?  It doesn't
require the -g option?

Later, Juan.
-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
