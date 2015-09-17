Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 21:57:00 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42689 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008567AbbIQT47JNLTs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 21:56:59 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B36B11BE;
        Thu, 17 Sep 2015 19:56:52 +0000 (UTC)
Date:   Thu, 17 Sep 2015 12:56:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Andy Gross <agross@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?UTF-8?Q?Rafa=C5=82_?= =?UTF-8?Q?Mi=C5=82ecki?= 
        <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v2 0/3] Add __ioread32_copy() and use it
Message-Id: <20150917125651.d7ab504539016a149ea871e6@linux-foundation.org>
In-Reply-To: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
References: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Thu, 17 Sep 2015 12:02:08 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:

> The SMD driver is reading and writing chunks of data to iomem,
> and there's an __iowrite32_copy() function for the writing part, but
> no __ioread32_copy() function for the reading part. This series
> adds __ioread32_copy() and uses it in two places. Andrew is on Cc in
> case this should go through the -mm tree. Otherwise the target
> of this patch series is SMD, so I've sent it to Andy.
> 
> Note this patch series relies on a previous patch on the list that
> changes the readl() to __raw_readl() in the smd driver[1].

Well that's awkward.

"[PATCH v2 6/8] soc: qcom: smd: Handle big endian CPUs" is one patch in
an eight-patch series.  My usual approach would be to suck in the whole
series, stage it behind linux-next, drop patches if/when others merge
them into subsystem trees and thus retain all the dependencies for this
patch series in a maintainable-by-me fashion.

But that 8-patch series doesn't apply:

checking file drivers/soc/qcom/smd.c
Hunk #6 FAILED at 360.
Hunk #15 FAILED at 733.
Hunk #16 FAILED at 741.
3 out of 19 hunks FAILED
Failed to apply soc-qcom-smd-handle-big-endian-cpus


ho hum.  I think I'll go with plan B: merge just "lib: iomap_copy: Add
__ioread32_copy()" and send that into Linus promptly.  That way you
guys can sort out the driver patches in the usual fashion.
