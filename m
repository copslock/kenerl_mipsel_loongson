Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 10:29:14 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:57084 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990391AbeBLJ3EpwTbP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 10:29:04 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 12 Feb 2018 09:28:57 +0000
Received: from [10.20.78.211] (10.20.78.211) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Mon, 12 Feb 2018
 01:26:02 -0800
Date:   Mon, 12 Feb 2018 09:25:53 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [RFC] MIPS: R5900: Workaround for the short loop bug
In-Reply-To: <20180211072908.GA2222@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1802111311530.3553@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk> <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk> <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain> <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211072908.GA2222@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1518427737-321457-17360-35975-1
X-BESS-VER: 2018.1-r1801291959
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
X-archive-position: 62498
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

On Sat, 10 Feb 2018, Fredrik Noring wrote:

> The short loop bug under certain conditions causes loops to execute
> only once or twice. GCC 2.95 that shipped with Sony PS2 Linux had a
> patch with the following note:
> 
>     On the R5900, we must ensure that the compiler never generates
>     loops that satisfy all of the following conditions:
> 
>     - a loop consists of less than equal to six instructions
>       (including the branch delay slot);
>     - a loop contains only one conditional branch instruction at
>       the end of the loop;
>     - a loop does not contain any other branch or jump instructions;
>     - a branch delay slot of the loop is not NOP (EE 2.9 or later).
> 
>     We need to do this because of a bug in the chip.
> 
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
> The exact NOP placements in this patch are provisional. Request for comment
> on the method to use. I believe there are at least three alternatives:
> 
> 1. Add #ifdefs or macros in the source code (similar to this patch).
> 2. Modify the assembler to automatically insert NOPs as required.
> 3. Avoid assembly and use C versions of memcpy etc. instead.
> 
> This change has been ported from v2.6 patches.

 I can't tell if this is a porting artefact or whether the reason is 
different, but many of these loops contain more than 6 instructions 
already, or need fewer than 3 NOPs.  Please review accordingly.

 Also can't this be handled automagically by GAS instead?  We have similar 
workarounds already implemented, see e.g. `-mfix-vr4130'.  Otherwise this 
is looking to me like a candidate for a maintenance nightmare (which the 
problem with getting loop instruction counts wrong in your patch is a sign 
of).

  Maciej
