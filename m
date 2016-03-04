Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 19:48:41 +0100 (CET)
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35427 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013234AbcCDSsjKAm2m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 19:48:39 +0100
Received: by mail-vk0-f50.google.com with SMTP id e6so62860689vkh.2
        for <linux-mips@linux-mips.org>; Fri, 04 Mar 2016 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pffMR4tGQxlyz+5Cv+QHX0qRpwMf8p/xzKIRfsVuD0Q=;
        b=U4R/ARvLDDW1NdyRy0/sM+hPC9S1nWBnyoSBFRS4p1YDSFG/0lySEyyet0d8WMU2yg
         xZD4T4s0jCV3REtsnvt43P9sASmPU3KDRbMb5sm8FKn+xBjfEv5w+mbB6hibLeKNZ/IG
         JsauMNKUS6jbHeQpu4wNaRpqIhn3ietDReKGhV889wT25jXUbgc1/HYWs3LLUYVqA3ke
         Id1sf1I98tuE+Z6s3hBH49+atuxttqXenfWx+IQvrKEN27lHozAQN9YTp7x091lar3f4
         qUXTzPFpeLJDIiAgu099wPmzhqBz3azjKRSfziKpZwTNTxvNnS4JwfM5U5fC3g+Xcb1x
         tSqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pffMR4tGQxlyz+5Cv+QHX0qRpwMf8p/xzKIRfsVuD0Q=;
        b=DCy1n82QMqC/Heiz3fHaesqR4T7xpvNfT6BqaWtc9o2MAJrIl/bPZATKj966ZDpEYs
         ElgDBlS0/mYfZ3SpVpGZ55ILe8Q0lwZGNVEaUJR/x6RTvxB4+tTEgB05EZbcEge4rKNf
         +9Om2JGSribCNSpz6b4+S+xBh1t3ZbrS8t9tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pffMR4tGQxlyz+5Cv+QHX0qRpwMf8p/xzKIRfsVuD0Q=;
        b=Umb3w0ode/ghHkJK8vD1dC8OYyq1J3aH9lwAKQZ9U4RN3P3HksgpZIV3FP5L6iMpRf
         4NmA+Cz1+O9lIwPDoyD+5sNZjKorM1DSkV1s4pv70M/g3mTjscVz/xyuDZVicsnjfPOj
         7Sriv/hk/fFij4EvO8kj4uIm3iSpxZX+4urN7XHObfTMFXEeEoa1q2F/rGdOLIhXRqdc
         BloIuApkPw4nqB08iWqX8/t3bZDzlVffDaMGbcMRicQ7ryoAN36fNDZtRzpLyEZdWMQx
         x/+AIjMnNiwyFugKJlabU4HpvjakSLOstN0k/JqykqwSuJ3dAV5+Fp7s88s1LmKY54ZA
         rWzw==
X-Gm-Message-State: AD7BkJLiqrM6tJ+9VpVseTYgYxxcD+0mv1xhXkm57SyGox+CIVgqMYemYmvAInYFFwYYfiAzunv16gAzJZF2p3aX
MIME-Version: 1.0
X-Received: by 10.31.47.207 with SMTP id v198mr7376773vkv.6.1457117313131;
 Fri, 04 Mar 2016 10:48:33 -0800 (PST)
Received: by 10.176.68.65 with HTTP; Fri, 4 Mar 2016 10:48:33 -0800 (PST)
In-Reply-To: <1457105302-15070-1-git-send-email-Govindraj.Raja@imgtec.com>
References: <1457105302-15070-1-git-send-email-Govindraj.Raja@imgtec.com>
Date:   Fri, 4 Mar 2016 10:48:33 -0800
X-Google-Sender-Auth: dqIhFYsDNxyrYJ5QbjtviXM5tvo
Message-ID: <CAL1qeaHYgqCBSAJBEyrEW3d0ys4BGZ8tzFYbJGONPRSO2fGevA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pistachio: fix mfio84-89 function description
 and pinmux.
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Govindraj Raja <Govindraj.Raja@imgtec.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        "Stable kernel (v4.1)" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52453
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

Govindraj,

On Fri, Mar 4, 2016 at 7:28 AM, Govindraj Raja
<Govindraj.Raja@imgtec.com> wrote:
> mfio 84 to 89 are described wrongly, fix it to describe
> the right pin and add them to right pin-mux group.
>
> The correct order is:
>         pll1_lock => mips_pll   -- MFIO_83
>         pll2_lock => audio_pll  -- MFIO_84
>         pll3_lock => rpu_v_pll  -- MFIO_85
>         pll4_lock => rpu_l_pll  -- MFIO_86
>         pll5_lock => sys_pll    -- MFIO_87
>         pll6_lock => wifi_pll   -- MFIO_88
>         pll7_lock => bt_pll     -- MFIO_89
>
> Fixes: cefc03e5995e("pinctrl: Add Pistachio SoC pin control driver")
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: linux-mips@linux-mips.org
> Cc: James Hartley <James.Hartley@imgtec.com>
> Cc: <stable@vger.kernel.org> # v4.2+

Acked-by: Andrew Bresticker <abrestic@chromium.org>

> Do I need to split this patch into dt & pinctrl?
> Or can it be picked up through pinctrl subsystem with dt maintainers Ack?

I would think that since this is a correction to the existing
binding/driver that shouldn't be necessary, but that's up to Linus.

>
>  .../bindings/pinctrl/img,pistachio-pinctrl.txt     | 12 +++++------
>  drivers/pinctrl/pinctrl-pistachio.c                | 24 +++++++++++-----------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
> index 08a4a32..0326154 100644
> --- a/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
> @@ -134,12 +134,12 @@ mfio80            ddr_debug, mips_trace_data, mips_debug
>  mfio81         dreq0, mips_trace_data, eth_debug
>  mfio82         dreq1, mips_trace_data, eth_debug
>  mfio83         mips_pll_lock, mips_trace_data, usb_debug
> -mfio84         sys_pll_lock, mips_trace_data, usb_debug
> -mfio85         wifi_pll_lock, mips_trace_data, sdhost_debug
> -mfio86         bt_pll_lock, mips_trace_data, sdhost_debug
> -mfio87         rpu_v_pll_lock, dreq2, socif_debug
> -mfio88         rpu_l_pll_lock, dreq3, socif_debug
> -mfio89         audio_pll_lock, dreq4, dreq5
> +mfio84         audio_pll_lock, mips_trace_data, usb_debug
> +mfio85         rpu_v_pll_lock, mips_trace_data, sdhost_debug
> +mfio86         rpu_l_pll_lock, mips_trace_data, sdhost_debug
> +mfio87         sys_pll_lock, dreq2, socif_debug
> +mfio88         wifi_pll_lock, dreq3, socif_debug
> +mfio89         bt_pll_lock, dreq4, dreq5
>  tck
>  trstn
>  tdi
> diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
> index 856f736..2673cd9 100644
> --- a/drivers/pinctrl/pinctrl-pistachio.c
> +++ b/drivers/pinctrl/pinctrl-pistachio.c
> @@ -469,27 +469,27 @@ static const char * const pistachio_mips_pll_lock_groups[] = {
>         "mfio83",
>  };
>
> -static const char * const pistachio_sys_pll_lock_groups[] = {
> +static const char * const pistachio_audio_pll_lock_groups[] = {
>         "mfio84",
>  };
>
> -static const char * const pistachio_wifi_pll_lock_groups[] = {
> +static const char * const pistachio_rpu_v_pll_lock_groups[] = {
>         "mfio85",
>  };
>
> -static const char * const pistachio_bt_pll_lock_groups[] = {
> +static const char * const pistachio_rpu_l_pll_lock_groups[] = {
>         "mfio86",
>  };
>
> -static const char * const pistachio_rpu_v_pll_lock_groups[] = {
> +static const char * const pistachio_sys_pll_lock_groups[] = {
>         "mfio87",
>  };
>
> -static const char * const pistachio_rpu_l_pll_lock_groups[] = {
> +static const char * const pistachio_wifi_pll_lock_groups[] = {
>         "mfio88",
>  };
>
> -static const char * const pistachio_audio_pll_lock_groups[] = {
> +static const char * const pistachio_bt_pll_lock_groups[] = {
>         "mfio89",
>  };
>
> @@ -559,12 +559,12 @@ enum pistachio_mux_option {
>         PISTACHIO_FUNCTION_DREQ4,
>         PISTACHIO_FUNCTION_DREQ5,
>         PISTACHIO_FUNCTION_MIPS_PLL_LOCK,
> +       PISTACHIO_FUNCTION_AUDIO_PLL_LOCK,
> +       PISTACHIO_FUNCTION_RPU_V_PLL_LOCK,
> +       PISTACHIO_FUNCTION_RPU_L_PLL_LOCK,
>         PISTACHIO_FUNCTION_SYS_PLL_LOCK,
>         PISTACHIO_FUNCTION_WIFI_PLL_LOCK,
>         PISTACHIO_FUNCTION_BT_PLL_LOCK,
> -       PISTACHIO_FUNCTION_RPU_V_PLL_LOCK,
> -       PISTACHIO_FUNCTION_RPU_L_PLL_LOCK,
> -       PISTACHIO_FUNCTION_AUDIO_PLL_LOCK,
>         PISTACHIO_FUNCTION_DEBUG_RAW_CCA_IND,
>         PISTACHIO_FUNCTION_DEBUG_ED_SEC20_CCA_IND,
>         PISTACHIO_FUNCTION_DEBUG_ED_SEC40_CCA_IND,
> @@ -620,12 +620,12 @@ static const struct pistachio_function pistachio_functions[] = {
>         FUNCTION(dreq4),
>         FUNCTION(dreq5),
>         FUNCTION(mips_pll_lock),
> +       FUNCTION(audio_pll_lock),
> +       FUNCTION(rpu_v_pll_lock),
> +       FUNCTION(rpu_l_pll_lock),
>         FUNCTION(sys_pll_lock),
>         FUNCTION(wifi_pll_lock),
>         FUNCTION(bt_pll_lock),
> -       FUNCTION(rpu_v_pll_lock),
> -       FUNCTION(rpu_l_pll_lock),
> -       FUNCTION(audio_pll_lock),
>         FUNCTION(debug_raw_cca_ind),
>         FUNCTION(debug_ed_sec20_cca_ind),
>         FUNCTION(debug_ed_sec40_cca_ind),
> --
> 2.5.0
>
