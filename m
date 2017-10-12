Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 18:35:42 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.233]:48276 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992215AbdJLQffpH85z convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 18:35:35 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 12 Oct 2017 16:34:35 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 12 Oct
 2017 09:32:33 -0700
Date:   Thu, 12 Oct 2017 17:33:30 +0100
From:   James Hogan <james.hogan@mips.com>
To:     Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
CC:     Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Petar Jovanovic" <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Message-ID: <20171012163330.GG15235@jhogan-linux>
References: <20171012101753.GB15235@jhogan-linux>
 <683c-59df7500-1-10d973a0@9889400>
 <20171012144434.GF15235@jhogan-linux>
 <EF5FA6C3467F85449672C3E735957B85015DA0B589@badag02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <EF5FA6C3467F85449672C3E735957B85015DA0B589@badag02.ba.imgtec.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1507825998-321459-6171-8178-14
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.185923
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Thu, Oct 12, 2017 at 03:54:48PM +0000, Aleksandar Markovic wrote:
> > This patch fixes something, I think it should
> > a) be clear in the commit message what is fixed
> > b) be tagged for stable (though that can always be done
> > retrospectively)
> 
> If you agree, I am going to submit v2 of the series, that would fully
> address these concerns.
> 
> Additionally, it seems to me that a new round of testing that tests
> involved code paths under various scenarios would be appropriate
> and I am going to do that.

awesome, thanks!

> > Note: thats the one in fpux_emu(), not fpu_emu() which this patch
> > modifies.
> 
> Yes, my bad, wanting to respond as quickly as possible, I inserted
> the segment from fpux_emu(), not fpu_emu() as I should have.
> 
> By the way, and not related to this patch, I see only 4 (out of 5)
> exceptions are handled in fpux_emu() case (division-by-zero is not
> handled), I presume this is fine (probably division-by-zero not
> needed), isn't it?

Yeh I just spotted that too.

I agree that it only seems to be division instructions (fdiv_op,
frsqrt_op, and frecip_op) that need it, which are all handled in
fpu_emu(), so it should be fine as is.

> 
> I truly appreciate your analysis and help.

No problem

Cheers
James
