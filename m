Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 12:08:59 +0000 (GMT)
Received: from [81.2.74.5] ([81.2.74.5]:52375 "EHLO mail.linux-mips.net")
	by ftp.linux-mips.org with ESMTP id S23743414AbYKRMIv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2008 12:08:51 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.14.2/8.14.2) with ESMTP id mAIBrvub008510;
	Tue, 18 Nov 2008 11:55:17 GMT
Received: (from ralf@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) id mAIBruvS008508;
	Tue, 18 Nov 2008 11:53:56 GMT
Date:	Tue, 18 Nov 2008 11:53:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Prasad B <bprasad@cs.arizona.edu>
Cc:	linux-mips@linux-mips.org
Subject: Re: traditional signal support in 64-bit mips linux
Message-ID: <20081118115356.GA7700@linux-mips.org>
References: <e8180c7f0811171324i35da6933mc29ce386afb7393a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8180c7f0811171324i35da6933mc29ce386afb7393a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@mail.linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 17, 2008 at 01:24:07PM -0800, Prasad B wrote:

> Is traditional signal support, enabled by the flag CONFIG_TRAD_SIGNALS
> proscribed in 64-bit mode ?

Yes - and there is no reason to do so.  None of the libcs would use the
functionality and it's not experted through the syscall interface anyway.

> In arch/mips/kernel/signal.c, functions sys_sigsuspend(), sys_sigaction(),
> sys_sigreturn(), setup_frame() are conditionally compiled, depending on
> whether the flag CONFIG_TRAD_SIGNALS is defined or not. If one defines the
> constant, the compilation fails as the constants such as __NR_sigreturn are
> not defined in asm-mips/unistd.h for 64-bit mips.
> 
> 
> Does it mean that only realtime signals are supposed to be used in 64-bit
> mode ?

Yes - with the exception of O32 binary compatibility which uses a compat
implementation of these functions anyway.  Traditional signal support is
deprecated since like 10 years.

  Ralf
