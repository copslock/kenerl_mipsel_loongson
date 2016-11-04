Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 19:06:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45927 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993082AbcKDSG11iLuH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 19:06:27 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9322A6F3AA85C;
        Fri,  4 Nov 2016 18:06:17 +0000 (GMT)
Received: from [10.20.78.29] (10.20.78.29) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 4 Nov 2016
 18:06:20 +0000
Date:   Fri, 4 Nov 2016 18:06:12 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>
Subject: Re: [PATCH] MIPS: VDSO: Always select -msoft-float
In-Reply-To: <20161104165047.GA29628@roeck-us.net>
Message-ID: <alpine.DEB.2.00.1611041736110.13938@tp.orcam.me.uk>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net> <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk> <20161101233038.GA25472@roeck-us.net> <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
 <20161104152603.GB12009@roeck-us.net> <alpine.DEB.2.00.1611041558460.13938@tp.orcam.me.uk> <20161104165047.GA29628@roeck-us.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.29]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 4 Nov 2016, Guenter Roeck wrote:

> >  This code is executed in the user mode so while floating-point code may 
> > not be needed there, not at least right now, there's actually nothing 
> > which should stop us from from adding some should such a need arise.
> > 
> Just for my understanding - so the code is compiled with the kernel and part
> of the kernel source but executed in user mode ?

 Yes, that's correct.

 The idea behind VDSO is to export some kernel data to the userland in a 
way making it possible to avoid the considerable overhead of making a 
syscall, i.e. the whole dance required to switch to the kernel mode, make 
the necessary arrangements there for kernel mode execution such as stack 
switching (see the SAVE_SOME macro), actually retrieve the data requested, 
undo the kernel mode execution arrangements (RESTORE_SOME) and finally 
resume user mode execution.

 So instead a page is mapped by the kernel in the user virtual memory with 
designated entry points comprising the public API and the actual 
implementation which retrieves the data requested in a varying way, 
depending on the kernel configuration, hardware features, etc., so it is 
tightly coupled with the kernel and has to be built along it.  These entry 
points are then used by the C library instead of their corresponding 
syscalls.

 A good use example is a replacement for gettimeofday(2).  This syscall 
retrieves a tiny amount of data which is frequently requested e.g. by X 
servers which want to individually timestamp their events.  So the gain 
from avoiding making this syscall and instead retrieving the data 
requested straight in the user mode is enormous.

> If you ever add real floating point code, doesn't that also mean that you'll
> have to implement the necessary linker helper functions or wrappers (such
> as the wrappers needed for 64-bit integer divide operations in 32 bit code) ?

 No, you could just link the VDSO with `-lgcc' instead and get all the 
necessary bits from there, as usually in user code.  Although if building 
for compat ABIs as well you'd have to ensure you have GCC libraries built 
and installed for all the ABIs required, which in turn depends on the 
configuration chosen for the compiler at its build time.  Not a problem 
right now though as we don't need any of this stuff.

 HTH,

  Maciej
