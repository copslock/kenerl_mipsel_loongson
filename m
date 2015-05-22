Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:46:05 +0200 (CEST)
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35600 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006684AbbEVRqDPB-9r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:46:03 +0200
Received: by qkdn188 with SMTP id n188so17455562qkd.2
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Uvc84kVYGupc+NqE3xMeBDGX/cckQV4JGbak+2DYFqM=;
        b=Kn/hK5N8JidZjdfXVdZ1YpTTIDxidqauxtCrRsKYGg6DB9R9pggQP5DCo0dKnQ1T97
         C/XgysimTjfrTm4zCxgCFf0k3v++CXdKffS2Iu0aLeAb44DmOsfO4pEWh3UbngkxhGYl
         igMJVci3XVLqNw523fe1QOWgdJ/511H+25LIFHkWbHzowVdjDyPuQg1WHE9y67XT/pmw
         etdixiqPP+zdy5QYYy0JgNGRuY4oRu1g2xLmzkQ5luYUW8x9TnK3+clsJfRDAyov5ptt
         qc6wLToMesWFKE1BvspG2/KGzDavtwANAnltkUEs/IY50Oi6N8tfrJ2KUN+hmoXNq0V8
         gzqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Uvc84kVYGupc+NqE3xMeBDGX/cckQV4JGbak+2DYFqM=;
        b=OQkYAgovHuAoECUceiM1RwdcryM9Jw3/9q/g2HoHTASOXGiLbUSZTNIvrSj8WJQaQx
         8EMrs5vSQfXuodC2bWPBtBsVPnFW0veOLRy+2cHvM4Sajg/gFyDkmfgbAJdUNAtR7muH
         TuAPAaf0wpXvUtOStBRp7ZX/MR60BX8GFjdkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Uvc84kVYGupc+NqE3xMeBDGX/cckQV4JGbak+2DYFqM=;
        b=UpXIKg9J4szs7fgz8mcqG6FbA+hHvegJhz0idDwyH+mXqbYOsQg1lTrWweXRZSSK9g
         khLrM+vO/f/xH8qrA3m3SyvZleIWCi6WKCvOdn6+PYU1Y+GiA0LDHrtB7l1RmO9Gu4nE
         rzGHAGe52WbMj0EW+3fWM6USnF562SPNYlaZtTOgIi7jzpdoOj7lohO2jdbKWKjAQaaa
         ZGlXT9cO21lFJpcrtYWLDWy6bZP9Lr/rOSjJ61TivBoo3XkLiH73donD4tflFv1I/nNL
         4vwIZlrBHbi1vyEj4k1jhUPGY4Tyy7huz2WfqdivUwWzpAlg1+/ANOJl87kfxKxtfC2Y
         ewag==
X-Gm-Message-State: ALoCoQnKZoesJyj3UP0vWVojMHu4BdsaBGjiBxNYgS5Zn5lvrBaPMD0zsMrFV4kRWvoiT2b7ED5f
MIME-Version: 1.0
X-Received: by 10.55.56.8 with SMTP id f8mr20418553qka.97.1432316757927; Fri,
 22 May 2015 10:45:57 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 10:45:57 -0700 (PDT)
In-Reply-To: <1432252663-31318-8-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432252663-31318-8-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Fri, 22 May 2015 10:45:57 -0700
X-Google-Sender-Auth: 8V2_Dx0aK6tjTTEThsLJmNSpuGE
Message-ID: <CAL1qeaHQjtVBNN8OB3TDLKSD9WszTQ2n+RwhoK-PMhtUAQYYtA@mail.gmail.com>
Subject: Re: [PATCH 7/9] clk: pistachio: Add a rate table for the MIPS PLL
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
X-archive-position: 47581
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
> This commit adds a rate parameter table, which makes it possible for
> the MIPS PLL to support rate change.
>
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  drivers/clk/pistachio/clk-pistachio.c | 12 +++++++++++-
>  drivers/clk/pistachio/clk.h           | 12 ++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
> index 22a7ebd..0ac7429 100644
> --- a/drivers/clk/pistachio/clk-pistachio.c
> +++ b/drivers/clk/pistachio/clk-pistachio.c
> @@ -145,8 +145,18 @@ static struct pistachio_mux pistachio_muxes[] __initdata = {
>         MUX(CLK_BT_PLL_MUX, "bt_pll_mux", mux_xtal_bt, 0x200, 17),
>  };
>
> +static struct pistachio_pll_rate_table mips_pll_rates[] = {
> +       MIPS_PLL_RATES(52000000, 416000000, 1, 16, 2, 1),
> +       MIPS_PLL_RATES(52000000, 442000000, 1, 17, 2, 1),
> +       MIPS_PLL_RATES(52000000, 468000000, 1, 18, 2, 1),
> +       MIPS_PLL_RATES(52000000, 494000000, 1, 19, 2, 1),
> +       MIPS_PLL_RATES(52000000, 520000000, 1, 20, 2, 1),
> +       MIPS_PLL_RATES(52000000, 546000000, 1, 21, 2, 1),
> +};
> +
>  static struct pistachio_pll pistachio_plls[] __initdata = {
> -       PLL_FIXED(CLK_MIPS_PLL, "mips_pll", "xtal", PLL_GF40LP_LAINT, 0x0),
> +       PLL(CLK_MIPS_PLL, "mips_pll", "xtal", PLL_GF40LP_LAINT, 0x0,
> +           mips_pll_rates),
>         PLL_FIXED(CLK_AUDIO_PLL, "audio_pll", "audio_refclk_mux",
>                   PLL_GF40LP_FRAC, 0xc),
>         PLL_FIXED(CLK_RPU_V_PLL, "rpu_v_pll", "xtal", PLL_GF40LP_LAINT, 0x20),
> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
> index 3bb6bbe..b5d22d6 100644
> --- a/drivers/clk/pistachio/clk.h
> +++ b/drivers/clk/pistachio/clk.h
> @@ -121,6 +121,18 @@ struct pistachio_pll_rate_table {
>         unsigned int frac;
>  };
>
> +#define MIPS_PLL_RATES(_fref, _fout, _refdiv, _fbdiv,  \
> +                      _postdiv1, _postdiv2)            \
> +{                                                       \
> +       .fref           = _fref,                        \
> +       .fout           = _fout,                        \
> +       .refdiv         = _refdiv,                      \
> +       .fbdiv          = _fbdiv,                       \
> +       .postdiv1       = _postdiv1,                    \
> +       .postdiv2       = _postdiv2,                    \
> +       .frac           = 0,                            \
> +}

Wouldn't this be applicable to any integer PLL, not just MIPS_PLL?
Also, maybe we should just populate fout_{min,max} here, setting them
to _fout?  See my comment in patch 3/9.
