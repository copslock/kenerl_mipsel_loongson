Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 07:52:14 +0100 (BST)
Received: from gw01.mail.saunalahti.fi ([IPv6:::ffff:195.197.172.115]:5796
	"EHLO gw01.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8224915AbUHQGwK>; Tue, 17 Aug 2004 07:52:10 +0100
Received: from fairytale.tal.org (cruel.tal.org [195.16.220.85])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id F29374C9F8
	for <linux-mips@linux-mips.org>; Tue, 17 Aug 2004 09:52:07 +0300 (EEST)
Received: from amos (unknown [195.16.220.84])
	by fairytale.tal.org (Postfix) with SMTP id A41878DB0
	for <linux-mips@linux-mips.org>; Tue, 17 Aug 2004 10:00:40 +0300 (EEST)
Message-ID: <001901c48427$6272acd0$54dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: "linux-mips" <linux-mips@linux-mips.org>
Subject: cpu_has_llsc cleanup broke compilation.
Date: Tue, 17 Aug 2004 09:56:53 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

The "using cpu_has_llsc cleanup all users of ll/sc and lld/scd." broke
compilation:

  CC      arch/mips/kernel/offset.s
In file included from include/asm/bitops.h:35,
                 from include/linux/bitops.h:4,
                 from include/linux/thread_info.h:20,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/mips/kernel/offset.c:14:
include/asm/system.h: In function `__xchg_u32':
include/asm/system.h:285: error: `cpu_data' undeclared (first use in this
function)
include/asm/system.h:285: error: (Each undeclared identifier is reported
only once
include/asm/system.h:285: error: for each function it appears in.)
include/asm/system.h:285: error: `MIPS_CPU_LLSC' undeclared (first use in
this function)
include/asm/system.h: In function `__cmpxchg_u32':
include/asm/system.h:382: error: `cpu_data' undeclared (first use in this
function)
include/asm/system.h:382: error: `MIPS_CPU_LLSC' undeclared (first use in
this function)
In file included from include/linux/bitops.h:4,
                 from include/linux/thread_info.h:20,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/mips/kernel/offset.c:14:
include/asm/bitops.h: In function `set_bit':
include/asm/bitops.h:72: error: `cpu_data' undeclared (first use in this
function)
include/asm/bitops.h:72: error: `MIPS_CPU_LLSC' undeclared (first use in
this function)
include/asm/bitops.h: In function `clear_bit':
include/asm/bitops.h:124: error: `cpu_data' undeclared (first use in this
function)
include/asm/bitops.h:124: error: `MIPS_CPU_LLSC' undeclared (first use in
this function)
include/asm/bitops.h: In function `change_bit':
include/asm/bitops.h:172: error: `cpu_data' undeclared (first use in this
function)
include/asm/bitops.h:172: error: `MIPS_CPU_LLSC' undeclared (first use in
this function)
include/asm/bitops.h: In function `test_and_set_bit':
include/asm/bitops.h:223: error: `cpu_data' undeclared (first use in this
function)
include/asm/bitops.h:223: error: `MIPS_CPU_LLSC' undeclared (first use in
this function)
include/asm/bitops.h: In function `test_and_clear_bit':
include/asm/bitops.h:295: error: `cpu_data' undeclared (first use in this
function)
include/asm/bitops.h:295: error: `MIPS_CPU_LLSC' undeclared (first use in
this function)
include/asm/bitops.h: In function `test_and_change_bit':
include/asm/bitops.h:368: error: `cpu_data' undeclared (first use in this
function)
include/asm/bitops.h:368: error: `MIPS_CPU_LLSC' undeclared (first use in
this function)
In file included from include/asm/thread_info.h:16,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/mips/kernel/offset.c:14:
include/asm/processor.h: At top level:
include/asm/processor.h:82: error: `cpu_data' used prior to declaration
make[1]: *** [arch/mips/kernel/offset.s] Error 1
make: *** [arch/mips/kernel/offset.s] Error 2
-- 
Kaj-Michael Lang , milang@tal.org
