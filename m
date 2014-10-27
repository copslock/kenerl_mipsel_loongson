Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 17:22:26 +0100 (CET)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35660 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011405AbaJ0QWYY5u4m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 17:22:24 +0100
Received: by mail-ie0-f177.google.com with SMTP id tp5so4473592ieb.8
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 09:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=e0CnaL/3P4IMwad7CLfgXiKa8u11vFtTQvJni3Vzl/o=;
        b=DdyxihimnUrtuUZCwCfS0Flsu3wwmP+ro+BmhFY6Wx/xRDBrAkdk70FcPqFD9vZZwA
         mHEqqDktV2A855zyflYCcL550sztRA3lj4N7xc43Cqonhv1ToTW96UPSBEZW5meSGuoI
         SMyUMcqGW6q0cBVg9SpiG/p9gl6oWpdCdMm0Xh0TOLUTPGUE1YG+0MHQYAImCm268MVH
         d7YIQGOUpsjiWUzaZvBAloLFXkeVlvMMrXPQyZ5Mvf98/tu6xdUh9icuzQkdEDBGK1Vl
         i0kKwtBAmTPRKQY7PqGyteDPIzzHQPFKx+aPtsSeo7UJOv6/V131jWBK6jBMC6shoiC/
         R+6w==
X-Gm-Message-State: ALoCoQnc9v1hRV5UlxSv5W56AZof+pqaU7hSc8KfFPAY35oWWV5ZqdVTR4TcqP8OzUANFkgx2Qqa
MIME-Version: 1.0
X-Received: by 10.107.32.4 with SMTP id g4mr24176922iog.20.1414426938588; Mon,
 27 Oct 2014 09:22:18 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Mon, 27 Oct 2014 09:22:18 -0700 (PDT)
In-Reply-To: <1412823327-10296-4-git-send-email-blogic@openwrt.org>
References: <1412823327-10296-1-git-send-email-blogic@openwrt.org>
        <1412823327-10296-4-git-send-email-blogic@openwrt.org>
Date:   Mon, 27 Oct 2014 17:22:18 +0100
Message-ID: <CACRpkdbq3u-PoPiN5patknfv5o1-XrVYkGbwTGRCsYpXuuOiGA@mail.gmail.com>
Subject: Re: [PATCH 3/4] pinctrl: ralink: add binding documentation
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43598
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

On Thu, Oct 9, 2014 at 4:55 AM, John Crispin <blogic@openwrt.org> wrote:

> Signed-off-by: John Crispin <blogic@openwrt.org>

This does not seem complete since it lacks things like the very
controversial gpio-base thing.

> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.txt
> @@ -0,0 +1,74 @@
> +Ralink rt2880 pinmux controller
> +
> +Required properties:
> +- compatible: "lantiq,rt2880-pinmux"
> +- reg: Should contain the physical address and length of the gpio/pinmux
> +  register range
> +
> +The rt2880 pinmux can only set the muxing of pin groups. muxing indiviual pins
> +is not supported. There is no pinconf support.
> +
> +Definition of mux function groups:
> +
> +Required subnode-properties:
> +- ralink,group : An array of strings. Each string contains the name of a group.
> +  Valid values for these names are listed below.
> +- ralink,function: A string containing the name of the function to mux to the
> +  group. Valid values for function names are listed below.

Just use "function" and "group" from the generic bindings.

Yours,
Linus Walleij
