Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 15:53:33 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:56979 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822672Ab3DJNxcgqb-8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 15:53:32 +0200
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com [209.85.220.177])
        by mail.nanl.de (Postfix) with ESMTPSA id BD19A4031C;
        Wed, 10 Apr 2013 13:53:21 +0000 (UTC)
Received: by mail-vc0-f177.google.com with SMTP id hr11so380150vcb.8
        for <multiple recipients>; Wed, 10 Apr 2013 06:53:26 -0700 (PDT)
X-Received: by 10.220.202.138 with SMTP id fe10mr1548121vcb.26.1365602006944;
 Wed, 10 Apr 2013 06:53:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Wed, 10 Apr 2013 06:53:06 -0700 (PDT)
In-Reply-To: <1365594447-13068-9-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org> <1365594447-13068-9-git-send-email-blogic@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 10 Apr 2013 15:53:06 +0200
Message-ID: <CAOiHx=nJBFj+3coeGhHnLLhVU5ihc7OVC=N6juvfdETrsA+vBQ@mail.gmail.com>
Subject: Re: [PATCH 08/18] MIPS: ralink: add RT5350 dtsi file
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On 10 April 2013 13:47, John Crispin <blogic@openwrt.org> wrote:
> Add a dtsi file for RT5350 Soc. This SoC is almost the same as RT3050 but has
> OHCI/EHCI in favour of the Synopsis DWC2 core.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/dts/rt5350.dtsi |  181 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 arch/mips/ralink/dts/rt5350.dtsi
>
> diff --git a/arch/mips/ralink/dts/rt5350.dtsi b/arch/mips/ralink/dts/rt5350.dtsi
> new file mode 100644
> index 0000000..9ca95a3
> --- /dev/null
> +++ b/arch/mips/ralink/dts/rt5350.dtsi
> @@ -0,0 +1,181 @@
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       compatible = "ralink,rt5350-soc";
> +
> +       cpus {
> +               cpu@0 {
> +                       compatible = "mips,mips24KEc";
> +               };
> +       };
> +
> +       chosen {
> +               bootargs = "console=ttyS0,57600 init=/init";

Shouldn't this belong in the individual .dts files instead of the
.dtsi? Likewise for all the other .dtsi files added by this patchset.


Jonas
