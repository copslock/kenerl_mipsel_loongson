Return-Path: <SRS0=AFgm=S3=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8991C43219
	for <linux-mips@archiver.kernel.org>; Thu, 25 Apr 2019 19:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF4B20717
	for <linux-mips@archiver.kernel.org>; Thu, 25 Apr 2019 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220594;
	bh=O7CZtgQWz7ZqtzXavLJGzCtCNruVZi0wytFo4SHqKuU=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=aCLjspG44H1vF4/FXRIUc80spn+XxnDdu4HLAYBmeTI7nSSS2LM6T6g9wczAnjIe2
	 tszgbpxp8ialqBfLdj76XAYR2xbXcMOaQHtwhhzd+NI0ef2yDaAn2whWg67QKekc64
	 oyYClq4kHhvcmhDt6SGg9U5MWYIHmszwhSye8rZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfDYT3y (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfDYT3y (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 25 Apr 2019 15:29:54 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6472020685;
        Thu, 25 Apr 2019 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556220593;
        bh=O7CZtgQWz7ZqtzXavLJGzCtCNruVZi0wytFo4SHqKuU=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=UKBX7OSBiCNNey6nlAW/SC7S/ODODRgqMVbvRk+rFSQ1h7Urcz1jFBQOpHQoug77g
         93I3iOT/IKcxHn/vRiViAAF52OY0dk2itUeJKfCkjkgF5h0e6HPHEBH1i3zeR4OJ5n
         4YzC9X2ACWI3bVGsUOof6WLIuj3K3S/2df2woGKM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190405000129.19331-3-drvlabo@gmail.com>
References: <20190405000129.19331-1-drvlabo@gmail.com> <20190405000129.19331-3-drvlabo@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v2 2/5] dt-bindings: clk: add document for ralink clock driver
To:     John Crispin <john@phrozen.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Message-ID: <155622059236.15276.15417177789148260137@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:29:52 -0700
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Quoting NOGUCHI Hiroshi (2019-04-04 17:01:26)
> Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
> ---
>  .../bindings/clock/ralink,rt2880-clock.txt    | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ralink,rt2880=
-clock.txt
>=20
> diff --git a/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.=
txt b/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
> new file mode 100644
> index 000000000000..2fc0d622e01e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
> @@ -0,0 +1,58 @@
> +* Clock bindings for Ralink/Mediatek MIPS based SoCs
> +
> +Required properties:
> + - compatible: must be "ralink,rt2880-clock"
> + - #clock-cells: must be 1
> + - ralink,sysctl: a phandle to a ralink syscon register region
> + - clock-indices: identifying number.
> +       These must correspond to the bit number in CLKCFG1.

These look like driver level details that we're putting in the DT so we
can compress the number space that consumers use. Is that right? If so,
I don't get it. Can we not use this property?

> +       Clock consumers use one of them as #clock-cells index.
> + - clock-output-names: array of gating clocks' names
> + - clocks: array of phandles which points the parent clock
> +       for gating clocks.
> +       If gating clock does not need parent clock linkage,
> +       we bind to dummy clock whose frequency is zero.
> +
> +
> +Example:
> +
> +/* dummy parent clock node */
> +dummy_ck: dummy_ck {
> +       #clock-cells =3D <0>;
> +       compatible =3D "fixed-clock";
> +       clock-frequency =3D <0>;
> +};

Would this ever exist in practice? If not, please remove from the
example so we don't get the wrong idea.

> +
> +clkctrl: clkctrl {
> +       compatible =3D "ralink,rt2880-clock";
> +       #clock-cells =3D <1>;
> +       ralink,sysctl =3D <&sysc>;
> +
> +       clock-indices =3D
> +                       <12>,
> +                       <16>, <17>, <18>, <19>,
> +                       <20>,
> +                       <26>;
> +       clock-output-names =3D
> +                       "uart0",
> +                       "i2c", "i2s", "spi", "uart1",
> +                       "uart2",
> +                       "pcie0";
> +       clocks =3D
> +                       <&pll MT7620_CLK_PERIPH>,
> +                       <&pll MT7620_CLK_PERIPH>, <&pll MT7620_CLK_PCMI2S=
>, <&pll MT7620_CLK_SYS>, <&pll MT7620_CLK_PERIPH>,
> +                       <&pll MT7620_CLK_PERIPH>,
> +                       <&dummy_ck>;
> +       };
> +};
> +
> +/* consumer which refers "uart0" clock */
> +uart0: uartlite@c00 {
> +       compatible =3D "ns16550a";
> +       reg =3D <0xc00 0x100>;
> +
> +       clocks =3D <&clkctrl 12>;

So 12 matches in indices and then that is really "uart0" clk?

> +       clock-names =3D "uart0";
> +
