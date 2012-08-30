Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 19:19:33 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41020 "EHLO
        opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903264Ab2H3RT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Aug 2012 19:19:28 +0200
Received: from finisterre.wolfsonmicro.main (unknown [38.96.16.75])
        by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 25D60110A67;
        Thu, 30 Aug 2012 18:19:21 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1T78Ol-0001oc-Fi; Thu, 30 Aug 2012 10:19:19 -0700
Date:   Thu, 30 Aug 2012 10:19:19 -0700
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@arm.linux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20120830171918.GE4356@opensource.wolfsonmicro.com>
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <503E8E6E.1010101@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503E8E6E.1010101@wwwdotorg.org>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Aug 29, 2012 at 02:49:34PM -0700, Stephen Warren wrote:
> On 08/28/12 13:35, Mark Brown wrote:

> >@@ -674,6 +676,7 @@ config ARCH_TEGRA
> >  	select GENERIC_CLOCKEVENTS
> >  	select GENERIC_GPIO
> >  	select HAVE_CLK
> >+	select HAVE_CUSTOM_CLK

> For 3.7, Tegra will switch to the common clock framework. I think
> this patch would then disable that. How should we resolve this -
> rebase the Tegra common-clk tree on top of any branch containing
> this patch in order to remove that select statement?

I'd expect this to be applied on a separate branch so you should be able
to rebase your conversion on top of it or merge it into your branch
which should deal with things well enough I think?
