Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2017 05:27:39 +0100 (CET)
Received: from smtpbg303.qq.com ([184.105.206.26]:55288 "EHLO smtpbg303.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991957AbdAEE1bwV4I- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jan 2017 05:27:31 +0100
X-QQ-mid: Xesmtp32t1483590432tmfnyufnu
Received: from localhost (unknown [113.87.162.116])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 05 Jan 2017 12:27:10 +0800 (CST)
X-QQ-SSF: 00000000000000100M104F00000000U
X-QQ-FEAT: oIoGrveFQB+GZBT2GULXuC2q9qykbS6Nen4I/Y+iiRBeHZEUcuj2AbZGERkhD
        8bXV5HoczmAiZ39URt7paBY0i0f7aanGXcbXLMUbI6Ak/goHj69KimirS7WvoLBcW8Msi8y
        hqTR7knEBpLk+6fEiTTKAM9W66byXJsPzw9v9yO4Orhs0k+HPIY4wc4OREvGJcCmWwVAn4/
        4wNonpwb0JC40z6rMWDVzLZeqfVC6eDE8oFjI3Zb5kkjPsOf/hIjNambqTIhFrgKeIMTQ52
        rbt6vY4I+sRLOeqdkCaCbRW64GrM1Vs0RC5g==
X-QQ-GoodBg: 0
Date:   Thu, 5 Jan 2017 12:27:09 +0800
From:   =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>
To:     Kelvin Cheung <keguang.zhang@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Loongson: Fix osc_clk_name
Message-ID: <20170105042709.GA1659@localhost>
References: <20170104134533.GA20945@red54.local>
 <CAJhJPsUgRDGiZ9ZMLMeo_AN9ywruk_NoFxGuF2Wpp07XoY2Vrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsUgRDGiZ9ZMLMeo_AN9ywruk_NoFxGuF2Wpp07XoY2Vrg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-QQ-SENDSIZE: 520
X-QQ-FName: 02C0ACA5B52B4ADD8D139470F624C556
X-QQ-LocalIP: 10.130.87.224
Return-Path: <Yeking@Red54.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Yeking@Red54.com
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

Hi, Kelvin,

Thanks for your prompt,
and I have changed the state to 'Rejected' in Patchwork.
Thank you again!

On Thu, Jan 05, 2017 at 09:50:32AM +0800, Kelvin Cheung wrote:
> Hi Zhibang,
> This was been fixed by commit 3ad01364bb4378fda8acdb376b3352ce764e8927
> <https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=3ad01364bb4378fda8acdb376b3352ce764e8927>
> (MIPS: Loongson1B: Change the OSC clock name).
> Please pull the latest mips-for-linux-next tree.
> Thanks!
> 
> 2017-01-04 21:45 GMT+08:00 谢致邦 (XIE Zhibang) <Yeking@red54.com>:
> 
> > "osc_33m_clk" is already renamed to "osc_clk".
> > https://patchwork.kernel.org/patch/9338505/
> >
> > Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> > ---
> >  arch/mips/loongson32/common/platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/loongson32/common/platform.c
> > b/arch/mips/loongson32/common/platform.c
> > index beff0852..f9d877d4 100644
> > --- a/arch/mips/loongson32/common/platform.c
> > +++ b/arch/mips/loongson32/common/platform.c
> > @@ -82,7 +82,7 @@ void __init ls1x_rtc_set_extclk(struct platform_device
> > *pdev)
> >  /* CPUFreq */
> >  static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
> >         .clk_name       = "cpu_clk",
> > -       .osc_clk_name   = "osc_33m_clk",
> > +       .osc_clk_name   = "osc_clk",
> >         .max_freq       = 266 * 1000,
> >         .min_freq       = 33 * 1000,
> >  };
> > --
> > 2.11.0
> >
> >
> >
> >
> >
> >
> 
> 
> -- 
> Best regards,
> 
> Kelvin Cheung
