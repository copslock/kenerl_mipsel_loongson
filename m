Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 03:36:11 +0200 (CEST)
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33747 "EHLO
        mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010156AbbCaBgJnNLpr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 03:36:09 +0200
Received: by qgfa8 with SMTP id a8so2843418qgf.0
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 18:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DmYDQYjdX17y7RUUQ1sMc4DXhJ0wgq8i1dEXTU0H6m0=;
        b=n431dv+fUqdUy4Kj7FaAHUYW6iCplaF7JR7eVuYiUFPCggA1INjrXRbv6SCvYMf95w
         C0nMQ85LKmqXeaI3EjjaNnqWghhqNf1Iw3dqWn1TMrNVCEep6iKaAmYkr+ncMrywdwlP
         sA8B4DhbwvRzGm2QblZojyTwSDDpNgcZbD3Ko/HGol4q8N3ILVCWLleIjYMVV5Xhr99w
         v8uK+Sp2pmx0tq/3WMsAHS9Qbs9AdSNuTCyXGBAaKI7nl+QN01ICJnz//YcnQJiwoFPl
         XkiUNlvCLLoFsde/+5CS9KcVux0UWUJTG4d+IEp3iw7C4OYezR3JCXnEnQcaBmpSgsQG
         aNvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DmYDQYjdX17y7RUUQ1sMc4DXhJ0wgq8i1dEXTU0H6m0=;
        b=Ft9RITHYkY9BRgzoqqV0NRog10cu9IkNyK5VckqpkOtsJc3xtvgiq2Cq3ZBiMXi4RY
         8xHm1CoGKME1134Dde7KTcb+lA0ClSJMRfnJknDJf2K92Tu9Fyrqa/LR6gGyD675za5m
         pnaaM8F/Bj7uLbS6DQdlt5m9Io/gyPsj25ZT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DmYDQYjdX17y7RUUQ1sMc4DXhJ0wgq8i1dEXTU0H6m0=;
        b=VgCtVXZh108kFqyfpMUKrMUl37hzTw7Ojpccnhft/B32FdPa57+lXpYNl/yYlOpwBw
         nqFMjBeob8/8GHHwuAXFHF4SPR2xSevlxldYN8PN0ub1q5FgXt0mGOri4WGaoT9ipqZl
         kd7sG311XZNnZCRy5X40/wQ6X13aW5TW/rD5nE3MlDwep3tx1vnm5eB8NltR2caSMidr
         57wboHu9roMeXFegphwqi2XOfICMrUGw+lI7JQKWyR5yPC7mXCXieo4x86yPH2pOQtb4
         F8Zfa1obZ8P6iqsq5AQ1V8T2t6ybymkxclbHLvSvVC9EfDj9xKFHs5ypH3GyVevEeSUp
         BoHQ==
X-Gm-Message-State: ALoCoQlBEzD6McM40v1sEWHIOZAtzH3RtP9tUvE2VrapjIT2F6pP5KIbUbl7R342yhmL8UeDaV7z
MIME-Version: 1.0
X-Received: by 10.55.23.220 with SMTP id 89mr75099186qkx.56.1427765764832;
 Mon, 30 Mar 2015 18:36:04 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Mon, 30 Mar 2015 18:36:04 -0700 (PDT)
In-Reply-To: <5519F6B0.5040809@codeaurora.org>
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
        <1424836567-7252-3-git-send-email-abrestic@chromium.org>
        <5519E37C.9010201@codeaurora.org>
        <CAL1qeaGTtMWDM+p+FpDRP=L-yqQ_ai7LY8GwcBUO_C1F+V1LzQ@mail.gmail.com>
        <5519F6B0.5040809@codeaurora.org>
Date:   Mon, 30 Mar 2015 18:36:04 -0700
X-Google-Sender-Auth: f9L1-hAmZz1KfYk4asYH2Be2LJY
Message-ID: <CAL1qeaHEG2JHUKtEvN=aU2i42KXpxH+XZPquv2b+NBQ6Ko8PZw@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: Add basic infrastructure for Pistachio clocks
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Mon, Mar 30, 2015 at 6:21 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 03/30/15 17:15, Andrew Bresticker wrote:
>> On Mon, Mar 30, 2015 at 4:59 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>> On 02/24/15 19:56, Andrew Bresticker wrote:
>>>> +
>>>> +void pistachio_clk_force_enable(struct pistachio_clk_provider *p,
>>>> +                             unsigned int *clk_ids, unsigned int num)
>>>> +{
>>>> +     unsigned int i;
>>>> +     int err;
>>>> +
>>>> +     for (i = 0; i < num; i++) {
>>>> +             struct clk *clk = p->clk_data.clks[clk_ids[i]];
>>>> +
>>>> +             if (IS_ERR(clk))
>>>> +                     continue;
>>>> +
>>>> +             err = clk_prepare_enable(clk);
>>>> +             if (err)
>>>> +                     pr_err("Failed to enable clock %s: %d\n",
>>>> +                            __clk_get_name(clk), err);
>>>> +     }
>>>> +}
>>>>
>>> Is this to workaround some problems in the framework where clocks are
>>> turned off? Or is it that these clocks are already on before we boot
>>> Linux and we need to make sure the framework knows that?
>> It's the former.  These clocks are enabled at POR and may only be
>> gated as the final step to entering suspend, so they must remain on at
>> runtime.  The issue we were running into was that consumers of these
>> critical clocks or their descendants would enable/disable their clocks
>> during boot or runtime PM and cause these clocks to get disabled.
>> Bumping up the prepare/enable count of these critical clocks seemed
>> like the best way to handle this - is there a more preferred way?
>> FWIW, this is also how the Tegra and Rockchip drivers handled this
>> problem.
>
> Ideally clock providers just provide clocks and don't actually call
> clock consumer APIs. I don't see where these clocks are disabled in this
> series. Is it just because suspend isn't done right now so there isn't a
> place to hook the disable part? I hope that it's a 1:1 relation between
> the clocks that are turned on here and the clocks that are turned off
> during suspend.

Suspend hasn't been hooked up yet and it's still a long ways off.

> I have a slightly similar problem on my hardware. Consider the case
> where the bootloader has left on the display and audio clocks and they
> share a common parent PLL. When the kernel boots up, all it knows is
> that the display clock and audio clock share a common PLL and the rate
> they're running at. If the audio driver probes first, calls clk_enable()
> on the audio clock (almost a no-op except for the fact that we call the
> .enable op when it's already on) and then calls clk_disable() on the
> audio clock when it's done we'll also turn off the shared PLL.
> Unfortunately it's also being used by the display clock for the display
> driver that hasn't probed yet and so the display stops working and it
> may show an artifact or black screen.
>
> Other cases are where certain clocks should never be turned off because
> they're used by some non-linux entity (dram controller for example) and
> we don't have a place to put the clk_prepare_enable() besides in the
> clock driver itself. In these cases, it may be better to tell the
> framework that a clock should always be on. I think this case is what
> Lee Jones is working on here[1].
>
> Do you fall into one of these two cases? It isn't clear to me how
> suspend is special and needs to be dealt with differently. Why wouldn't
> these clocks be always on?

These clocks fall into the latter case in that there's really no good
place to put the clk_prepare_enable() calls, so it looks like I want
to use what Lee is proposing.
