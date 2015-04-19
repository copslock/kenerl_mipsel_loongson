Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 15:52:07 +0200 (CEST)
Received: from mail-la0-f45.google.com ([209.85.215.45]:33552 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006570AbbDSNwFLvW-T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Apr 2015 15:52:05 +0200
Received: by layy10 with SMTP id y10so109645451lay.0
        for <linux-mips@linux-mips.org>; Sun, 19 Apr 2015 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9Ic5q3Jss+0a4D5WCCoiv/YvQ+bXGzHiwxJO0sVurQA=;
        b=fga+3V9nV0kc6EhqlJHhTXIvA6siKELRSSUNYn5/n8VijfpTdUzwkG0PC/EWVUFdad
         zvq9sE5ZT1tc4eDBjNI/zTelrOIIU8VRREcPuwsSy1i9IcZ7qPATtbmDa2C1PkJpc1Gt
         WtY6mI/mwg4xNeEN/BZN0hF7A1UAu4uBIq1JEWp+4qolrXxDZ/jgmCUKMKqWCtdm1COU
         BdP5h4yg2wD+vS1ioTWRJ0TDNG42sYlMaBaQ0PARBXiUE3sbE/wdlVqQflzGAb3OYAqb
         6bwu6lRPyZxg7Jtkb8B8bKsWGVri8Av35uk8o1RMIYMT01boogr6dBGbJKg+/lzY6xxl
         suVQ==
X-Gm-Message-State: ALoCoQnxNBcmn0A2kaogCkHqVEHWQJvlzh5ts4qYpIE4hPFy+3qGiUNZxeLieVNcAFQ02w85/zVC
X-Received: by 10.152.27.194 with SMTP id v2mr11643114lag.75.1429451520765;
        Sun, 19 Apr 2015 06:52:00 -0700 (PDT)
Received: from [192.168.3.154] (ppp85-141-197-124.pppoe.mtu-net.ru. [85.141.197.124])
        by mx.google.com with ESMTPSA id p3sm3679573lag.13.2015.04.19.06.51.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2015 06:51:59 -0700 (PDT)
Message-ID: <5533B300.2050805@cogentembedded.com>
Date:   Sun, 19 Apr 2015 16:52:00 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
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
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] devicetree: Add bindings for the ATH79 DDR controllers
References: <1429448288-20742-1-git-send-email-albeu@free.fr> <1429448288-20742-4-git-send-email-albeu@free.fr>
In-Reply-To: <1429448288-20742-4-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46934
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

On 4/19/2015 3:57 PM, Alban Bedel wrote:

> The DDR controller of the ARxxx and AR9xxx famillies provides an
> interface to flush the FIFO between various devices and the DDR.
> This is mainly used by the IRQ controller to flush the FIFO before
> running the interrupt handler of such devices.

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
> v2: * Fix the node names to respect ePAPR

    I don't see where you did this.

> ---
>   .../memory-controllers/ath79-ddr-controller.txt    | 35 ++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
>
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt b/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
> new file mode 100644
> index 0000000..5541eed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
> @@ -0,0 +1,35 @@
> +Binding for Qualcomm  Atheros AR7xxx/AR9xxx DDR controller
> +
> +The DDR controller of the ARxxx and AR9xxx famillies provides an interface

    Families.

> +to flush the FIFO between various devices and the DDR. This is mainly used
> +by the IRQ controller to flush the FIFO before running the interrupt handler
> +of such devices.
> +
> +Required properties:
> +
> +- compatible: has to be "qca,<soc-type>-ddr-controller",
> +  "qca,[ar7100|ar7240]-ddr-controller" as fallback.
> +  On SoC with PCI support "qca,ar7100-ddr-controller" should be used as
> +  fallback, otherwise "qca,ar7240-ddr-controller" should be used.
> +- reg: Base address and size of the controllers memory area
> +- #qca,ddr-wb-channel-cells: has to be 1, the index of the write buffer
> +  channel
> +
> +Example:
> +
> +	ddr_ctrl: ddr-controller@18000000 {

    Should still be "memory-controller@18000000".

> +		compatible = "qca,ar9132-ddr-controller",
> +				"qca,ar7240-ddr-controller";
> +		reg = <0x18000000 0x100>;
> +
> +		#qca,ddr-wb-channel-cells = <1>;
> +	};
> +
> +	...
> +
> +	cpuintc@0 {

    "interrupt-controller" here?

> +		...
> +		qca,ddr-wb-channel-interrupts = <2>, <3>, <4>, <5>;
> +		qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>,
> +					<&ddr_ctrl 0>, <&ddr_ctrl 1>;
> +	};

WBR, Sergei
