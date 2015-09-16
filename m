Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 00:09:13 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:45566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008885AbbIPWJLULBiA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 00:09:11 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65FCCE98;
        Wed, 16 Sep 2015 22:09:04 +0000 (UTC)
Date:   Wed, 16 Sep 2015 15:09:03 -0700
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
Message-Id: <20150916150903.8021ca66ba76cb31f34021a2@linux-foundation.org>
In-Reply-To: <20150916005053.GL23081@codeaurora.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
        <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
        <20150916005053.GL23081@codeaurora.org>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49225
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

On Tue, 15 Sep 2015 17:50:53 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:

> > 
> > __iowrite32_copy() is marked __visible.  I don't actually know what
> > that does and Andi's d47d5c8194579bc changelog (which sucks the big
> > one) didn't explain it.  Apparently it has something to do with being
> > implemented in assembly, but zillions of functions are implemented in
> > assembly, so why are only two functions marked this way?  Anyway,
> > __ioread32_copy() is implemented in C so I guess __visible isn't needed
> > there.
> 
> Yeah, I didn't add visible because there isn't an assembly
> version of __ioread32_copy() so far. I can remove __weak if
> desired. I left it there to match __iowrite32_copy() in case
> x86 wanted to override it but we can do that later or never.

OK.  I'd omit the __weak and __visible for now.  They can be added later
if someone needs them.
