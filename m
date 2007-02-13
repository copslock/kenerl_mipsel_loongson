Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 11:38:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:30928 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039106AbXBMLia (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 11:38:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1DBcRqQ005378;
	Tue, 13 Feb 2007 11:38:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1DBcQSg005377;
	Tue, 13 Feb 2007 11:38:26 GMT
Date:	Tue, 13 Feb 2007 11:38:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: struct sigcontext for N32 userland
Message-ID: <20070213113826.GA4569@linux-mips.org>
References: <20070213.005113.89067116.anemo@mba.ocn.ne.jp> <cda58cb80702130027o1ebec149ib25090881f7ac6a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80702130027o1ebec149ib25090881f7ac6a1@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 13, 2007 at 09:27:20AM +0100, Franck Bui-Huu wrote:

> On 2/12/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >If N32 userland refers asm-mips/sigcontext.h, struct sigcontext cause
> >some troubles.
> >
> >#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
> >
> >struct sigcontext {
> >        unsigned long   sc_regs[32];
> >...
> >
> >
> >The kernel use 64-bit for sc_regs[0], and both N32/N64 userland
> >expects it was 64-bit.  But size of 'long' on N32 is actually 32-bit.
> >So this definition make some confusion.
> >
> >glibc has its own sigcontext.h and it uses 'unsigned long long' for
> >sc_regs, so no real problem with glibc.

Looks like a case for __u32, __u64 then.

> Just out of curiosity, for what purpose does the glibc use sigcontext ?

Afair it doesn't use sigcontext itself but makes it available to
applications through <signal.h>.  Typical users are virtual machines,
JITs, debuggers, user space virtual memory.

  Ralf
