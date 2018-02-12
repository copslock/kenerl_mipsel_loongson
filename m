Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 16:23:27 +0100 (CET)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:54823 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbeBLPXUeoAP3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 16:23:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 731BF3F5C1;
        Mon, 12 Feb 2018 16:23:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BnokMvUDUDGh; Mon, 12 Feb 2018 16:23:09 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 645F73F5A2;
        Mon, 12 Feb 2018 16:23:00 +0100 (CET)
Date:   Mon, 12 Feb 2018 16:22:54 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: [RFC] MIPS: R5900: Workaround for the short loop bug
Message-ID: <20180212152254.GA2272@localhost.localdomain>
References: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211072908.GA2222@localhost.localdomain>
 <alpine.DEB.2.00.1802111311530.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802111311530.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Many thanks for your prompt and detailed reviews, Maciej,

> > The exact NOP placements in this patch are provisional. Request for comment
> > on the method to use. I believe there are at least three alternatives:
> > 
> > 1. Add #ifdefs or macros in the source code (similar to this patch).
> > 2. Modify the assembler to automatically insert NOPs as required.
> > 3. Avoid assembly and use C versions of memcpy etc. instead.
> > 
> > This change has been ported from v2.6 patches.
> 
>  I can't tell if this is a porting artefact or whether the reason is 
> different, but many of these loops contain more than 6 instructions 
> already, or need fewer than 3 NOPs.  Please review accordingly.
> 
>  Also can't this be handled automagically by GAS instead?  We have similar 
> workarounds already implemented, see e.g. `-mfix-vr4130'.  Otherwise this 
> is looking to me like a candidate for a maintenance nightmare (which the 
> problem with getting loop instruction counts wrong in your patch is a sign 
> of).

As noted above, please ignore the NOP details which just barely survived
from v2.6 (according to the principle that too many NOPs still work, whereas
too few crash badly), especially since I very much agree with you that it is
unreasonable to maintain such NOPs by hand and would rather proceed with
alternative (2) [from the list above] that is to modify the assembler instead.

Meanwhile, is it possible to run with alternative (3) that is to use C
fallbacks for the R5900, provided the performance penalty is reasonable?

Fredrik
