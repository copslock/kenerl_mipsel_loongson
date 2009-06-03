Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 07:17:03 +0100 (WEST)
Received: from mail.windriver.com ([147.11.1.11]:43493 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022452AbZFCGQ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Jun 2009 07:16:57 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n536FXqO006142;
	Tue, 2 Jun 2009 23:15:33 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 2 Jun 2009 23:15:32 -0700
Received: from [128.224.162.180] ([128.224.162.180]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 2 Jun 2009 23:15:33 -0700
Message-ID: <4A26129E.1080008@windriver.com>
Date:	Wed, 03 Jun 2009 14:05:18 +0800
From:	Wang Liming <liming.wang@windriver.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	wu zhangjin <wuzhangjin@gmail.com>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH v2 2/6] mips dynamic function tracer support
References: <cover.1243604390.git.wuzj@lemote.com>	 <a00a91f6fc79b7d20b5b2193086e879dcafded46.1243604390.git.wuzj@lemote.com>	 <4A22281B.7020908@windriver.com> <b00321320906020915n7ba241eqb3cb0de877af514d@mail.gmail.com>
In-Reply-To: <b00321320906020915n7ba241eqb3cb0de877af514d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2009 06:15:33.0455 (UTC) FILETIME=[B3D75DF0:01C9E412]
Return-Path: <liming.wang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liming.wang@windriver.com
Precedence: bulk
X-list: linux-mips

wu zhangjin wrote:
> hi,
> 
> sorry, I'm so late to reply your E-mail, a little busy these days.
>>
>> }
>> ----------arch/mips/kernel/module.c:apply_r_mips_26_rel()-------------------
>>
>> v is kernel _mcount's address, location is the address of the instrution
>> that should be relocated;
>>
>> To resolve this problem, we may need to do more work, either on gcc or on
>> the kernel. So I want to hear your test result and if you have solution,
>> please let me know.
>>
> 
> yes, current version of mips-specific dynamic ftrace not support modules yet.
> 
> there is similar solution implemented in PowerPC(something named trampoline),
> although I did not look into it, but I'm sure we can implement the
> mips-specific one
> via imitating it.
Good hit. I may have a look on Powerpc implementation.

> 
> and currently, I'm planning to fix it in the -v3 of mips-specific
> ftrace support.
OK. I'm looking forward to your -v3 patches.

Thanks.
Liming Wang
> 
> best wishes,
> Wu Zhangjin
> 
