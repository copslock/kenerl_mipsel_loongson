Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Feb 2005 10:56:54 +0000 (GMT)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:63886 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8224987AbVBLK4i> convert rfc822-to-8bit;
	Sat, 12 Feb 2005 10:56:38 +0000
Received: from dlep91.itg.ti.com ([157.170.152.55])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id j1CAuWdK008735;
	Sat, 12 Feb 2005 04:56:32 -0600 (CST)
Received: from dbde2k01.ent.ti.com (localhost [127.0.0.1])
	by dlep91.itg.ti.com (8.12.11/8.12.11) with ESMTP id j1CAuTqd007197;
	Sat, 12 Feb 2005 04:56:31 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] Using JR instead of J instruction for jumping to IRQ handler.
Date:	Sat, 12 Feb 2005 16:26:29 +0530
Message-ID: <F6B01C6242515443BB6E5DDD63AE935F046834@dbde2k01.itg.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Using JR instead of J instruction for jumping to IRQ handler.
Thread-Index: AcUQ8YEwNbMGh39vSYeT7CEO3F7rjg==
From:	"Nori, Soma Sekhar" <nsekhar@ti.com>
To:	<linux-mips@linux-mips.org>
Cc:	<ralf@linux-mips.org>
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
Precedence: bulk
X-list: linux-mips


Hi Ralf,

Attached patch attempts to use load address k0, <handler> followed by
jump register k0 to jump to the MIPS IRQ handler from CAC_BASE + 0x200
instead of just jump <handler>. This will enable jumping even if IRQ
handler is linked at high kernel logical address. (like 0x94000000+).

I have tested this to work fine on my 4kec. (Not sure if the code will
hold good for MIPS64 though)

Thanks,
Sekhar Nori.

--- linux.orig/arch/mips/kernel/traps.c 2004-12-25 03:04:32.000000000
+0530
+++ linux/arch/mips/kernel/traps.c      2005-02-12 14:53:32.465876000
+0530
@@ -848,9 +848,12 @@

        exception_handlers[n] = handler;
        if (n == 0 && cpu_has_divec) {
-               *(volatile u32 *)(CAC_BASE + 0x200) = 0x08000000 |
-                                                (0x03ffffff & (handler
>> 2));
-               flush_icache_range(CAC_BASE + 0x200, CAC_BASE + 0x204);
+               *(volatile u32 *)(CAC_BASE + 0x200) = 0x3c1a0000 |
+                                        (handler >> 16);
+               *(volatile u32 *)(CAC_BASE + 0x204) = 0x375a0000 |
+                                        (handler & 0xFFFF);
+               *(volatile u32 *)(CAC_BASE + 0x208) = 0x03400008;
+               flush_icache_range(CAC_BASE + 0x200, CAC_BASE + 0x20C);

        }
        return (void *)old_handler;
 }
