Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 18:17:37 +0200 (CEST)
Received: from mail-la0-f48.google.com ([209.85.215.48]:34549 "EHLO
        mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010571AbbDQQRgBLvkw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 18:17:36 +0200
Received: by laat2 with SMTP id t2so84243884laa.1
        for <linux-mips@linux-mips.org>; Fri, 17 Apr 2015 09:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4E9wMNMoyX7Eq6xhvuBoJYYG2Alx2wDrvE7jr4c1vVM=;
        b=hj4rK/ouFgrwN0QKDckgyHUnfr33jKqqLy2blCM7j4Lm007aayJAoBRF5YMuk3GFm3
         glJgpBA5ocZgUSINvaiqAKXJy+PQ1VaAjbnyH5V7S4ZzuPm4KJybtzE84sfoKHLMwt8f
         a7FCAdacNUFiwGEn2MwFxSEBDVvrGeo8JOEfgdD8YQCauzPrN3xuQes1hpfXN5USIgUg
         g+G8HoIKzZ5b4vAvKtij3N72hLdMj79GzhM8VU7DWpVzerQpcZEdt0qoJdzJZratIxar
         IMuL3RHR3uYGgUvshns81FEAR3wsmTn/5g1mdRuPbStYFwj0wYSO/pLDKW7H5EvdU7it
         6b3A==
X-Gm-Message-State: ALoCoQkHYTxIAMvXgV7BTkOLiYkmvbzUKQ5CpHAoJy6p3fvUtc3Z6jvRII2IFOMZRX+VZcHqnEYF
X-Received: by 10.152.22.1 with SMTP id z1mr4920905lae.114.1429287451693;
        Fri, 17 Apr 2015 09:17:31 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp85-141-198-209.pppoe.mtu-net.ru. [85.141.198.209])
        by mx.google.com with ESMTPSA id zf3sm2504905lbb.2.2015.04.17.09.17.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2015 09:17:30 -0700 (PDT)
Message-ID: <55313217.1020604@cogentembedded.com>
Date:   Fri, 17 Apr 2015 19:17:27 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] devicetree: Add bindings for the ATH79 interrupt
 controllers
References: <1429280669-2986-1-git-send-email-albeu@free.fr> <1429280669-2986-5-git-send-email-albeu@free.fr>
In-Reply-To: <1429280669-2986-5-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 04/17/2015 05:24 PM, Alban Bedel wrote:

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>   .../interrupt-controller/qca,ath79-cpu-intc.txt    | 45 ++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt
> new file mode 100644
> index 0000000..1548512
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt
> @@ -0,0 +1,45 @@
> +Binding for Qualcomm Atheros AR7xxx/AR9XXX CPU interrupt controller
> +
> +On most SoC the IRQ controller need to flush the DDR FIFO before running
> +the interrupt handler of some devices. This is configured using the
> +qca,ddr-wb-channels and qca,ddr-wb-channel-interrupts properties.
> +
> +Required Properties:
> +
> +- compatible: has to be "qca,<soctype>-cpu-intc", "qca,ar7100-cpu-intc"
> +  as fallback
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode interrupt
> +		     source, should be 1 for intc
> +
> +Please refer to interrupts.txt in this directory for details of the common
> +Interrupt Controllers bindings used by client devices.
> +
> +Optional Properties:
> +
> +- qca,ddr-wb-channel-interrupts: List of the interrupts needing a write
> +  buffer flush
> +- qca,ddr-wb-channels: List of phandles to the write buffer channels for
> +  each interrupt. If qca,ddr-wb-channel-interrupts is not present the interrupt
> +  default to the entry's index.
> +
> +Example:
> +
> +	cpuintc@0 {

    @0 without the "reg" property?
    And if this is an interrupt controller, the name should be 
"interrupt-controller", not "cpuintc", according to the ePAPR standard.

> +		compatible = "qca,ar9132-cpu-intc", "qca,ar7100-cpu-intc";
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		qca,ddr-wb-channel-interrupts = <2>, <3>, <4>, <5>;
> +		qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>,
> +					<&ddr_ctrl 0>, <&ddr_ctrl 1>;
> +	};
> +
> +	...
> +
> +	ddr_ctrl: ddr-controller@18000000 {

    ePAPR standardized "memory-controller" node name in this case.

WBR, Sergei
