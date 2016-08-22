Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2016 15:29:24 +0200 (CEST)
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33748 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992002AbcHVN3RseSyH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2016 15:29:17 +0200
Received: by mail-oi0-f54.google.com with SMTP id c15so150219095oig.0
        for <linux-mips@linux-mips.org>; Mon, 22 Aug 2016 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wIG062Qcg2bwGT/8z48wdZBfTDWzqw4HhWWNLtuHwcc=;
        b=PmPn2bAOiQA7DvAoasC/UsXs246MX2/OkQNsm9GmIE82drbUth576tTfiLKGOzO+hN
         snXGh+DhC14HV6jjhOWg3ZXz92JOjbW95MWBRABocb+Fz1o6nYBAcuGZTeY2JesKghlx
         rIJUQv7ZF96wdO65vGqRLJlX7vsBYaChsaH+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wIG062Qcg2bwGT/8z48wdZBfTDWzqw4HhWWNLtuHwcc=;
        b=aSbKgd5X6rLiPADbD165DHobb+jKWv4zU+TQoz2QAA/2U5egPWuwBDZXhX1UiXmCEN
         +uDTOjm4X4ftJQetabl7c//GvS2MtcZMiuzZUiHElSozv6IJoxfhCnkbQLavWZ96c1+V
         0PEpydRZJboie3JZQmwZA2gPonJq/j6U7Urr8ObHM22RBxGqtcgaQESFvbmae68a/lqT
         2/3GyjclJwNYUz905lAYdNqdQwHd+sId3UYiS5ZI5oY90SZ0BEQChFz+f/dFlnND3Rpw
         1sDR6r2ddPQWIfsumU0kuUclznY5v+QfsWvQyilKEGnmg4d7MGvOZLJRdHj/1ZcUOqQL
         EtpA==
X-Gm-Message-State: AEkoouvn3zgkRUsZQoyR+WqHv9Ch5izTN6bFuCKV7g3Aw3I4Kqb0ng4gdygbw/6oE6tJkM66PBK9NTbdvLn6aca8
X-Received: by 10.157.52.180 with SMTP id g49mr13263766otc.195.1471872549558;
 Mon, 22 Aug 2016 06:29:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.76.199 with HTTP; Mon, 22 Aug 2016 06:29:09 -0700 (PDT)
In-Reply-To: <1471604603-23221-1-git-send-email-james.hartley@imgtec.com>
References: <1471604603-23221-1-git-send-email-james.hartley@imgtec.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2016 15:29:09 +0200
Message-ID: <CACRpkda9DL=KPOpXyN8AR7tJ8vmA3=-HS70RHqog_WuczsE-7Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pistachio: fix mfio pll_lock pinmux
To:     James Hartley <james.hartley@imgtec.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "# 4 . 4 . x-" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Fri, Aug 19, 2016 at 1:03 PM, James Hartley <james.hartley@imgtec.com> wrote:

> A previous patch attempted to fix the pinmuxes for mfio 84 - 89, but it
> omitted a change to pistachio_pin_group pistachio_groups, which results
> in incorrect pll_lock signals being routed.
>
> Apply the correct mux settings throughout the driver.
>
> fixes: cefc03e5995e ("pinctrl: Add Pistachio SoC pin control driver")
> fixes: e9adb336d0bf ("pinctrl: pistachio: fix mfio84-89 function description and pinmux.")
>
> Cc: <stable@vger.kernel.org> # 4.4.x-
>
> Signed-off-by: James Hartley <james.hartley@imgtec.com>
> Reviewed-by: Sifan Naeem <Sifan.Naeem@imgtec.com>

Patch applied for fixes.

Yours,
Linus Walleij
