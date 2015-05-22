Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:07:48 +0200 (CEST)
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34506 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006627AbbEVRHqVE3Cq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:07:46 +0200
Received: by qkgx75 with SMTP id x75so16503845qkg.1
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4YAvhbH6/COfJ5KdxsFXmmfTbN2cpxeWUoFcOxia+Ns=;
        b=pyWDGUcj6JPeRHzZV62taznzb7tIqnRdKh/dqsJYpqfisGK6uLSuMGrhOltZs3ImvK
         eDOjqxscSoOtBk3ZyK7N25/8WtDIa51UUc8qQkYxkj7uU2UTrJ9K7e1e4S2kLXnMm5He
         70EFIK9+AqcCO2uDIlNpIOnZibS1g86e2jcHnIWiFUjeQZ6tw/qZbk85yZh5Kz+tvtZD
         9cyx5PVyDjF2gD54J2KLUZclXnCrACxuYecsynlfIEr8Bi0siI+uJHkawwllTbv+SjCk
         gh7YJpWnIs6V5Ath1eyDZErmb5LOdqtgEI/OocS+G01IIebwoN+wFSTcJEnR1d4+gECt
         tNkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4YAvhbH6/COfJ5KdxsFXmmfTbN2cpxeWUoFcOxia+Ns=;
        b=mtDNOQejRNGzpIRwU7uAlF2kkblWAaHzK0HX9k9AHFc/J1Q8Ku0n75LbrQ2Ow+bcox
         cpgiS0N/oFFJ5sOhjHwxgu9FkNDTvmRtX87HM8Irmsrd09xwIRWsQjIXCMek4ar1gKwP
         c/2asjb8AM9yaLiMy4HnoXMcdMNL8Eyyijzok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4YAvhbH6/COfJ5KdxsFXmmfTbN2cpxeWUoFcOxia+Ns=;
        b=HikiOLFHUCGq9gB/4GsmO4g8+b4Qy2IIdPeAlQ6aIzzHVVgu3/gvF+YDTLhB+pW9DE
         i5A6d1EcspMbuS2YSeH9tfmnOBdkzHCbUfLYyYU3N/uHzM8kKen+Bq1A9lpkHbeQ6ju4
         qIsBe2GxwuTjM039/2ZEwIt+JnerWCsXBjKvEyId630uvqwDKY5MNkNYwCUGHWmZAq7J
         6PoIBB8UO6oCtIo3Dkci1KT231d0PV/is2tSGx1X7/jFHcz73LVsK7naRpjMsFSt5e85
         If2l0gfCVJN122zZ5AaSzMkTZPiopsapbm+SGBJFE1iGQhHcUuE5B6JIKHRQWrvtcKx9
         KvpA==
X-Gm-Message-State: ALoCoQmRmI1wOx0ghqE63IZOTtz0wCyTpQ7gjdppJFCLCXTAzRXCPTA6Pfri0acqxcmbuGM/l43O
MIME-Version: 1.0
X-Received: by 10.55.41.17 with SMTP id p17mr19988284qkh.86.1432314463152;
 Fri, 22 May 2015 10:07:43 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 10:07:43 -0700 (PDT)
In-Reply-To: <1432252663-31318-6-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432252663-31318-6-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Fri, 22 May 2015 10:07:43 -0700
X-Google-Sender-Auth: c-XWBHL3qKAoGT3dqIoougHv1-o
Message-ID: <CAL1qeaEp2rSAsh=p-s6XwmwjAJee9z3WwRNrghN_u3bEAqCuAQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] clk: pistachio: Add a MUX_F macro to pass clk_flags
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47577
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

On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> As preparation work to support MIPS PLL rate change propagation, this
> commit adds a MUX_F macro to pass clk_flags.
>
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

> --- a/drivers/clk/pistachio/clk.h
> +++ b/drivers/clk/pistachio/clk.h

> @@ -44,11 +45,22 @@ struct pistachio_mux {
>                 .id             = _id,                          \
>                 .reg            = _reg,                         \
>                 .shift          = _shift,                       \
> +               .clk_flags      = CLK_SET_RATE_NO_REPARENT,     \
>                 .name           = _name,                        \
>                 .parents        = _pnames,                      \
>                 .num_parents    = ARRAY_SIZE(_pnames)           \
>         }
>
> +#define MUX_F(_id, _name, _pnames, _reg, _shift, _clkf)                \
> +{                                                               \
> +       .id             = _id,                                  \
> +       .reg            = _reg,                                 \
> +       .shift          = _shift,                               \
> +       .name           = _name,                                \
> +       .parents        = _pnames,                              \
> +       .num_parents    = ARRAY_SIZE(_pnames),                  \
> +       .clk_flags      = _clkf,                                \
> +}

nit: the indentation here is inconsistent with the other macros in this file.
