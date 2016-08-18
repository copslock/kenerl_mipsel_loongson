Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 01:48:24 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:42287 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992067AbcHRXsQXr2Le (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 01:48:16 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7744161CB9; Thu, 18 Aug 2016 23:48:14 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C89C61CAA;
        Thu, 18 Aug 2016 23:48:13 +0000 (UTC)
Date:   Thu, 18 Aug 2016 16:48:12 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Loongson1B: Change the OSC clock name
Message-ID: <20160818234812.GI361@codeaurora.org>
References: <1470999363-9978-1-git-send-email-keguang.zhang@gmail.com>
 <20160815232825.GW361@codeaurora.org>
 <CAJhJPsXs9nyR=ZJoMKFvOxR16jZ2n_F8DFmx0A=6Z5T_YxG3ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhJPsXs9nyR=ZJoMKFvOxR16jZ2n_F8DFmx0A=6Z5T_YxG3ag@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54664
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

On 08/16, Kelvin Cheung wrote:
> Hi Stephen,
> 
> 2016-08-16 7:28 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> 
> > On 08/12, Keguang Zhang wrote:
> > > From: Kelvin Cheung <keguang.zhang@gmail.com>
> > >
> > > This patch changes the OSC clock name to "osc_clk".
> > >
> > > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> > > ---
> >
> > Yes, but why?
> >
> >
> Loongson1C uses a 24MHz oscillator, hence "osc_clk" sounds more appropriate
> 
> 

So then should we replace all the osc_33m_clk names with osc_clk?
This patch only modifies one name and it looks like a clkdev
lookup is created that still has osc_33m_clk for the connection
name in drivers/clk/clk-ls1x.c, so merging it would mean things
break? I also wonder what the pin is actually called in the
datasheet, because that should be what the cpufreq driver uses in
clk_get() as the connection id. If that's osc_33m_clk then it's
better to leave it alone even if the frequency is different.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
