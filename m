Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 12:34:28 +0100 (CET)
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13490 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012367AbaJaLe1N0bI4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 12:34:27 +0100
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
        id <B545374000000>; Fri, 31 Oct 2014 04:35:28 -0700
Received: from hqemhub02.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Fri, 31 Oct 2014 04:33:36 -0700
X-PGP-Universal: processed;
        by hqnvupgp08.nvidia.com on Fri, 31 Oct 2014 04:33:36 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server (TLS) id 8.3.342.0; Fri, 31 Oct
 2014 04:34:19 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 31 Oct
 2014 11:34:01 +0000
Received: from deemhub01.nvidia.com (10.21.69.137) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.847.32 via Frontend
 Transport; Fri, 31 Oct 2014 11:34:00 +0000
Received: from tbergstrom-lnx.Nvidia.com (10.21.65.27) by deemhub01.nvidia.com
 (10.21.69.137) with Microsoft SMTP Server id 8.3.342.0; Fri, 31 Oct 2014
 12:33:58 +0100
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)      id
 833512086D; Fri, 31 Oct 2014 13:33:58 +0200 (EET)
Date:   Fri, 31 Oct 2014 13:33:58 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Mike Turquette <mturquette@linaro.org>
CC:     Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Alex Elder" <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-omap@vger.kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Matt Porter" <mporter@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v5 0/7] Per-user clock constraints
Message-ID: <20141031113358.GY32045@tbergstrom-lnx.Nvidia.com>
References: <1414666135-14313-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1414666135-14313-1-git-send-email-tomeu.vizoso@collabora.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pdeschrijver@nvidia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdeschrijver@nvidia.com
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

On Thu, Oct 30, 2014 at 11:48:26AM +0100, Tomeu Vizoso wrote:
> Hello,
> 
> this fifth version of the series has just one change, suggested by Stephen:
> 
> * Initialize clk.ceiling_constraint to ULONG_MAX and warn about new floor
> constraints being higher than the existing ceiling.
> 
> The first five patches are just cleanups that should be desirable on their own,
> and that should make easier to review the actual per-user clock patch.
> 
> The sixth patch actually moves the per-clock data that was stored in struct
> clk to a new struct clk_core and adds references to it from both struct clk and
> struct clk_hw. struct clk is now ready to contain information that is specific
> to a given clk consumer.
> 
> The seventh patch adds API for setting floor and ceiling constraints and stores
> that information on the per-user struct clk, which is iterable from struct
> clk_core.
> 
> They are based on top of 3.18-rc1.
> 
> http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v5
> 

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

Mike,

Do you think this will be merged for 3.19?

Thanks,

Peter.
