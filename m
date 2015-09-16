Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2015 02:51:01 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:41582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008974AbbIPAu6f38GF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2015 02:50:58 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EAC98140429;
        Wed, 16 Sep 2015 00:50:54 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id C5C8A140427; Wed, 16 Sep 2015 00:50:54 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 097EB14040B;
        Wed, 16 Sep 2015 00:50:53 +0000 (UTC)
Date:   Tue, 15 Sep 2015 17:50:53 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Gross <agross@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/3] Add __ioread32_copy() and use it
Message-ID: <20150916005053.GL23081@codeaurora.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
 <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 09/15, Andrew Morton wrote:
> On Tue, 15 Sep 2015 12:41:26 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > The SMD driver is reading and writing chunks of data to iomem,
> > and there's an __iowrite32_copy() function for the writing part, but
> > no __ioread32_copy() function for the reading part. This series
> > adds __ioread32_copy() and uses it in two places. Andrew is on Cc in
> > case this should go through the -mm tree. Otherwise the target
> > of this patch series is SMD, so I've sent it to Andy.
> 
> "soc: qcom: smd: Use __ioread32_copy() instead of open-coding it" no
> longer applies, because smd_copy_from_fifo() has switched to
> readl_relaxed().

Yes. There are some other patches in flight on the mailing list
to this file from me[1]. Those would need to be applied first to
avoid conflicts.

> 
> Let's use the __weak macro rather than open-coding it (and convert
> __iowrite32_copy() while we're in there).

Yep, I converted the __iowrite32_copy() open-code in there too in
the patch series I mentioned above. See [2].

> 
> It's unclear why __iowrite32_copy() is a weak function - nothing
> overrides it.  Perhaps we should just take that away rather than
> copying it into __ioread32_copy().

Huh? I see that x86 has an implementation in arch/x86/lib/iomap_copy_64.S

> 
> __iowrite32_copy() is marked __visible.  I don't actually know what
> that does and Andi's d47d5c8194579bc changelog (which sucks the big
> one) didn't explain it.  Apparently it has something to do with being
> implemented in assembly, but zillions of functions are implemented in
> assembly, so why are only two functions marked this way?  Anyway,
> __ioread32_copy() is implemented in C so I guess __visible isn't needed
> there.

Yeah, I didn't add visible because there isn't an assembly
version of __ioread32_copy() so far. I can remove __weak if
desired. I left it there to match __iowrite32_copy() in case
x86 wanted to override it but we can do that later or never.

[1] http://lkml.kernel.org/g/1441234011-4259-7-git-send-email-sboyd@codeaurora.org
[2] http://lkml.kernel.org/g/1441234011-4259-5-git-send-email-sboyd@codeaurora.org

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
