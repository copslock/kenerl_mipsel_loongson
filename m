Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Sep 2016 01:11:36 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:35003 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992110AbcIPXL30IHhR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Sep 2016 01:11:29 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7208D61802; Fri, 16 Sep 2016 23:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474067487;
        bh=hWX61bU5D6RxCz6bPHa5blbpvOacStBB2JADc128clQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7sIOaTcpHKT3tCmcBlfpo37Qa8FvoRTtcwblkfInMJKvgK0oSF4LtZsTzaDueuaW
         7GHBxM/qXRMJD60IhtuOvLJZOnn3wV44JRmkUHRQarD7RnbztAM5PUWeref0QfD9p7
         6szS5fJZ/vmjv4aFdGJK5nZUZUgsIgdE+hVF4fws=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BA4C61746;
        Fri, 16 Sep 2016 23:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474067486;
        bh=hWX61bU5D6RxCz6bPHa5blbpvOacStBB2JADc128clQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3hzn9e5QuDNOmzlHiHqv1FcvpHi2nsEYomN5Bi7xXrhsO+j/jSNeSSj0IJCzKbzh
         J/wsJthwV6J62nkTQzY8nQwsXmV2OLfglFze90pxssMuZoQObtydw3niwA3LoiTOd0
         1v3jtSqmXIwaDCLuYFXJZY5yIwiNv99o0INgsYuU=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org 4BA4C61746
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=sboyd@codeaurora.org
Date:   Fri, 16 Sep 2016 16:11:25 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>, linux-mips@linux-mips.org,
        Eric Miao <eric.y.miao@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Steven Miao <realmz6@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] clk: let clk_disable() return immediately if clk is
 NULL
Message-ID: <20160916231125.GW7243@codeaurora.org>
References: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
 <194aebe5-38dd-f43d-fb4d-16ce592a68e8@gmail.com>
 <CAK7LNARaV6Ga5G1GnYf9hywrr+YwOqqm-v1AzBpfXtM4u9ofBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARaV6Ga5G1GnYf9hywrr+YwOqqm-v1AzBpfXtM4u9ofBA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55154
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

On 09/16, Masahiro Yamada wrote:
> Hi Stephen, Michael,
> 
> 2016-08-26 0:27 GMT+09:00 Florian Fainelli <f.fainelli@gmail.com>:
> > On 08/24/2016 10:26 AM, Masahiro Yamada wrote:
> >> Many of clk_disable() implementations just return for NULL pointer,
> >> but this check is missing from some.  Let's make it tree-wide
> >> consistent.  It will allow clock consumers to call clk_disable()
> >> without NULL pointer check.
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> Acked-by: Greg Ungerer <gerg@uclinux.org>
> >> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> >> ---
> >>
> >> I came back after a long pause.
> >> You can see the discussion about the previous version:
> >> https://www.linux-mips.org/archives/linux-mips/2016-04/msg00063.html
> >>
> >>
> >> Changes in v3:
> >>   - Return only when clk is NULL.  Do not take care of error pointer.
> >>
> >> Changes in v2:
> >>   - Rebase on Linux 4.6-rc1
> >>
> >>  arch/arm/mach-mmp/clock.c        | 3 +++
> >>  arch/arm/mach-w90x900/clock.c    | 3 +++
> >>  arch/blackfin/mach-bf609/clock.c | 3 +++
> >>  arch/m68k/coldfire/clk.c         | 4 ++++
> >>  arch/mips/bcm63xx/clk.c          | 3 +++
> >
> 
> 
> Gentle ping...
> 
> 
> If you are not keen on this,
> shall I split it per-arch and send to each arch subsystem?
> 

If we get acks from more arch maintainers we could take it
through clk tree, but we really don't maintain these other clk
implementations so it isn't very appropriate to take it through
clk tree anyway. Perhaps splitting it up per arch and sending it
that way and then Ccing akpm (aka the patch collector) would make
sure things get merged in a timely manner. Or Andrew could just
pick up this patch as is.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
