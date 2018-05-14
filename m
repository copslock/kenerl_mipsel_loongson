Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2018 00:56:24 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:52089 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992684AbeENW4R4ohOU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2018 00:56:17 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx26.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 14 May 2018 22:56:11 +0000
Received: from [10.20.78.96] (10.20.78.96) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 14
 May 2018 15:56:38 -0700
Date:   Mon, 14 May 2018 23:56:01 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: memset.S: EVA & fault support for
 small_memset
In-Reply-To: <20180416202234.GA23881@saruman>
Message-ID: <alpine.DEB.2.00.1805142329120.10896@tp.orcam.me.uk>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com> <1522315704-31641-2-git-send-email-matt.redfearn@mips.com> <20180416202234.GA23881@saruman>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.96]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526338571-853316-30635-1409-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192989
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
X-archive-position: 63959
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

On Mon, 16 Apr 2018, James Hogan wrote:

> > @@ -260,6 +260,11 @@
> >  	jr		ra
> >  	andi		v1, a2, STORMASK
> 
> This patch looks good, well spotted!
> 
> But whats that v1 write about? Any ideas? Seems to go back to the git
> epoch, and $3 isn't in the clobber lists when __bzero* is called.

 You need to dive deeper, that is beyond the secret commit 66f0a432564b 
("Add resource managment."), to find what's happened before the epoch. ;)

 Anyway, there isn't anything special here, the thing has been here since 
the inception of memset.S with commit 2e0f55e79c49 (no shortlog available 
for that one).  And it is clearly a bug, possibly just a leftover from a 
WIP implementation or whatever.

 And I can see Matt has already fixed that, thanks!

  Maciej
