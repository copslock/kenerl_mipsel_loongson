Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2015 00:58:25 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33037 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008940AbbIOW6XnJ903 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2015 00:58:23 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 769DC1343;
        Tue, 15 Sep 2015 22:58:16 +0000 (UTC)
Date:   Tue, 15 Sep 2015 15:58:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Andy Gross <agross@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?UTF-8?Q?Rafa=C5=82_?= =?UTF-8?Q?Mi=C5=82ecki?= 
        <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/3] Add __ioread32_copy() and use it
Message-Id: <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
In-Reply-To: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49206
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

On Tue, 15 Sep 2015 12:41:26 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:

> The SMD driver is reading and writing chunks of data to iomem,
> and there's an __iowrite32_copy() function for the writing part, but
> no __ioread32_copy() function for the reading part. This series
> adds __ioread32_copy() and uses it in two places. Andrew is on Cc in
> case this should go through the -mm tree. Otherwise the target
> of this patch series is SMD, so I've sent it to Andy.

"soc: qcom: smd: Use __ioread32_copy() instead of open-coding it" no
longer applies, because smd_copy_from_fifo() has switched to
readl_relaxed().

Let's use the __weak macro rather than open-coding it (and convert
__iowrite32_copy() while we're in there).

It's unclear why __iowrite32_copy() is a weak function - nothing
overrides it.  Perhaps we should just take that away rather than
copying it into __ioread32_copy().

__iowrite32_copy() is marked __visible.  I don't actually know what
that does and Andi's d47d5c8194579bc changelog (which sucks the big
one) didn't explain it.  Apparently it has something to do with being
implemented in assembly, but zillions of functions are implemented in
assembly, so why are only two functions marked this way?  Anyway,
__ioread32_copy() is implemented in C so I guess __visible isn't needed
there.
