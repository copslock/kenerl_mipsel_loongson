Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 06:12:39 +0200 (CEST)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36564 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009298AbbDVEMhg3nWf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 06:12:37 +0200
Received: by wizk4 with SMTP id k4so162468933wiz.1
        for <linux-mips@linux-mips.org>; Tue, 21 Apr 2015 21:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KjJpkGpk1NEw053Dtnz2D5QbijiLssMK+sJCDy7Q3Lk=;
        b=sDYsFmy3me6xBphKjEeNVltsm3LU84TdVilrFBLRsL+A+1LAmX44a9Gdv47br4Jjep
         6TP/n+Lz2QqwWZp6JPcl2Fk7ZEq4ZC7V9UgPRj7dfcKPo10f1Sdy/VNPfC+duT9a8i5g
         GP11BLit4KWcEJfMhQXfQBuKszVhV7K1Rgl5Cbwv0u/Nvar9yAs1f7gufQF4axJq+0NK
         eAjfyf5TGjlck1oIbq717XphKrrh332GTe9PM0N0RNqENwr7OJ5Ikv+FHGQaZRQwkmoP
         YfgSrGw8iAuxRYY7YhYU1Zy+XpH+LTjex+HpCaD3s+Lunb4eBp/gwHI1qWlR/O06YxkO
         KxOw==
X-Received: by 10.180.87.199 with SMTP id ba7mr2152539wib.81.1429675954007;
 Tue, 21 Apr 2015 21:12:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.139.195 with HTTP; Tue, 21 Apr 2015 21:12:13 -0700 (PDT)
In-Reply-To: <1429627624-30525-34-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com> <1429627624-30525-34-git-send-email-paul.burton@imgtec.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Tue, 21 Apr 2015 23:12:13 -0500
Message-ID: <CAL_JsqLdeN4K0Gru2PXuts=MSTwAWr81-Caa+0rUJmsDqeLtPw@mail.gmail.com>
Subject: Re: [PATCH v3 33/37] devicetree: document Ingenic SoC UART binding
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Tue, Apr 21, 2015 at 9:47 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> Add binding documentation for the UARTs found in Ingenic SoCs.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: devicetree@vger.kernel.org

And for this one too:

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes in v3:
>   - Merge binding documentation for Ingenic SoCs whose bindings differ
>     only by their compatible strings.
>
> Changes in v2:
>   - None.
> ---
>  .../devicetree/bindings/serial/ingenic,uart.txt    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/ingenic,uart.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> new file mode 100644
> index 0000000..c2d3b3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> @@ -0,0 +1,22 @@
> +* Ingenic SoC UART
> +
> +Required properties:
> +- compatible : "ingenic,jz4740-uart" or "ingenic,jz4780-uart"
> +- reg : offset and length of the register set for the device.
> +- interrupts : should contain uart interrupt.
> +- clocks : phandles to the module & baud clocks.
> +- clock-names: tuple listing input clock names.
> +       Required elements: "baud", "module"
> +
> +Example:
> +
> +uart0: serial@10030000 {
> +       compatible = "ingenic,jz4740-uart";
> +       reg = <0x10030000 0x100>;
> +
> +       interrupt-parent = <&intc>;
> +       interrupts = <9>;
> +
> +       clocks = <&ext>, <&cgu JZ4740_CLK_UART0>;
> +       clock-names = "baud", "module";
> +};
> --
> 2.3.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
