Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 17:51:03 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:56517 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992663AbcKDQu4RUrQv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 17:50:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=wqPAzB8bhmOiXfmEV7zbeS6ZAwcuzYq9pWwgjeh1YzE=; b=VIiMbxyYNgV/fQQjNawxN9cjuM
        pCrBMlUhsJjZLBK/uDaq3A87MyQEqhWjtigb/J+hJRGMv1TYMuErheZFJTWi756SGbUu8t1U0NXZ3
        Sxn09hYjJEpXzT22tyx40ZoAKBISUD6fWk0gGo8xiQ1PFvFjV3hFQrfoGprDfiISJWpZOslKCb6xL
        Y89RhPqABNlaj1sVRaUx1cntC3ImPsn6ufNaL6FeO4k7WvIjTblAtJ+Ne7CQ+DvQe2AMPzrhbTUJh
        MNv9vwUlZ+Q7goqsO0mL1GOcSrJ3AoieBfdypbE2bVzJhu2Z1v9kz+46bdxLaFuQ9UUakPFpy0WV3
        s0y5mICQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54094 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1c2hhV-001L2u-5X; Fri, 04 Nov 2016 16:50:45 +0000
Date:   Fri, 4 Nov 2016 09:50:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>
Subject: Re: [PATCH] MIPS: VDSO: Always select -msoft-float
Message-ID: <20161104165047.GA29628@roeck-us.net>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net>
 <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk>
 <20161101233038.GA25472@roeck-us.net>
 <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
 <20161104152603.GB12009@roeck-us.net>
 <alpine.DEB.2.00.1611041558460.13938@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1611041558460.13938@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Nov 04, 2016 at 04:09:37PM +0000, Maciej W. Rozycki wrote:
> On Fri, 4 Nov 2016, Guenter Roeck wrote:
> 
> > > As above, unless absolutely critical to have floating point code then
> > > the vDSO should just avoid all FP related issues and build soft-float.
> > 
> > FWIW, my logic was quite simple: The rest of the kernel builds with
> > -msoft-float, thus vDSO should do the same. Of course, I don't know the
> > entire context, so there may well be a reason to handle it differently
> > than the rest of the kernel.
> 
>  VDSO is not a part of the kernel, it's user mode code, made visible in 
> the user virtual memory, and implicitly loaded along the rest of the DSOs 
> on program startup by the dynamic loader (ld.so).  It has to be PIC for 
> that reason, too, causing all the hassle we had with making it such that 
> it does not need a GOT.
> 
> > Anyway, isn't the kernel supposed to not use floating point operations
> > in the first place ? Is this different for vDSO ?
> 
>  This code is executed in the user mode so while floating-point code may 
> not be needed there, not at least right now, there's actually nothing 
> which should stop us from from adding some should such a need arise.
> 
Just for my understanding - so the code is compiled with the kernel and part
of the kernel source but executed in user mode ?

If you ever add real floating point code, doesn't that also mean that you'll
have to implement the necessary linker helper functions or wrappers (such
as the wrappers needed for 64-bit integer divide operations in 32 bit code) ?

Thanks,
Guenter
