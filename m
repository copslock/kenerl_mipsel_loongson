Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2011 02:03:19 +0100 (CET)
Received: from [12.108.191.235] ([12.108.191.235]:17121 "EHLO
        mail3.caviumnetworks.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491926Ab1BABDQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Feb 2011 02:03:16 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d475c030000>; Mon, 31 Jan 2011 17:04:03 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 31 Jan 2011 17:03:13 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 31 Jan 2011 17:03:12 -0800
Message-ID: <4D475BCB.9050403@caviumnetworks.com>
Date:   Mon, 31 Jan 2011 17:03:07 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Earl Chew <echew@ixiacom.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Filling in struct mips64_watch_regs from a 32 bit process
References: <4D4756B5.4010100@ixiacom.com>
In-Reply-To: <4D4756B5.4010100@ixiacom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2011 01:03:12.0998 (UTC) FILETIME=[CCD09060:01CBC1AB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/31/2011 04:41 PM, Earl Chew wrote:
> I notice that a 32 bit process running on a 64 bit kernel is expected to
> know that it should fill in mips64_watch_regs --- even though it is running
> against a 32 bit ABI.
>
> Is this an oversight, or am I missing something ?

It is intentional.

>
> [ That same 32 bit process must fill in mips32_watch_regs when running on
>    a 32 bit kernel. ]
>
>
> In arch/mips/include/asm/ptrace.h:
>
> struct mips32_watch_regs {
> 	unsigned int watchlo[8];
> 	...
> };
>
> and
>
> struct mips64_watch_regs {
> 	unsigned long long watchlo[8];
> 	...
> };
>
> These are used in a union, but sizeof(mips64_watch_regs.watchlo) will not
> match sizeof(mips32_watch_regs.watchlo).
>

The sizes are different and thus are ... different.  struct 
pt_watch_regs however, has a well defined size.

The important thing is that the style element of struct pt_watch_regs is 
always in the same place.

>
>
> For a 64 bit kernel, the code in arch/mips/kernel/ptrace.c reads:
>
>
>          /* Check the values. */
>          for (i = 0; i<  current_cpu_data.watch_reg_use_cnt; i++) {
>                  __get_user(lt[i],&addr->WATCH_STYLE.watchlo[i]);
> #ifdef CONFIG_32BIT
>                  if (lt[i]&  __UA_LIMIT)
>                          return -EINVAL;
> #else
>                  if (test_tsk_thread_flag(child, TIF_32BIT_ADDR)) {
>                          if (lt[i]&  0xffffffff80000000UL)
>                                  return -EINVAL;
>                  } else {
>                          if (lt[i]&  __UA_LIMIT)
>                                  return -EINVAL;
>                  }
> #endif
>
>
> Thus for a 64 bit kernel, WATCH_STYLE is defined to be mips64, and the code
> goes on to obtain:
>
> 	addr->mips64.watchlo[i]
>
> and to verify it based on TIF_32BIT_ADDR.
>
>
> In other words, the 32 bit process is expected to fill in mips64_watch_regs
> when it is running on a 64 bit kernel, and mips32_watch_regs when it is running
> on a 32 bit kernel.
>

Yes.  The debugging agent must check struct pt_watch_regs style to 
determine which type of watch registers the hardware is using.

Take a look at how GDB handles this in mips-linux-nat.c.

David Daney
