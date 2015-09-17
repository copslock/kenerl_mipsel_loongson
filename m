Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 23:42:25 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:39422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008745AbbIQVmXAmZeG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 23:42:23 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9DE7C14081E;
        Thu, 17 Sep 2015 21:42:20 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 52C4F140829; Thu, 17 Sep 2015 21:42:20 +0000 (UTC)
Received: from localhost (rrcs-67-52-129-61.west.biz.rr.com [67.52.129.61])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agross@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D84614081E;
        Thu, 17 Sep 2015 21:42:19 +0000 (UTC)
Date:   Thu, 17 Sep 2015 16:42:18 -0500
From:   Andy Gross <agross@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v2 0/3] Add __ioread32_copy() and use it
Message-ID: <20150917214218.GA6003@qualcomm.com>
References: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
 <20150917125651.d7ab504539016a149ea871e6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150917125651.d7ab504539016a149ea871e6@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <agross@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agross@codeaurora.org
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

On Thu, Sep 17, 2015 at 12:56:51PM -0700, Andrew Morton wrote:
> On Thu, 17 Sep 2015 12:02:08 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > The SMD driver is reading and writing chunks of data to iomem,
> > and there's an __iowrite32_copy() function for the writing part, but
> > no __ioread32_copy() function for the reading part. This series
> > adds __ioread32_copy() and uses it in two places. Andrew is on Cc in
> > case this should go through the -mm tree. Otherwise the target
> > of this patch series is SMD, so I've sent it to Andy.
> > 
> > Note this patch series relies on a previous patch on the list that
> > changes the readl() to __raw_readl() in the smd driver[1].
> 
> Well that's awkward.
> 
> "[PATCH v2 6/8] soc: qcom: smd: Handle big endian CPUs" is one patch in
> an eight-patch series.  My usual approach would be to suck in the whole
> series, stage it behind linux-next, drop patches if/when others merge
> them into subsystem trees and thus retain all the dependencies for this
> patch series in a maintainable-by-me fashion.
> 
> But that 8-patch series doesn't apply:
> 
> checking file drivers/soc/qcom/smd.c
> Hunk #6 FAILED at 360.
> Hunk #15 FAILED at 733.
> Hunk #16 FAILED at 741.
> 3 out of 19 hunks FAILED
> Failed to apply soc-qcom-smd-handle-big-endian-cpus
> 
> 
> ho hum.  I think I'll go with plan B: merge just "lib: iomap_copy: Add
> __ioread32_copy()" and send that into Linus promptly.  That way you
> guys can sort out the driver patches in the usual fashion.
> 

I just pulled in the original 8 patches and rebased.  My plans were to stage
those in linux-next through my for-next.  Then add those on top just like you
specified.  But i could go either way.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
