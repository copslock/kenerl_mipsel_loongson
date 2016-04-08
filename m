Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2016 12:06:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52972 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008771AbcDHKGkVkC0L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Apr 2016 12:06:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u38A6TCm024038;
        Fri, 8 Apr 2016 12:06:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u38A60Yj024029;
        Fri, 8 Apr 2016 12:06:00 +0200
Date:   Fri, 8 Apr 2016 12:06:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ryan Mallon <rmallon@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        adi-buildroot-devel@lists.sourceforge.net,
        Russell King <linux@arm.linux.org.uk>,
        linux-m68k@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        John Crispin <blogic@openwrt.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
Message-ID: <20160408100600.GI1668@linux-mips.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160408003328.GA14441@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Apr 07, 2016 at 05:33:28PM -0700, Stephen Boyd wrote:

> On 04/05, Masahiro Yamada wrote:
> > The clk_disable() in the common clock framework (drivers/clk/clk.c)
> > returns immediately if a given clk is NULL or an error pointer.  It
> > allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
> > checking if drivers are only used with the common clock framework.
> > 
> > Unfortunately, NULL/error checking is missing from some of non-common
> > clk_disable() implementations.  This prevents us from completely
> > dropping NULL/error checking from callers.  Let's make it tree-wide
> > consistent by adding IS_ERR_OR_NULL(clk) to all callees.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Acked-by: Greg Ungerer <gerg@uclinux.org>
> > Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> > ---
> > 
> > Stephen,
> > 
> > This patch has been unapplied for a long time.
> > 
> > Please let me know if there is something wrong with this patch.
> > 
> 
> I'm mostly confused why we wouldn't want to encourage people to
> call clk_disable or unprepare on a clk that's an error pointer.
> Typically an error pointer should be dealt with, instead of
> silently ignored, so why wasn't it dealt with by passing it up
> the probe() path?

While your argument makes perfect sense, Many clk_disable implementations
are already doing similar checks, for example:

arch/arm/mach-davinci/clock.c:

void clk_disable(struct clk *clk)
{
	unsigned long flags;

	if (clk == NULL || IS_ERR(clk))
		return;
[...]

arch/arm/mach-omap1/clock.c

void clk_disable(struct clk *clk)
{
        unsigned long flags;

        if (clk == NULL || IS_ERR(clk))
                return;
[...]

arch/avr32/mach-at32ap/clock.c

void clk_disable(struct clk *clk)
{
        unsigned long flags;

        if (IS_ERR_OR_NULL(clk))
                return;
[...]

arch/mips/lantiq/clk.c:

static inline int clk_good(struct clk *clk)
{
	return clk && !IS_ERR(clk);
}

[...]

void clk_disable(struct clk *clk)
{
	if (unlikely(!clk_good(clk)))
		return;

	if (clk->disable)
[...]

So should we go and weed out these checks?

  Ralf
