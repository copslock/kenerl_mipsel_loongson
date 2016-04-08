Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2016 03:53:25 +0200 (CEST)
Received: from conssluserg-01.nifty.com ([210.131.2.80]:29746 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026270AbcDHBxUUOCj4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2016 03:53:20 +0200
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com [209.85.161.175]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id u381qwmm013128;
        Fri, 8 Apr 2016 10:52:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com u381qwmm013128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1460080379;
        bh=6PfSUbQtN9am4tjoHC1D62BND2Jf1uggxWBL0VRsZhs=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=OUgajd3MBggh7usO9jSqmn0R9HdQTAjf+toLzvLCLbjgar0TU/xzmoF8O0E1C+y6W
         su1kViYO+DNV7rtMV8zTe0doia8aY36ZhHo6tslPdQ7EqQNkpMiJzRMH+hP5OTAaiH
         8dTpSxx/Y+7FVFEFygvfjJtCitcrB7uLOtkwS9MVRcyMjQk3ry4QylQYHovB0G1cou
         Y2KWN6lN5EtO04d51eMWDe40Qa566vtkYGhRTSWF9olB6nz0IGeT4/ENY7m5pg9h0w
         aRagfmDhw029oCvY4N+TKPyh1xG6Fj4xuEHLLKKkQycYCPfCRMksSrbFG/pLjBsVMR
         pUnWsC3FsHaCA==
X-Nifty-SrcIP: [209.85.161.175]
Received: by mail-yw0-f175.google.com with SMTP id i84so113011729ywc.2;
        Thu, 07 Apr 2016 18:52:58 -0700 (PDT)
X-Gm-Message-State: AD7BkJIMcLNcDujZJvMgZiZ8JmXTO33UVvKi6nuWq91YEvAhSdrqWWMbU+A0Pd43uFuG9bbKMhFwV2DXR7myyg==
MIME-Version: 1.0
X-Received: by 10.129.132.195 with SMTP id u186mr3494460ywf.73.1460080377875;
 Thu, 07 Apr 2016 18:52:57 -0700 (PDT)
Received: by 10.37.118.2 with HTTP; Thu, 7 Apr 2016 18:52:57 -0700 (PDT)
In-Reply-To: <20160408003328.GA14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
        <20160408003328.GA14441@codeaurora.org>
Date:   Fri, 8 Apr 2016 10:52:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
Message-ID: <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
Subject: Re: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-clk@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
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
        linux-m68k@lists.linux-m68k.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

Hi Stephen,


2016-04-08 9:33 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 04/05, Masahiro Yamada wrote:
>> The clk_disable() in the common clock framework (drivers/clk/clk.c)
>> returns immediately if a given clk is NULL or an error pointer.  It
>> allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
>> checking if drivers are only used with the common clock framework.
>>
>> Unfortunately, NULL/error checking is missing from some of non-common
>> clk_disable() implementations.  This prevents us from completely
>> dropping NULL/error checking from callers.  Let's make it tree-wide
>> consistent by adding IS_ERR_OR_NULL(clk) to all callees.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Greg Ungerer <gerg@uclinux.org>
>> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
>> ---
>>
>> Stephen,
>>
>> This patch has been unapplied for a long time.
>>
>> Please let me know if there is something wrong with this patch.
>>
>
> I'm mostly confused why we wouldn't want to encourage people to
> call clk_disable or unprepare on a clk that's an error pointer.
> Typically an error pointer should be dealt with, instead of
> silently ignored, so why wasn't it dealt with by passing it up
> the probe() path?
>


This makes our driver programming life easier.


For example, let's see drivers/tty/serial/8250/8250_of.c


The "clock-frequency" DT property takes precedence over "clocks" property.
So, it is valid to probe the driver with a NULL pointer for info->clk.


        if (of_property_read_u32(np, "clock-frequency", &clk)) {

                /* Get clk rate through clk driver if present */
                info->clk = devm_clk_get(&ofdev->dev, NULL);
                if (IS_ERR(info->clk)) {
                        dev_warn(&ofdev->dev,
                                "clk or clock-frequency not defined\n");
                        return PTR_ERR(info->clk);
                }

                ret = clk_prepare_enable(info->clk);
                if (ret < 0)
                        return ret;

                clk = clk_get_rate(info->clk);
        }


As a result, we need to make sure the clk pointer is valid
before calling clk_disable_unprepare().


If we could support pointer checking in callees, we would be able to
clean-up lots of clock consumers.



-- 
Best Regards
Masahiro Yamada
