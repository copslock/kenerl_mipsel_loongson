Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 18:50:17 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40812 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012426AbbBBRuPhTRKW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 18:50:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=lYx90cO86zfXefoKS3iXaJLy7cPEC8R/Qs7USBcAEQU=;
        b=JO+w7VvvtJZxY4YirVdhX0ipqAa2nIh2Az9Essj7pDZYoe4CI2wa3/lzFqYscXKnANVUSMd46/gW7IEGTzPbGd/whNbXQBN7F1lQn0hL+NqwDaR9Hs5gBJzUOyJVoVUdvt5wmqaEmA6fhOS0XzysdGajiTzFq++rAcOfjqBrn/Q=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:35274)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1YIL89-0004la-8q; Mon, 02 Feb 2015 17:49:49 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1YIL85-0003Vg-Pj; Mon, 02 Feb 2015 17:49:45 +0000
Date:   Mon, 2 Feb 2015 17:49:45 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Mike Turquette <mturquette@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Chao Xie <chao.xie@marvell.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
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
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Message-ID: <20150202174945.GA8670@n2100.arm.linux.org.uk>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
 <54CA8662.7040008@codeaurora.org>
 <20150131013158.GA4323@codeaurora.org>
 <CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
 <20150201221856.421.6151@quantum>
 <CAMuHMdU4QBVOb4WqmcfHkj2K7v8dt1hKKWXS0qAnTvsJSafdPQ@mail.gmail.com>
 <20150202161237.GG16250@atomide.com>
 <20150202174646.421.52331@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150202174646.421.52331@quantum>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Mon, Feb 02, 2015 at 09:46:46AM -0800, Mike Turquette wrote:
> This looks like mis-matched enable/disable calls. We now have unique
> struct clk pointers for every call to clk_get. I haven't yet looked
> through the hwmod code but I have a feeling that we're doing something
> like this:
> 
> 	/* enable clock */
> 	my_clk = clk_get(...);
> 	clk_prepare_enable(my_clk);
> 	clk_put(my_clk);
> 
> 	/* do some work */
> 	do_work();
> 
> 	/* disable clock */
> 	my_clk = clk_get(...);
> 	clk_disable_unprepare(my_clk);
> 	clk_put(my_clk);
> 
> The above pattern no longer works since my_clk will be two different
> unique pointers, but it really should be one stable pointer across the
> whole usage of the clk. E.g:

Yes, it has always been documented that shall be the case.  Anyone doing
the above is basically broken.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
