Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2018 01:13:04 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:44063 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993024AbeFOXMu6T0i3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jun 2018 01:12:50 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 15 Jun 2018 23:12:43 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 15
 Jun 2018 16:12:55 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Fri, 15 Jun
 2018 16:12:55 -0700
Date:   Fri, 15 Jun 2018 16:12:42 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Khem Raj <raj.khem@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH] mips: Disable attribute-alias warnings
Message-ID: <20180615231242.uimxfjac5yrzycys@pburton-laptop>
References: <20180504190530.1879-1-raj.khem@gmail.com>
 <e380a58d-fc9f-89e0-cc56-c3a0000a179b@mips.com>
 <287ab070-0463-04a5-63fa-475c44752f56@gmail.com>
 <CAK8P3a0NugcUSkLZkM8z1H8Xr2zpt0tFesSabu5hLKy8JbfYrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0NugcUSkLZkM8z1H8Xr2zpt0tFesSabu5hLKy8JbfYrA@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529104363-637137-17634-13193-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194097
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: arnd@arndb.de,raj.khem@gmail.com,linux-mips@linux-mips.org,ralf@linux-mips.org,jhogan@kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Arnd,

On Wed, May 16, 2018 at 09:20:12PM -0400, Arnd Bergmann wrote:
> > I tend to agree. I think, I have also tested a patch where I am manually
> > ignoring the warning via pragma around the function which essentially is
> > similar to what Arnd has proposed only that Arnd's patch is generic
> 
> Sorry I never followed up on my initial patches. I still think we should do it
> that way, but will need some more time until I can revisit them, as
> I'm currently travelling. If someone else wants to pick up my patches
> and post a new version in the meantime, that would be greatly appreciated.

If you're still away then I'll aim to do this tomorrow - I see PowerPC
has already merged local #pragma's & we've had 2 submissions now for the
MIPS equivalent, so it'd be good to get this solved generically.

Thanks,
    Paul
