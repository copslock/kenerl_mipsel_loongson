Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2011 01:41:35 +0100 (CET)
Received: from ixqw-mail-out.ixiacom.com ([66.77.12.12]:26688 "EHLO
        ixqw-mail-out.ixiacom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491926Ab1BAAlc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Feb 2011 01:41:32 +0100
Received: from [10.64.33.43] (10.64.33.43) by IXCA-HC1.ixiacom.com
 (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Mon, 31 Jan 2011
 16:41:25 -0800
Message-ID: <4D4756B5.4010100@ixiacom.com>
Date:   Mon, 31 Jan 2011 16:41:25 -0800
From:   Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Filling in struct mips64_watch_regs from a 32 bit process
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <EChew@ixiacom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echew@ixiacom.com
Precedence: bulk
X-list: linux-mips

I notice that a 32 bit process running on a 64 bit kernel is expected to
know that it should fill in mips64_watch_regs --- even though it is running
against a 32 bit ABI.

Is this an oversight, or am I missing something ?

[ That same 32 bit process must fill in mips32_watch_regs when running on
  a 32 bit kernel. ]


In arch/mips/include/asm/ptrace.h:

struct mips32_watch_regs {
	unsigned int watchlo[8];
	...
};

and

struct mips64_watch_regs {
	unsigned long long watchlo[8];
	...
};

These are used in a union, but sizeof(mips64_watch_regs.watchlo) will not
match sizeof(mips32_watch_regs.watchlo).



For a 64 bit kernel, the code in arch/mips/kernel/ptrace.c reads:


        /* Check the values. */
        for (i = 0; i < current_cpu_data.watch_reg_use_cnt; i++) {
                __get_user(lt[i], &addr->WATCH_STYLE.watchlo[i]);
#ifdef CONFIG_32BIT
                if (lt[i] & __UA_LIMIT)
                        return -EINVAL;
#else
                if (test_tsk_thread_flag(child, TIF_32BIT_ADDR)) {
                        if (lt[i] & 0xffffffff80000000UL)
                                return -EINVAL;
                } else {
                        if (lt[i] & __UA_LIMIT)
                                return -EINVAL;
                }
#endif


Thus for a 64 bit kernel, WATCH_STYLE is defined to be mips64, and the code
goes on to obtain:

	addr->mips64.watchlo[i]

and to verify it based on TIF_32BIT_ADDR.


In other words, the 32 bit process is expected to fill in mips64_watch_regs
when it is running on a 64 bit kernel, and mips32_watch_regs when it is running
on a 32 bit kernel.



Earl
