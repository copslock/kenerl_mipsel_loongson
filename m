Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 16:30:50 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37505 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006570AbbDSOasJuYph (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 16:30:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 2C0C1280142;
        Sun, 19 Apr 2015 16:29:53 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com [209.85.216.170])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 35F44280427;
        Sun, 19 Apr 2015 16:29:38 +0200 (CEST)
Received: by qcrf4 with SMTP id f4so46413721qcr.0;
        Sun, 19 Apr 2015 07:30:33 -0700 (PDT)
X-Received: by 10.55.20.207 with SMTP id 76mr21420516qku.46.1429453833236;
 Sun, 19 Apr 2015 07:30:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.146 with HTTP; Sun, 19 Apr 2015 07:30:13 -0700 (PDT)
In-Reply-To: <1429448288-20742-8-git-send-email-albeu@free.fr>
References: <1429448288-20742-1-git-send-email-albeu@free.fr> <1429448288-20742-8-git-send-email-albeu@free.fr>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 19 Apr 2015 16:30:13 +0200
Message-ID: <CAOiHx=nFHarP-Ohjzzvi-V-SYBdrskL+Ur7yqprH8+ZLqGZLXw@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] devicetree: Add bindings for the ATH79 PLL controllers
To:     Alban Bedel <albeu@free.fr>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46936
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

Hi,

On Sun, Apr 19, 2015 at 2:58 PM, Alban Bedel <albeu@free.fr> wrote:
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
> v2: * Fixed the node names to respect ePAPR
>     * Fixed the missing 's' in 'fallbacks' and the 'clocks' property
> ---
>  .../devicetree/bindings/clock/qca,ath79-pll.txt    | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
> new file mode 100644
> index 0000000..df3dbc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
> @@ -0,0 +1,33 @@
> +Binding for Qualcomm Atheros AR7xxx/AR9XXX PLL controller
> +
> +The PPL controller provides the 3 main clocks of the SoC: CPU, DDR and AHB.
> +
> +Required Properties:
> +- compatible: has to be "qca,<soctype>-cpu-intc" and one of the following
> +  fallbacks:
> +  - "qca,ar7100-pll"
> +  - "qca,ar7240-pll"
> +  - "qca,ar9130-pll"
> +  - "qca,ar9330-pll"
> +  - "qca,ar9340-pll"
> +  - "qca,ar9550-pll"

Shouldn't this be "qca,qca9550-pll"?


Jonas
