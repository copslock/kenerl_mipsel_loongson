Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 11:30:57 +0100 (CET)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:28422 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeBRKatkWF-U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2018 11:30:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 25DFB40011;
        Sun, 18 Feb 2018 11:30:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7fI6c_1ZPACQ; Sun, 18 Feb 2018 11:30:40 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0057B4000F;
        Sun, 18 Feb 2018 11:30:28 +0100 (CET)
Date:   Sun, 18 Feb 2018 11:30:27 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: Aw: [RFC] MIPS: R5900: Use mandatory SYNC.L in exception handlers
Message-ID: <20180218103026.GC2577@localhost.localdomain>
References: <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211082913.GF2222@localhost.localdomain>
 <trinity-5d735b1e-9f56-47cc-8f85-3635dd4efe48-1518345226674@3c-app-gmx-bs58>
 <alpine.DEB.2.00.1802111301330.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802111301330.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62607
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

>  This change makes no sense to me anyway I am afraid.
> 
>  At the error level (Status.ERL=1) the user segment becomes unmapped and 
> therefore all KUSEG addresses become physical addresses.  Which means that 
> if any of this code you have patched is called to access user pages, then 
> you have a bigger problem than just the cache going out of sync.
> 
>  The only reason to access KUSEG at the error level is to save/restore 
> register state to/from a dedicated RAM area offset from $zero so that 
> execution is restartable.  Unlike at the exception level you cannot use 
> $k0 and $k1 as temporaries, because an error exception can happen any time 
> including in particular while $k0 and $k1 are in active use at the 
> exception level, so clobbering them would make the system non-restartable 
> (of course receiving an error exception may mean that anyway).
> 
>  Code to write/read that dedicated area should be purpose-crafted and the 
> area won't be accessed at any other time, so the issue of being cache 
> coherent or not does not apply as the area will never be accessed with 
> caching operations.

Thanks for your detailed description!

>  I can see the R5900 has additional classes of error exceptions defined, 
> such as debug and performance counter exceptions, which are not related to 
> hardware faults and can happen in regular execution in response to certain 
> conditions requested.  If you want to handle these implementation specific 
> extensions and consequently serve these exceptions, then please take care 
> of all the requirements as code to support them is added.

Yes, hardware breakpoints and hardware performance counters are very
interesting features to develop after the initial submission.

>  Though as I wrote above it does not look to me like anything specific 
> will be needed -- the handler at entry will save the state necessary for 
> restartability to a dedicated RAM area first and then to the kernel stack, 
> switch the error level off, do the necessary processing, and then reverse 
> the steps before resuming execution interrupted.

Excellent. I will just drop this patch then.

Fredrik
