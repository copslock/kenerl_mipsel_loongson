Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 02:07:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54369 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025966AbcDGAHFTxw5q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2016 02:07:05 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 109093A5A9843;
        Thu,  7 Apr 2016 01:06:54 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 7 Apr 2016 01:06:59 +0100
Received: from localhost (10.100.200.148) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 7 Apr
 2016 01:06:58 +0100
Date:   Thu, 7 Apr 2016 01:06:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 4.1: XPA breaks Alchemy
Message-ID: <20160407000658.GA11065@NP-P-BURTON>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.148]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52916
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

On Thu, Apr 30, 2015 at 07:34:06PM +0200, Manuel Lauss wrote:
> Hi Steve,
> 
> your patch commit c5b367835cfc7a8ef53b9670a409ffcc95194344
> ("MIPS: Add support for XPA") breaks userspace on my Alchemy systems,
> everything is killed with error -14:
> 
> Kernel panic - not syncing: Requested init /bin/sh failed (error -14).
> 
> Reverting that patch fixes everything.  I bet it's related to the 36bit
> address space in some way.
> 
> Thanks!
>      Manuel

Hi Manuel,

I don't suppose you'd be able to try this kernel branch?

    https://git.linux-mips.org/cgit/paul/linux.git/log/?h=v4.6-tlb

    git://git.linux-mips.org/pub/scm/paul/linux.git -b v4.6-tlb

I'm working on fixing up a number of issues with commit c5b367835cfc
("MIPS: Add support for XPA.") but unfortunately don't have access to
any Alchemy systems to test it myself.

Thanks,
    Paul
