Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:36:31 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:48356 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225316AbSLRBg3>;
	Wed, 18 Dec 2002 01:36:29 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id AECE6D657; Wed, 18 Dec 2002 02:42:25 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: 
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:42:25 +0100
Message-ID: <m2smwwqf0e.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        ArcRead() usses funny types :(

Later, Juan.a

PD. Someone can explain me what mean:
    __attribute__ ((__mode__ (__SI__)));

    The SI part don't appear in the gcc info pages :(

Index: arch/mips/sgi-ip22/ip22-time.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-time.c,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 ip22-time.c
--- arch/mips/sgi-ip22/ip22-time.c	2 Dec 2002 00:24:50 -0000	1.1.2.10
+++ arch/mips/sgi-ip22/ip22-time.c	18 Dec 2002 00:49:20 -0000
@@ -195,7 +195,7 @@
 {
 	int cpu = smp_processor_id();
 	int irq = SGI_8254_0_IRQ;
-	long cnt;
+	ULONG cnt;
 	char c;
 
 	irq_enter(cpu, irq);


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
