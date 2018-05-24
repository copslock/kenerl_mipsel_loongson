Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2018 18:51:49 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40723 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeEXQvjeXaDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2018 18:51:39 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 24 May 2018 16:51:34 +0000
Received: from [10.20.78.188] (10.20.78.188) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 24
 May 2018 09:51:35 -0700
Date:   Thu, 24 May 2018 17:51:25 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit
 FGRs
In-Reply-To: <20180524125959.GB24269@jamesdev>
Message-ID: <alpine.DEB.2.00.1805241749320.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk> <20180524125959.GB24269@jamesdev>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.188]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1527180693-637138-30949-53035-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193318
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
X-archive-position: 64009
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

On Thu, 24 May 2018, James Hogan wrote:

> > Use 64-bit accesses for 64-bit floating-point general registers with 
> > PTRACE_PEEKUSR, removing the truncation of their upper halves in the 
> > FR=1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context 
> > access"), which inadvertently switched them to using 32-bit accesses.
> > 
> > The PTRACE_POKEUSR side is fine as it's never been broken and continues 
> > using 64-bit accesses.
> > 
> > Cc: <stable@vger.kernel.org> # 3.19+
> 
> should that be 3.15+?

 Indeed, I must have used the wrong result; thank you for catching this!

  Maciej
