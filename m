Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 00:52:54 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:3461 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8224827AbTC1Aww>;
	Fri, 28 Mar 2003 00:52:52 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 2305C46BA4; Fri, 28 Mar 2003 01:51:20 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: no way to build pg.o
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Fri, 28 Mar 2003 01:51:20 +0100
Message-ID: <m265q4b9fb.fsf@neno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
	There is no file from which generate pg.o

Later, Juan.



 build/arch/mips/mm/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN build/arch/mips/mm/Makefile~pg.c_dont_exist build/arch/mips/mm/Makefile
--- 24/build/arch/mips/mm/Makefile~pg.c_dont_exist	2003-03-28 00:19:04.000000000 +0100
+++ 24-quintela/build/arch/mips/mm/Makefile	2003-03-28 00:19:18.000000000 +0100
@@ -12,7 +12,7 @@ O_TARGET := mm.o
 
 export-objs			+= ioremap.o loadmmu.o
 obj-y				+= extable.o init.o ioremap.o fault.o \
-				   pg.o loadmmu.o
+				   loadmmu.o
 
 obj-$(CONFIG_CPU_R3000)		+= pg-r3k.o c-r3k.o tlb-r3k.o tlbex-r3k.o
 obj-$(CONFIG_CPU_TX39XX)	+= pg-r3k.o c-tx39.o tlb-r3k.o tlbex-r3k.o

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
