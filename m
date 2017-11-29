Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 21:21:30 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:57490 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990482AbdK2UVX5-Xgx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 21:21:23 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 29 Nov 2017 20:21:13 +0000
Received: from [10.20.78.197] (10.20.78.197) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Wed, 29 Nov 2017
 12:20:48 -0800
Date:   Wed, 29 Nov 2017 20:20:35 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Validate PR_SET_FP_MODE prctl(2) requests against
 the ABI of the task
In-Reply-To: <20171128193133.ip6weo4tgstqun44@pburton-laptop>
Message-ID: <alpine.DEB.2.00.1711292017300.31156@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1711251259130.3865@tp.orcam.me.uk> <20171127184642.ny2lad4y6zz6am2b@pburton-laptop> <alpine.DEB.2.00.1711272105460.31156@tp.orcam.me.uk> <20171128193133.ip6weo4tgstqun44@pburton-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1511986873-452060-20058-94185-1
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187437
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61225
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

Hi Paul,

> >  That written, I could make it 1/2 with the ABI checks becoming 2/2, but 
> > then 1/2 wouldn't make sense on its own (except perhaps as a 
> > microoptimisation, but that would be an entirely different purpose) and 
> > would have to be considered in conjunction with 2/2 anyway.
> 
> Ah - OK, I see. Prior to this patch the value returned by PR_GET_FP_MODE
> would always be one accepted by PR_SET_FP_MODE anyway, but with the
> patch that will cease to be true for non-o32 ABIs without the special
> case. Gotcha.

 And also for !CONFIG_MIPS_O32_FP64_SUPPORT.

> > > Both changes look good to me though, so feel free to add:
> > > 
> > >     Reviewed-by: Paul Burton <paul.burton@mips.com>
> > 
> >  Thanks for your review.  Do you feel convinced with the justification I 
> > gave?
> 
> Yes - I follow, please consider the Reviewed-by tag valid for the patch
> as-is.

 Great!  Thanks again for your review.

  Maciej
