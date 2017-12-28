Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 18:34:16 +0100 (CET)
Received: from mail-ua0-x241.google.com ([IPv6:2607:f8b0:400c:c08::241]:35239
        "EHLO mail-ua0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990718AbdL1ReFxvup2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 18:34:05 +0100
Received: by mail-ua0-x241.google.com with SMTP id g16so13820937uak.2;
        Thu, 28 Dec 2017 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HyLY9+B4w7fbm8EGHEMapQYPRyiB/P+wwXfHM+8dpMU=;
        b=UKRvuUgrSi/LXfslgPGsQ0j/744WN6yK9aNsfZUreRD7zseOGy7YXrh6qaIJX9wxSB
         tCM0n2VnJR/Xnt5g8KhngheoI8co22ozpUfOk1/gArpnRSuRt9eKcrCoGL7xSG4XytoG
         SMovK5pGdRrXkNFDm6XLo8LZX//MWcnmY+23ra3NrA095vXb9eh/IWjsA2oZf1tjXLqn
         mMVVRWXHl4daHZPdwm/wGD/xx9Up1jpBo3VDUZp1nVgAauLndeP82JlE63IsEH3NGy3O
         8LSaULrJUlFaominBRBXobTH7Uf3wymKh3/+eaSxFJ70bvWeHg0+G2i8J8E1lMp4j393
         VJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HyLY9+B4w7fbm8EGHEMapQYPRyiB/P+wwXfHM+8dpMU=;
        b=PO9X8kzkuW72sy9+ZGD1eUiJnaUssDPx6CJL9dnHX7ayI4U3OfgZtrAYrHw6OsdOe2
         KRAQwpmb5bSQbFzMHjpEMjvnpeprLvmg8JEBeg03qFHR0f7Qqam/XjZb+2NdLI5lWsV2
         pUWgOVq8jUxogmzbReHR+Wutx9AUOsHch/udalSJYMhB9RzOxxhCkACdXSBv37NIU4C8
         dkxaeKv/QEJGGbQqBWlFrTWzbQE5AeOpS0kwPadCVUM6yNdtOkL0nrEk6C6EXjkrB/dI
         oe+Mtbjwpy6wksVF5J+nArtgTcbq8qNttaGoRFQs+dqN5LxmdJvltmqx60EXjhm/uqdV
         GIQw==
X-Gm-Message-State: AKGB3mIk+z5wKkVXq7brIEdJUceCnOxtBHhMiZS1m/WX1Fu/DFaBfw4V
        Jo2GrFQt+kQvxVdbmFCYWNiptIQT6HcO2XJVYYI=
X-Google-Smtp-Source: ACJfBosFmaUifowNryy9aeSZ1BDw7EZu9TTJ7H34L/gF5qojUaTDlY4PwlX2hK06myc+xGmAAvhoKqFk5vLW2BTpd6o=
X-Received: by 10.159.60.25 with SMTP id u25mr35387592uah.57.1514482439563;
 Thu, 28 Dec 2017 09:33:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.49.1 with HTTP; Thu, 28 Dec 2017 09:33:39 -0800 (PST)
In-Reply-To: <20171228162939.3928-6-paul@crapouillou.net>
References: <20171228162939.3928-1-paul@crapouillou.net> <20171228162939.3928-6-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 28 Dec 2017 18:33:39 +0100
X-Google-Sender-Auth: lWa1Ra2lT3_V0WVFZbqknDtV-BY
Message-ID: <CA+7wUswad_8CvHtLOJDRy9WcVKoqwqyaMOGXFQzjYZ4_4oDmFg@mail.gmail.com>
Subject: Re: [PATCH 5/7] MIPS: jz4780: dts: Fix watchdog node
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Hi Paul,

On Thu, Dec 28, 2017 at 5:29 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> - The previous node requested a memory area of 0x100 bytes, while the
>   driver only manipulates four registers present in the first 0x10 bytes.
>
> - The driver requests for the "rtc" clock, but the previous node did not
>   provide any.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index 9b5794667aee..a52f59bf58c7 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -221,7 +221,10 @@
>
>         watchdog: watchdog@10002000 {
>                 compatible = "ingenic,jz4780-watchdog";
> -               reg = <0x10002000 0x100>;
> +               reg = <0x10002000 0x10>;
> +
> +               clocks = <&cgu JZ4780_CLK_RTCLK>;
> +               clock-names = "rtc";
>         };
>
>         nemc: nemc@13410000 {
> --
> 2.11.0
>
>

Looks good, thanks for fixing my mess. Tested on MIPS Creator CI20:

Dec 28 17:27:50 ci20 watchdog[17531]: starting daemon (5.14):
Dec 28 17:27:50 ci20 watchdog[17531]: int=1s realtime=yes sync=no
soft=no mla=0 mem=0
Dec 28 17:27:50 ci20 watchdog[17531]: ping: no machine to check
Dec 28 17:27:50 ci20 watchdog[17531]: file: no file to check
Dec 28 17:27:50 ci20 watchdog[17531]: pidfile: no server process to check
Dec 28 17:27:50 ci20 watchdog[17531]: interface: no interface to check
Dec 28 17:27:50 ci20 watchdog[17531]: temperature: no sensors to check
Dec 28 17:27:50 ci20 watchdog[17531]: test=none(0) repair=none(0)
alive=/dev/watchdog heartbeat=none to=root no_act=no force=no
Dec 28 17:27:50 ci20 watchdog[17531]: watchdog now set to 60 seconds
Dec 28 17:27:50 ci20 watchdog[17531]: hardware watchdog identity:
jz4740 Watchdog

pkill + reboot = ok

Reviewed-by: Mathieu Malaterre <malat@debian.org>
