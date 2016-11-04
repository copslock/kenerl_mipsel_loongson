Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 19:34:12 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:34031 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993082AbcKDSeDSWh6o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 19:34:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=7ejJiIN65TEYhToS3ChYso2/A12Go59ZLDKX31eeAoI=; b=IwvsaHItSkL6ulkF7VH4Ob8TEJ
        nQT+Xtf9GEgWZI61WIoPcnLbqNJR8B4enbvJXq/JngHVrV0KVq4uh4HlR1C+sI+vMaeeDZQtEdwct
        kAyqS8LxN2Y7ng/6W8DZt50jwqXGnbKfw1qx5j94QlVLbf/+owYoGG5W076pmXa8jlFzUS6CTPY1h
        FbjSp3GwidzUkT0wPjL2CwuN6d1dAIaLbeLW3Ac1AQ79MV9zN1TPnIeXmETa0KfWRcscJ+iXLpo4T
        Av94UrkBAd3HLJmCSxKsPkmIHKng8MG5L8hygWydCzK/5xV1Wt2xnwCqi4uOQ4jVvhcPJaekSgLGB
        /BW+Frmg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54542 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1c2jJI-001Kf4-K3; Fri, 04 Nov 2016 18:33:53 +0000
Date:   Fri, 4 Nov 2016 11:33:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>
Subject: Re: [PATCH] MIPS: VDSO: Always select -msoft-float
Message-ID: <20161104183354.GA16694@roeck-us.net>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net>
 <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk>
 <20161101233038.GA25472@roeck-us.net>
 <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
 <20161104152603.GB12009@roeck-us.net>
 <alpine.DEB.2.00.1611041558460.13938@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B0235380AB822B@HHMAIL01.hh.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235380AB822B@HHMAIL01.hh.imgtec.org>
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
X-archive-position: 55676
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

On Fri, Nov 04, 2016 at 04:55:05PM +0000, Matthew Fortune wrote:
> Maciej Rozycki <Maciej.Rozycki@imgtec.com> writes:
> > On Fri, 4 Nov 2016, Guenter Roeck wrote:
> > 
> > > > As above, unless absolutely critical to have floating point code
> > > > then the vDSO should just avoid all FP related issues and build
> > soft-float.
> ...
> > > Anyway, isn't the kernel supposed to not use floating point operations
> > > in the first place ? Is this different for vDSO ?
> > 
> >  This code is executed in the user mode so while floating-point code may
> > not be needed there, not at least right now, there's actually nothing
> > which should stop us from from adding some should such a need arise.
> 
> Indeed. For now though the switch to -msoft-float is the simplest solution
> isn't it?
> 
One should think so, especially since 1) the code has to be built as part of the
kernel build anyway, and 2) there would be other implications besides just
adding floating point operations into the kernel (see the other e-mail).
Overall I am glad that I don't have to maintain this code.

Either case, it would be great if we can come up with a solution to avoid build
failures due to toolchain configurations. If that means that vDSO won't be
compilable with debian toolchains, so be it. After all, that would not be
different to the current situation, only it would be official instead of causing
build failures.

Thanks,
Guenter
