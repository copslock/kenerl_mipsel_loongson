Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:53:34 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:4485 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225195AbTC1AxG>;
	Fri, 28 Mar 2003 00:53:06 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 14AB946BA6; Fri, 28 Mar 2003 01:51:38 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: cswitch not defined if !CONFIG_VT
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:51:38 +0100
Message-ID: <m21y0sb9et.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
	cswitch is only used when CONFIG_VT is defined.

Later, Juan.


 build/arch/mips/sgi-ip22/ip22-setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN build/arch/mips/sgi-ip22/ip22-setup.c~cswitch_only_needed_by_VT build/arch/mips/sgi-ip22/ip22-setup.c
--- 24/build/arch/mips/sgi-ip22/ip22-setup.c~cswitch_only_needed_by_VT	2003-03-28 00:15:26.000000000 +0100
+++ 24-quintela/build/arch/mips/sgi-ip22/ip22-setup.c	2003-03-28 00:15:50.000000000 +0100
@@ -142,8 +142,9 @@ void __init ip22_setup(void)
 	/* Now enable boardcaches, if any. */
 	indy_sc_init();
 #endif
+#ifdef CONFIG_VT
 	conswitchp = NULL;
-
+#endif
 	/* Set the IO space to some sane value */
 	set_io_port_base (KSEG1ADDR (0x00080000));
 

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
