Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Sep 2017 19:41:44 +0200 (CEST)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:34646
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994887AbdIDRlTE40lF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Sep 2017 19:41:19 +0200
Received: by mail-io0-x241.google.com with SMTP id f99so605125ioi.1;
        Mon, 04 Sep 2017 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1TT2p08IyUd6YqFelYg6aq6D4/BLi0wDUG+g0FSBF6I=;
        b=ks7yfl3+hgGx4X+uaOGVodt+bkYB8/THCXc3BQCHflQf9S1J/XkNhKmK9pQvP3Vs1s
         NSHUqJkg0wi/La0Bv2GAfFTYbMLi0qmmIuZxs2yvKe/lSPkRp1xJPnC9ELZkoRArsFjX
         Gcgshj8Mip/wNjz+zpUF/IM+kBTkeEq7SDsIgGz0HVZb6MpGm3SA0ksfWoA1v1CqQmUH
         hX1/Fh5joivNtZS396g1oyHrXt6dKUFQ6zU5sr/FIY716fH4eGaaKQt0HsfaiFwcL2wx
         htLH3BAvLj/hIiHR9+BNWT7YwX9NifkCBX4DDJbq3ZFqe3tZyqJ1vJgKlxiwJwMxWqXw
         mNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1TT2p08IyUd6YqFelYg6aq6D4/BLi0wDUG+g0FSBF6I=;
        b=dg+mY9HShXtgOjqyhgcr4NMm7cT8pBrNycUpbwsg7q5h3RZtra5YBoC9uEliD2LBr6
         yzF9LQDqYY4PC/szQW55WHV4o0YOXLNEtyq8MYraoPQzUvkTj1pNye9Dq3DD1ihBPxby
         sVxpe336KhGY+pFEtS1tTkwNKK70LsHZl8wSHKxj8v0rUcZ1CVZR202VYgzspfWnWtul
         xOHnjmRwLuNg3pLbH71DFDaUOhnrz3jdc1n1oQGgv50Agpa3e9pmGNC5ZGu9UjcQampx
         6I6O37bQjQZO0ZymLuAaiTPHnrgEMwgnvAx1yzCQzSymfdXcMONUcpmvCsOIUuCDm5+O
         Ku3A==
X-Gm-Message-State: AHPjjUhvrjhBbInYBrPWG60YCgN33HJmjVz0aCiXgqqDT19rHRvLCJlO
        pTe0X6qy1mDuNMh+KFH+ABoGMGG6piyv/eM=
X-Google-Smtp-Source: ADKCNb78fUASZ+v3Vu0rpTHBe4EWWSwAK2tZMfZqcUhmQFcgxG3vPfnaxRPiifZmBkv6bzQKw/ylgSABUYkL5YGCMB8=
X-Received: by 10.107.138.160 with SMTP id c32mr1535054ioj.97.1504546873336;
 Mon, 04 Sep 2017 10:41:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.153.53 with HTTP; Mon, 4 Sep 2017 10:40:52 -0700 (PDT)
In-Reply-To: <20170819221823.13850-8-hauke@hauke-m.de>
References: <20170819221823.13850-1-hauke@hauke-m.de> <20170819221823.13850-8-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 4 Sep 2017 19:40:52 +0200
Message-ID: <CAFBinCD_q4=x-HB1rnLkGt_x+2dgUqhUe6t1a+PVt41hZGPhAQ@mail.gmail.com>
Subject: Re: [PATCH v10 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

On Sun, Aug 20, 2017 at 12:18 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).
>
> The RCU register range is used for multiple purposes. Mostly one device
> uses one or multiple register exclusively, but for some registers some
> bits are for one driver and some other bits are for a different driver.
> With this patch all accesses to the RCU registers will go through
> syscon.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you Hauke for pushing this!

> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> new file mode 100644
> index 000000000000..7b9be2d13c53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> @@ -0,0 +1,90 @@
> +Lantiq XWAY SoC RCU binding
> +===========================
> +
> +This binding describes the RCU (reset controller unit) multifunction device,
> +where each sub-device has it's own set of registers.
> +
> +The RCU register range is used for multiple purposes. Mostly one device
> +uses one or multiple register exclusively, but for some registers some
> +bits are for one driver and some other bits are for a different driver.
> +With this patch all accesses to the RCU registers will go through
> +syscon.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible   : The first and second values must be:
> +                 "lantiq,xrx200-rcu", "simple-mfd", "syscon"
> +- reg          : The address and length of the system control registers
> +
> +
> +-------------------------------------------------------------------------------
> +Example of the RCU bindings on a xRX200 SoC:
> +       rcu0: rcu@203000 {
> +               compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
> +               reg = <0x203000 0x100>;
> +               ranges = <0x0 0x203000 0x100>;
> +               big-endian;
> +
> +               gphy0: gphy@20 {
> +                       compatible = "lantiq,xrx200a2x-gphy";
> +                       reg = <0x20 0x4>;
> +
> +                       resets = <&reset0 31 30>, <&reset1 7 7>;
> +                       reset-names = "gphy", "gphy2";
> +                       lantiq,gphy-mode = <GPHY_MODE_GE>;
> +               };
> +
> +               gphy1: gphy@68 {
> +                       compatible = "lantiq,xrx200a2x-gphy";
> +                       reg = <0x68 0x4>;
> +
> +                       resets = <&reset0 29 28>, <&reset1 6 6>;
> +                       reset-names = "gphy", "gphy2";
> +                       lantiq,gphy-mode = <GPHY_MODE_GE>;
> +               };
> +
> +               reset0: reset-controller@10 {
> +                       compatible = "lantiq,xrx200-reset";
> +                       reg = <0x10 4>, <0x14 4>;
> +
> +                       #reset-cells = <2>;
> +               };
> +
> +               reset1: reset-controller@48 {
> +                       compatible = "lantiq,xrx200-reset";
> +                       reg = <0x48 4>, <0x24 4>;
> +
> +                       #reset-cells = <2>;
> +               };
> +
> +               usb_phy0: usb2-phy@18 {
> +                       compatible = "lantiq,xrx200-usb2-phy";
> +                       reg = <0x18 4>, <0x38 4>;
> +                       status = "disabled";
> +
> +                       resets = <&reset1 4 4>, <&reset0 4 4>;
> +                       reset-names = "phy", "ctrl";
> +                       #phy-cells = <0>;
> +               };
> +
> +               usb_phy1: usb2-phy@34 {
> +                       compatible = "lantiq,xrx200-usb2-phy";
> +                       reg = <0x34 4>, <0x3C 4>;
> +                       status = "disabled";
> +
> +                       resets = <&reset1 5 4>, <&reset0 4 4>;
> +                       reset-names = "phy", "ctrl";
> +                       #phy-cells = <0>;
> +               };
> +
> +               reboot@10 {
> +                       compatible = "syscon-reboot";
> +                       reg = <0x10 4>;
> +
> +                       regmap = <&rcu0>;
> +                       offset = <0x10>;
> +                       mask = <0x40000000>;
> +               };
> +       };
> +
> --
> 2.11.0
>
