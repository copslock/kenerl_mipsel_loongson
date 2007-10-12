Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 17:02:30 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:34706 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20025935AbXJLQCW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2007 17:02:22 +0100
Received: (qmail invoked by alias); 12 Oct 2007 16:01:16 -0000
Received: from p548B3B2F.dip0.t-ipconnect.de (EHLO [192.168.120.22]) [84.139.59.47]
  by mail.gmx.net (mp004) with SMTP; 12 Oct 2007 18:01:16 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX194sQBXmw94scUhHCMjGdbrxu0vAFvVPmhn4aqSds
	VuRQx5yEAZxWmk
Message-ID: <470F9A4A.3060301@gmx.de>
Date:	Fri, 12 Oct 2007 18:01:14 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 1.5.0.12 (X11/20060911)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	fbuihuu@gmail.com, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] tlbex.c: Cleanup __init usages.
References: <470F16B9.7030406@gmail.com>	<470F170E.1060303@gmail.com> <20071012.180742.59650681.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20071012.180742.59650681.nemoto@toshiba-tops.co.jp>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto schrieb:
> On Fri, 12 Oct 2007 08:41:18 +0200, Franck Bui-Huu <fbuihuu@gmail.com> wrote:
>>  #define I_0(op)							\
>> -	static inline void __init i##op(u32 **buf)		\
>> +	static inline void i##op(u32 **buf)		\
>>  	{							\
>>  		build_insn(buf, insn##op);			\
>>  	}
> 
> This causes section mismatches, since i_tlbwr and i_tlbwi can not be
> inlined (see head of build_tlb_write_entry()).
> 
> Maybe __init __maybe_unused is preferred?
> 
> ---
> Atsushi Nemoto
> 

Hi

I got the error too.

If build_tlb_write_entry() is inlined it doesent happen.

But as it is already reverted maybe it is not so importent.

bye tanzy
