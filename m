Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 17:10:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25651 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992663AbcKDQJyK7pr5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 17:09:54 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C3F1E65F2F007;
        Fri,  4 Nov 2016 16:09:44 +0000 (GMT)
Received: from [10.20.78.29] (10.20.78.29) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 4 Nov 2016
 16:09:47 +0000
Date:   Fri, 4 Nov 2016 16:09:37 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>
Subject: Re: [PATCH] MIPS: VDSO: Always select -msoft-float
In-Reply-To: <20161104152603.GB12009@roeck-us.net>
Message-ID: <alpine.DEB.2.00.1611041558460.13938@tp.orcam.me.uk>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net> <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk> <20161101233038.GA25472@roeck-us.net> <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
 <20161104152603.GB12009@roeck-us.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.29]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55672
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

> > As above, unless absolutely critical to have floating point code then
> > the vDSO should just avoid all FP related issues and build soft-float.
> 
> FWIW, my logic was quite simple: The rest of the kernel builds with
> -msoft-float, thus vDSO should do the same. Of course, I don't know the
> entire context, so there may well be a reason to handle it differently
> than the rest of the kernel.

 VDSO is not a part of the kernel, it's user mode code, made visible in 
the user virtual memory, and implicitly loaded along the rest of the DSOs 
on program startup by the dynamic loader (ld.so).  It has to be PIC for 
that reason, too, causing all the hassle we had with making it such that 
it does not need a GOT.

> Anyway, isn't the kernel supposed to not use floating point operations
> in the first place ? Is this different for vDSO ?

 This code is executed in the user mode so while floating-point code may 
not be needed there, not at least right now, there's actually nothing 
which should stop us from from adding some should such a need arise.

  Maciej
