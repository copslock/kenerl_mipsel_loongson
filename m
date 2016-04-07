Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 08:50:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34476 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025661AbcDGGuqJwpyC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2016 08:50:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 2020D259D06AB;
        Thu,  7 Apr 2016 07:50:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 7 Apr 2016 07:50:39 +0100
Received: from localhost (10.100.200.148) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 7 Apr
 2016 07:50:39 +0100
Date:   Thu, 7 Apr 2016 07:50:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: 4.1: XPA breaks Alchemy
Message-ID: <20160407065038.GC20863@NP-P-BURTON>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
 <20160407000658.GA11065@NP-P-BURTON>
 <20160407055813.GD26267@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20160407055813.GD26267@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.148]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Thu, Apr 07, 2016 at 07:58:13AM +0200, Ralf Baechle wrote:
> On Thu, Apr 07, 2016 at 01:06:58AM +0100, Paul Burton wrote:
> 
> > 
> > I don't suppose you'd be able to try this kernel branch?
> > 
> >     https://git.linux-mips.org/cgit/paul/linux.git/log/?h=v4.6-tlb
> > 
> >     git://git.linux-mips.org/pub/scm/paul/linux.git -b v4.6-tlb
> > 
> > I'm working on fixing up a number of issues with commit c5b367835cfc
> > ("MIPS: Add support for XPA.") but unfortunately don't have access to
> > any Alchemy systems to test it myself.
> 
> The unique architecural feature of Alchemy is that it has devices such as
> the PCI bus outside the low 4GB of physical address space.  So I'd
> suspect something is wrong there.
> 
> Everybody is running Sibyte 64 bit; I wonder if highmem with Sibyte is
> also affected.
> 
>   Ralf

Hi Ralf,

The problem is anywhere that formerly used 64 bit physical addresses
(CONFIG_PHYS_ADDR_T_64BIT) with a MIPS32 CPU (CONFIG_CPU_MIPS32), since
the XPA support essentially clobbered all that code with the XPA
implementation rather than treating them as the distinct cases that they
are. My fix is over here, and I'll submit it for merging in the v4.7
cycle (I guess I could submit now as it's a fix, but it's built atop
some rework of pgtable-bits.h to make it more readable so would need
that to go in too):

    https://git.linux-mips.org/cgit/paul/linux.git/commit/?h=v4.6-tlb&id=3a74e3b7bcb1b392da2400ff27ee4e41989dd54f

Thanks,
    Paul
