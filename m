Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2015 04:49:40 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006546AbbIPCti7Dw61 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2015 04:49:38 +0200
Received: from localhost (c-71-198-47-131.hsd1.ca.comcast.net [71.198.47.131])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27C8CF04;
        Wed, 16 Sep 2015 02:49:32 +0000 (UTC)
Date:   Tue, 15 Sep 2015 19:50:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <agross@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH 0/3] Add __ioread32_copy() and use it
Message-Id: <20150915195031.0a1756a2.akpm@linux-foundation.org>
In-Reply-To: <20150916023219.GD1747@two.firstfloor.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
        <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
        <20150916023219.GD1747@two.firstfloor.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.9; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49209
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

On Wed, 16 Sep 2015 04:32:19 +0200 Andi Kleen <andi@firstfloor.org> wrote:

> > __iowrite32_copy() is marked __visible.  I don't actually know what
> > that does and Andi's d47d5c8194579bc changelog (which sucks the big
> > one) didn't explain it.  Apparently it has something to do with being
> > implemented in assembly, but zillions of functions are implemented in
> > assembly, so why are only two functions marked this way?  Anyway,
> > __ioread32_copy() is implemented in C so I guess __visible isn't needed
> > there.
> 
> __visible is needed for C functions that are called from assembler.
> Otherwise the compiler may optimize them away.

Under what circumstances will the compiler (or linker?) do this? 
LTO enabled?
