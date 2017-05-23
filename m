Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 00:22:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38480 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994944AbdEWWW3Chr0c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 00:22:29 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 58EDD37B99EDE;
        Tue, 23 May 2017 23:22:18 +0100 (IST)
Received: from [10.20.78.51] (10.20.78.51) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 23 May 2017
 23:22:21 +0100
Date:   Tue, 23 May 2017 23:21:44 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS16e2: Provide feature overrides for non-MIPS16
 systems
In-Reply-To: <5cb0253e-8523-bf57-722a-a5ea19873121@gmail.com>
Message-ID: <alpine.DEB.2.00.1705232220190.2590@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk> <alpine.DEB.2.00.1705230345530.2590@tp.orcam.me.uk> <5cb0253e-8523-bf57-722a-a5ea19873121@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.51]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57976
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

On Tue, 23 May 2017, Florian Fainelli wrote:

> > Hardcode the absence of the MIPS16e2 ASE for all the systems that do so 
> > for the MIPS16 ASE already, providing for code to be optimized away.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> > ---
> 
> Could you switch to using git format-patch such that we have a diffstat
> at the beginning of the patch which helps the reviewer figure out which
> files are being touched?

 My workflow that I have found efficient and I have been using for years 
now does not involve using GIT for outstanding patch management, so I 
don't think I can adjust to your request easily, without losing that 
efficiency or introducing processing errors from the additional final GIT 
import step.

 However separate `diffstat' information is redundant in that it is 
already carried by the patch itself and can be easily recreated by piping 
the containing e-mail to `diffstat' from the MUA while reading the 
message.  Is that a solution that would work for you?

> It just occurred to me that a bunch of other platforms are lacking a
> cpu-feature-overrides.h file, but presumably would never be able to
> support mips16e2, like ar7, emma2rh, pnx833x and so on.

 I have explicitly noted in the change description that only platforms 
that already have an override for the base MIPS16 ASE have been changed 
(for consistency, anyway).  It's an optimisation only anyway, not a 
correctness issue.

 If there are platforms that may or may not have the MIPS16 ASE available, 
however are known to never have the MIPS16e2 ASE in the future, e.g. 
because they have been already obsoleted and no new CPU modules will ever 
be introduced, then the respective platform maintainers can add an 
override if desired.

  Maciej
