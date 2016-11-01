Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 12:50:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22973 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993115AbcKALuNvGbRo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 12:50:13 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7D7E4F2E255E7;
        Tue,  1 Nov 2016 11:50:03 +0000 (GMT)
Received: from [10.20.78.238] (10.20.78.238) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 1 Nov 2016
 11:50:05 +0000
Date:   Tue, 1 Nov 2016 11:49:56 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] MIPS: Fix ISA I/II FP signal context offsets
In-Reply-To: <1814661.4I5xJD6gaP@np-p-burton>
Message-ID: <alpine.DEB.2.00.1611011131120.31859@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1610310319010.31859@tp.orcam.me.uk> <alpine.DEB.2.00.1610310407150.31859@tp.orcam.me.uk> <1814661.4I5xJD6gaP@np-p-burton>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.238]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55637
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

On Tue, 1 Nov 2016, Paul Burton wrote:

> BTW, do you have a feel for whether there's a good r2k/r3k platform (ideal 
> would be some software emulator if any are good enough) that we could hook up 
> to our continuous integration system? That would help us to catch any 
> regressions like this in future before they hit mainline.

 I know about no such platform I'm afraid.

 QEMU does not have the R2k/R3k exception/MMU/cache model and implementing 
that would be a considerable effort I see no volunteers for.  I haven't 
heard of any other simulator which might be closer to implementing that 
model.

 As to using real hardware -- I might be the closest myself to be capable 
of doing some automated testing as I have an R3k machine in my home lab 
wired for remote control.  It could track Ralf's `mips-for-linux-next' 
branch and watch out for regressions, by trying to build and boot kernels 
automatically on a regular basis; maybe doing some further validation 
even, such as running GCC or glibc regression testing.  But while the 
target is ready I'm still missing the host-side setup, which I haven't 
completed.  I don't think there's any other hardware readily available 
which could be hooked somewhere.

 So for the time being I think we need to continue relying on people 
spotting issues by hand.  I think we've been doing pretty good overall.

 Thanks for your review.

  Maciej
