Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 10:33:47 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:60960 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990391AbeBLJdlK0X9P convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Feb 2018 10:33:41 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 12 Feb 2018 09:33:34 +0000
Received: from [10.20.78.211] (10.20.78.211) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Mon, 12 Feb 2018
 01:22:15 -0800
Date:   Mon, 12 Feb 2018 09:22:06 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: Aw: [RFC] MIPS: R5900: Use mandatory SYNC.L in exception
 handlers
In-Reply-To: <trinity-5d735b1e-9f56-47cc-8f85-3635dd4efe48-1518345226674@3c-app-gmx-bs58>
Message-ID: <alpine.DEB.2.00.1802111301330.3553@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk> <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk> <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain> <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211082913.GF2222@localhost.localdomain> <trinity-5d735b1e-9f56-47cc-8f85-3635dd4efe48-1518345226674@3c-app-gmx-bs58>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-BESS-ID: 1518428013-452059-20512-162088-12
X-BESS-VER: 2018.1.1-r1801291958
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189937
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Jürgen, Fredrik --

> > Would you be able to explain the notes
> > 
> > 	/* In an error exception handler the user space could be uncached. */
> > 
> > in the patch ported from v2.6 below?
> 
> The tx79architecture.pdf says:
> 2.4 kuseg becomes an uncached area when an error exception (Status.ERL = 1) occurs (FLX04)
> 2.4.1 Phenomenon
> There are cases in which kuseg (0x0000_0000 – 0x7FFF_FFFF) becomes uncached in an error exception handler (Status.ERL==1) and data consistency with cached area (kseg, ksseg, kseg0) is lost.
> 2.4.2 Corrective measures
> In an error exception handler (Status.ERL==1), when accessing kuseg (0x0000_0000 – 0x7FFF_FFFF), access it after guarding using SYNC.L as follows:
> SYNC.L
> SW ku seg

 This change makes no sense to me anyway I am afraid.

 At the error level (Status.ERL=1) the user segment becomes unmapped and 
therefore all KUSEG addresses become physical addresses.  Which means that 
if any of this code you have patched is called to access user pages, then 
you have a bigger problem than just the cache going out of sync.

 The only reason to access KUSEG at the error level is to save/restore 
register state to/from a dedicated RAM area offset from $zero so that 
execution is restartable.  Unlike at the exception level you cannot use 
$k0 and $k1 as temporaries, because an error exception can happen any time 
including in particular while $k0 and $k1 are in active use at the 
exception level, so clobbering them would make the system non-restartable 
(of course receiving an error exception may mean that anyway).

 Code to write/read that dedicated area should be purpose-crafted and the 
area won't be accessed at any other time, so the issue of being cache 
coherent or not does not apply as the area will never be accessed with 
caching operations.

 I can see the R5900 has additional classes of error exceptions defined, 
such as debug and performance counter exceptions, which are not related to 
hardware faults and can happen in regular execution in response to certain 
conditions requested.  If you want to handle these implementation specific 
extensions and consequently serve these exceptions, then please take care 
of all the requirements as code to support them is added.

 Though as I wrote above it does not look to me like anything specific 
will be needed -- the handler at entry will save the state necessary for 
restartability to a dedicated RAM area first and then to the kernel stack, 
switch the error level off, do the necessary processing, and then reverse 
the steps before resuming execution interrupted.

  Maciej
