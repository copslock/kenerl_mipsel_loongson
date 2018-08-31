Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 19:13:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994612AbeHaRNM3h0kQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Aug 2018 19:13:12 +0200
Received: from localhost (unknown [104.132.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEC42077C;
        Fri, 31 Aug 2018 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535735586;
        bh=uPJimPlF7yyKd+X1kPW5Svf3bKd3KY199sq6AbkdR/Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ZNdGpc0ChTwoLOGayUjDCZKhqmf6qQhJoQj3lnr0glRwmHV4zCNIUmINbYCDfDZ+m
         83y0klJYaHjzNak9VDg1cgfOXyuX/bAARUVgWbi2nk+9MdAQ/ndicAfd9YQ2oze3fx
         AJwmQWwV65x06PvCCHdGcaJMdS2fioaMpsHvhyew=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Zhu, Yi Xin" <yixin.zhu@linux.intel.com>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        chuanhua.lei@linux.intel.com, hua.ma@linux.intel.com,
        qi-ming.wu@intel.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <65a8518b-8fd8-847b-f952-0370be3d786a@linux.intel.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <153370742214.220756.2039365625963765922@swboyd.mtv.corp.google.com>
 <571d2d40-8728-fa7c-5d89-73d2a7b6293b@linux.intel.com>
 <153539697928.129321.2605078315090527674@swboyd.mtv.corp.google.com>
 <65a8518b-8fd8-847b-f952-0370be3d786a@linux.intel.com>
Message-ID: <153573558557.93865.3835503209987304514@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
Date:   Fri, 31 Aug 2018 10:13:05 -0700
Return-Path: <sboyd@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@kernel.org
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

Quoting Zhu, Yi Xin (2018-08-29 03:34:26)
> >>>> +}
> >>>> +
> >>>> +CLK_OF_DECLARE(intel_grx500_cgu, "intel,grx500-cgu", grx500_clk_init);
> >>> Any reason a platform driver can't be used instead of CLK_OF_DECLARE()?
> >> It provides CPU clock which is used in early boot stage.
> >>
> > Ok. What is the CPU clock doing in early boot stage? Some sort of timer
> > frequency? If the driver can be split into two pieces, one to handle the
> > really early stuff that must be in place to get timers up and running
> > and the other to register the rest of the clks that aren't critical from
> > a regular platform driver it would be good. That's preferred model if
> > something is super critical.
> >
> Just to make sure my approach is same as you think.
> 
> In the driver, there's two clock registrations.
> 
> - One through CLK_OF_DECLARE for early stage clocks.
> 
> - The other via platform driver for the non-critical clocks.

You can use the same DT node for both parts, no need to split the node
into two and use syscon here.
