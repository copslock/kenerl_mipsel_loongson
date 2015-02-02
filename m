Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 21:50:06 +0100 (CET)
Received: from smtp1.ore.mailhop.org ([54.68.34.165]:53741 "EHLO
        smtp1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012428AbbBBUuERByQx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 21:50:04 +0100
Received: from [104.193.169.186] (helo=atomide.com)
        by smtp1.ore.mailhop.org with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.82)
        (envelope-from <tony@atomide.com>)
        id 1YINwP-00022M-S8; Mon, 02 Feb 2015 20:49:53 +0000
X-Mail-Handler: DuoCircle Outbound SMTP
X-Originating-IP: 104.193.169.186
X-Report-Abuse-To: abuse@duocircle.com (see https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information for abuse reporting information)
X-MHO-User: U2FsdGVkX1+9BmMCOEJG7k+WxXrUyhL1
Date:   Mon, 2 Feb 2015 12:47:02 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Chao Xie <chao.xie@marvell.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Emilio L??pez <emilio@elopez.com.ar>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Alex Elder <elder@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bintian Wang <bintian.wang@huawei.com>,
        Matt Porter <mporter@linaro.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Tero Kristo <t-kristo@ti.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Message-ID: <20150202204702.GH9418@atomide.com>
References: <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
 <54CA8662.7040008@codeaurora.org>
 <20150131013158.GA4323@codeaurora.org>
 <CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
 <20150201221856.421.6151@quantum>
 <CAMuHMdU4QBVOb4WqmcfHkj2K7v8dt1hKKWXS0qAnTvsJSafdPQ@mail.gmail.com>
 <20150202161237.GG16250@atomide.com>
 <20150202174646.421.52331@quantum>
 <20150202192116.GF9418@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150202192116.GF9418@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tony@atomide.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony@atomide.com
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

* Tony Lindgren <tony@atomide.com> [150202 11:28]:
> * Mike Turquette <mturquette@linaro.org> [150202 09:50]:
> > Quoting Tony Lindgren (2015-02-02 08:12:37)
> > > 
> > > [   10.568206] ------------[ cut here ]------------
> > > [   10.568206] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:925 clk_disable+0x28/0x34()
> > > [   10.568237] Modules linked in:
> > > [   10.568237] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       3.19.0-rc6-next-20150202 #2037
> > > [   10.568237] Hardware name: Generic OMAP4 (Flattened Device Tree)
> > > [   10.568267] [<c0015bdc>] (unwind_backtrace) from [<c001222c>] (show_stack+0x10/0x14)
> > > [   10.568267] [<c001222c>] (show_stack) from [<c05d2014>] (dump_stack+0x84/0x9c)
> > > [   10.568267] [<c05d2014>] (dump_stack) from [<c003ea90>] (warn_slowpath_common+0x7c/0xb8)
> > > [   10.568298] [<c003ea90>] (warn_slowpath_common) from [<c003eb68>] (warn_slowpath_null+0x1c/0x24)
> > > [   10.568298] [<c003eb68>] (warn_slowpath_null) from [<c04c1ffc>] (clk_disable+0x28/0x34)
> > > [   10.568328] [<c04c1ffc>] (clk_disable) from [<c0025b3c>] (_disable_clocks+0x18/0x68)
> > > [   10.568328] [<c0025b3c>] (_disable_clocks) from [<c0026f14>] (_idle+0x10c/0x214)
> > > [   10.568328] [<c0026f14>] (_idle) from [<c0855fac>] (_setup+0x338/0x410)
> > > [   10.568359] [<c0855fac>] (_setup) from [<c0027360>] (omap_hwmod_for_each+0x34/0x60)
> > > [   10.568359] [<c0027360>] (omap_hwmod_for_each) from [<c08563c4>] (__omap_hwmod_setup_all+0x30/0x40)
> > > [   10.568389] [<c08563c4>] (__omap_hwmod_setup_all) from [<c0008a04>] (do_one_initcall+0x80/0x1dc)
> > > [   10.568389] [<c0008a04>] (do_one_initcall) from [<c0848ea0>] (kernel_init_freeable+0x204/0x2d0)
> > > [   10.568420] [<c0848ea0>] (kernel_init_freeable) from [<c05cdab8>] (kernel_init+0x8/0xec)
> > > [   10.568420] [<c05cdab8>] (kernel_init) from [<c000e790>] (ret_from_fork+0x14/0x24)
> > > [   10.568420] ---[ end trace cb88537fdc8fa211 ]---
> 
> For reference, the above is line 992 in clk-next.
...
 
> Just booting 4430-sdp with omap2plus_defconfig. And git bisect
> points to 59cf3fcf9baf ("clk: Make clk API return per-user struct
> clk instances") as you already guessed.
>  
> > > [   10.568450] ------------[ cut here ]------------
> > > [   10.568450] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/dpll3xxx.c:436 omap3_noncore_dpll_enable+0xdc/0
> > > x10c()
> > > [   10.568450] Modules linked in:
> > > [   10.568481] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       3.19.0-rc6-next-20150202 #2037
> > > [   10.568481] Hardware name: Generic OMAP4 (Flattened Device Tree)
> > > [   10.568481] [<c0015bdc>] (unwind_backtrace) from [<c001222c>] (show_stack+0x10/0x14)
> > > [   10.568511] [<c001222c>] (show_stack) from [<c05d2014>] (dump_stack+0x84/0x9c)
> > > [   10.568511] [<c05d2014>] (dump_stack) from [<c003ea90>] (warn_slowpath_common+0x7c/0xb8)
> > > [   10.568511] [<c003ea90>] (warn_slowpath_common) from [<c003eb68>] (warn_slowpath_null+0x1c/0x24)
> > > [   10.568542] [<c003eb68>] (warn_slowpath_null) from [<c0035800>] (omap3_noncore_dpll_enable+0xdc/0x10c)
> > > [   10.568542] [<c0035800>] (omap3_noncore_dpll_enable) from [<c04c0a10>] (clk_core_enable+0x60/0x9c)
> > > [   10.568572] [<c04c0a10>] (clk_core_enable) from [<c04c09f0>] (clk_core_enable+0x40/0x9c)
> > > [   10.568572] ---[ end trace cb88537fdc8fa212 ]---
> > > ...
> > 
> > This is the same issue discussed already in this thread[0]. Feedback
> > from Tero & Paul on how to handle it would be nice.
> 
> Yes that one is a separate issue.
>  
> > Please let me know if anything else breaks for you.
> 
> Also off-idle on omap3 seems to be broken by commit 59cf3fcf9baf.

Actually the two warnigns above are all caused by the same issue.
And the patch Tero just posted fixes both of the issue. It's the thread 
"[PATCH v13 3/6] clk: Make clk API return per-user struct clk instances"
for reference.

Regards,

Tony
