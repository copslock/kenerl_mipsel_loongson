Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2015 23:22:45 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38141 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010008AbbJHVWnHtSF2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Oct 2015 23:22:43 +0200
Received: by wiclk2 with SMTP id lk2so42768502wic.1
        for <linux-mips@linux-mips.org>; Thu, 08 Oct 2015 14:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AkhnTJKQ6CGXTleaWY9Qyd6jFp3mIR3a2AV5VxxtXDo=;
        b=k4TQ31cCXUCYOKxf4UayNzMMYWBjGO0EMuv4chYCuuA3wXxTrLyOV9zf4uxT9065HN
         lKNQwfAFov4eBzqKbEw1bvL4qCHX+Lt0zUW4QPpnGcrthRw4sMh6F+HVY/NNQKbn0Hjw
         1Znebf1ppwgk5DWimg1xdjXc/NbolgcyADG4CDYaQcpZF/ZnpQ8evc9IPaFQjY9eZZI/
         ASaE/v0O5OkK2ASDV3c4FPVVXnTmojjXsjDdT6VHTSXPf+SzWU+hkwkjF2JW1pigCvR0
         l0beKHT0qEzKB5BLJR5jMX4yil7RptRvfUBOPa59ngtnKH4kLQ4F3CbGTYpu1SAtlFUK
         m8fw==
X-Gm-Message-State: ALoCoQlMSRgtXiSNnoePbrG0sTgMA/DuM5H1ArOt4fOGa7md6z41uhfxqwtOSUmf+7S4YJbG+s81
MIME-Version: 1.0
X-Received: by 10.194.81.169 with SMTP id b9mr10509743wjy.3.1444339356604;
 Thu, 08 Oct 2015 14:22:36 -0700 (PDT)
Received: by 10.194.121.69 with HTTP; Thu, 8 Oct 2015 14:22:36 -0700 (PDT)
In-Reply-To: <1444148837-10770-4-git-send-email-harvey.hunt@imgtec.com>
References: <1444148837-10770-1-git-send-email-harvey.hunt@imgtec.com>
        <1444148837-10770-4-git-send-email-harvey.hunt@imgtec.com>
Date:   Thu, 8 Oct 2015 18:22:36 -0300
Message-ID: <CAAEAJfBtOtiEEJy500-Kg8ZHm+ZGF3vL7y7xJD3a0-3CJ0w33A@mail.gmail.com>
Subject: Re: [PATCH v7,3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Alex Smith <alex@alex-smith.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

On 6 October 2015 at 13:27, Harvey Hunt <harvey.hunt@imgtec.com> wrote:
> From: Alex Smith <alex.smith@imgtec.com>
>
> Add device tree nodes for the NEMC and BCH to the JZ4780 device tree,
> and make use of them in the Ci20 device tree to add a node for the
> board's NAND.
>
> Note that since the pinctrl driver is not yet upstream, this includes
> neither pin configuration nor busy/write-protect GPIO pins for the
> NAND. Use of the NAND relies on the boot loader to have left the pins
> configured in a usable state, which should be the case when booted
> from the NAND.
>
> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
> Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: Alex Smith <alex@alex-smith.me.uk>
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> ---
> v6 -> v7:
>  - Add nand-ecc-mode to DT.
>  - Add nand-on-flash-bbt to DT.
>
> v4 -> v5:
>  - New patch adding DT nodes for the NAND so that the driver can be
>    tested.
>
>  arch/mips/boot/dts/ingenic/ci20.dts    | 54 ++++++++++++++++++++++++++++++++++
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 26 ++++++++++++++++
>  2 files changed, 80 insertions(+)
>
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index 9fcb9e7..453f1d3 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -42,3 +42,57 @@
>  &uart4 {
>         status = "okay";
>  };
> +
> +&nemc {
> +       status = "okay";
> +
> +       nand: nand@1 {
> +               compatible = "ingenic,jz4780-nand";
> +               reg = <1 0 0x1000000>;
> +

Why is this in the ci20.dts instead of the SoC dtsi?

Seems at least compatible and reg is not board-specific.

Thanks,
-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar
