Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Mar 2005 08:58:39 +0000 (GMT)
Received: from news.ti.com ([IPv6:::ffff:192.94.94.33]:39935 "EHLO
	dragon.ti.com") by linux-mips.org with ESMTP id <S8224939AbVCSI6Y> convert rfc822-to-8bit;
	Sat, 19 Mar 2005 08:58:24 +0000
Received: from dlep91.itg.ti.com ([157.170.152.55])
	by dragon.ti.com (8.13.1/8.13.1) with ESMTP id j2J8wJZC020306
	for <linux-mips@linux-mips.org>; Sat, 19 Mar 2005 02:58:19 -0600 (CST)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep91.itg.ti.com (8.12.11/8.12.11) with ESMTP id j2J8wIFZ019027
	for <linux-mips@linux-mips.org>; Sat, 19 Mar 2005 02:58:18 -0600 (CST)
Received: from dlee2k71.ent.ti.com (localhost [127.0.0.1])
	by dlep90.itg.ti.com (8.12.11/8.12.11) with ESMTP id j2J8wI74004442
	for <linux-mips@linux-mips.org>; Sat, 19 Mar 2005 02:58:18 -0600 (CST)
Received: from dbde2k01.ent.ti.com ([172.24.170.180]) by dlee2k71.ent.ti.com with Microsoft SMTPSVC(5.0.2195.6747);
	 Sat, 19 Mar 2005 02:58:18 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: About PLAT_TRAMPOLINE_STUFF_LINE
Date:	Sat, 19 Mar 2005 14:26:14 +0530
Message-ID: <F6B01C6242515443BB6E5DDD63AE935F046852@dbde2k01.itg.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: About PLAT_TRAMPOLINE_STUFF_LINE
Thread-Index: AcUsYYFK2OIenZCYSB67zg2UwXcFrA==
From:	"Nori, Soma Sekhar" <nsekhar@ti.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 19 Mar 2005 08:58:18.0074 (UTC) FILETIME=[CB183BA0:01C52C61]
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
Precedence: bulk
X-list: linux-mips


Hi,

I am porting 2.6.10 (kernel.org) onto a 4kec based board.

What should be the value of PLAT_TRAMPOLINE_STUFF_LINE 
(include/asm-mips/cpu-features.h) for 4kec?

If I do not define a cpu-features-overrides.h for my board, this macro
is 
getting set to 0 and as a result signalling code in kernel 
(arch/mips/kernel/signal.c) seems to break. 
All my userspace programs using signals are seg faulting.

Here is the faulting code:

<code>
static void inline setup_frame(struct k_sigaction * ka, struct pt_regs
*regs,
	int signr, sigset_t *set)
{
	struct sigframe *frame;
	int err = 0;

	frame = get_sigframe(ka, regs, sizeof(*frame));
	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
		goto give_sigsegv;

	/*
	 * Set up the return code ...
	 *
	 *         li      v0, __NR_sigreturn
	 *         syscall
	 */
	if (PLAT_TRAMPOLINE_STUFF_LINE)
		__builtin_memset(frame->sf_code, '0',
		                 PLAT_TRAMPOLINE_STUFF_LINE);
	err |= __put_user(0x24020000 + __NR_sigreturn, frame->sf_code +
0);
	err |= __put_user(0x0000000c                 , frame->sf_code +
1);
	flush_cache_sigtramp((unsigned long) frame->sf_code);

	err |= setup_sigcontext(regs, &frame->sf_sc);
	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
	if (err)
		goto give_sigsegv;
    
    ...
</code>    
        

With PLAT_TRAMPOLINE_STUFF_LINE set to 0, get_sigframe always returns 0
and setup_frame sends a SIGSEGV because __put_user returns an error
value.

When I override the value of PLAT_TRAMPOLINE_STUFF_LINE to 16 (the cache
line size of the 4kec), the signalling code seems to work just fine. 
(None of my userspace programs crash anymore).

This macro does not seem to be overridden for most boards, so 0 must be 
a valid value for atleast some MIPS CPUs. 

Am I right in changing the value of PLAT_TRAMPOLINE_STUFF_LINE to 16?

A google search on this macro did not yield much information.

Any help/pointers regarding this is greatly appreciated.

Thanks,
Sekhar Nori.
