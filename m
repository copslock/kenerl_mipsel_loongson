Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 18:47:45 +0100 (CET)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:37544 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992923AbeBQRripxskZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 18:47:38 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id D804C3F3B0;
        Sat, 17 Feb 2018 18:47:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CT1vTmzsE9RJ; Sat, 17 Feb 2018 18:47:27 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 7F6F93F397;
        Sat, 17 Feb 2018 18:47:18 +0100 (CET)
Date:   Sat, 17 Feb 2018 18:47:16 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: [RFC] MIPS: R5900: Workaround for saving and restoring FPU
 registers
Message-ID: <20180217174715.GD2496@localhost.localdomain>
References: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180217144346.GC2496@localhost.localdomain>
 <alpine.DEB.2.00.1802171504320.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802171504320.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62581
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

Hi Maciej,

>  I thought we agreed the R5900 FPU is unusable for regular Linux software 
> and decided to go for full FPU emulation unconditionally.

Yes, that's true, we are in agreement. I was unaware that the FPU emulation
was complete enough to cover all registers (not only a set of instructions).
Sorry about that. I will simply remove this patch then.

>  We could add a special R5900 mode, denoted with a dedicated 
> Tag_GNU_MIPS_ABI_FP attribute and MIPS ABI Flags FP ABI setting, which 
> would then enable hardware FPU for the selected task, but I suggest we 
> defer any actual code proposals until we have all the design details 
> settled.

Agreed. :)

>  Etc. -- can you reuse MIPS I code here, i.e. use S.D?  GAS should be 
> doing the right thing with `-march=r5900' (if not, then it has a bug).

Possibly, I am somewhat unfamiliar with this area. So let's revisit this FPU
issue after the initial submission.

>  You surely do not want all this MIPS32r2 stuff, or do you?

No, not that I know of.

Fredrik
