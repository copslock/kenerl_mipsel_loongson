Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 18:07:53 +0100 (CET)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34254 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012582AbbBDRHrEZHnn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 18:07:47 +0100
Received: by mail-lb0-f176.google.com with SMTP id z12so2634806lbi.7
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 09:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=sp9WHrmleYQ/lpQHHEFjY95eYvRAtV1ILwgoAUNToB8=;
        b=kCd0FjYI78iBqZHyAtQP629oSsh0vPA1mWckNCXnsWpuHuX3WxQ2Wb7iim1xn6qnWO
         wxkCfA6IZsQMudC78ukPahS4kHTGMLvjCNhSOBxWpVcW1P6bHVe2U0WT6jtXfazMTKxF
         6QSvkYJH8dvVzC2wgVYGoZSAI7IGYWTGRRkcSIoEPPyEUdMhQ5ckyr7xTiIKHWZ/kwtX
         5cecY22suhV/N3GSZBWO1u0xcKbFiD1jVc2amFig5kB8/rpakf0CZrRl6qfbjrFfwS5N
         RjOlB2Dm15qzdsJtFYL1QH3eFdqtOiP9mXUf7E45JkGggFagFAi6TFqBFG2qU5Afk3qG
         Jb6w==
X-Gm-Message-State: ALoCoQlljpy9l1orOyzOosLew2r5wvIaKFvzDPI3dtHVh3oOZ0XXYoFTgHLehS97SMzFnZZrra0r
X-Received: by 10.152.28.37 with SMTP id y5mr10950282lag.55.1423069661808;
        Wed, 04 Feb 2015 09:07:41 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp16-217.pppoe.mtu-net.ru. [81.195.16.217])
        by mx.google.com with ESMTPSA id z15sm462443lbn.48.2015.02.04.09.07.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2015 09:07:40 -0800 (PST)
Message-ID: <54D251DA.1020807@cogentembedded.com>
Date:   Wed, 04 Feb 2015 20:07:38 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org
CC:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org,
        jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net,
        lars@metafoo.de, paul.burton@imgtec.com
Subject: Re: [PATCH_V2 07/34] dt: interrupt-controller: Add ingenic,jz4740-intc
 binding doc
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-8-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1423063323-19419-8-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45696
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

On 02/04/2015 06:21 PM, Zubair Lutfullah Kakakhel wrote:

> From: Paul Burton <paul.burton@imgtec.com>

> Add binding documentation for the Ingenic jz4740 interrupt controller.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: devicetree@vger.kernel.org
> ---
>   .../interrupt-controller/ingenic,jz4740-intc.txt   | 26 ++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt
> new file mode 100644
> index 0000000..5e7f4bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt
> @@ -0,0 +1,26 @@
> +Ingenic jz4740 SoC Interrupt Controller

    JZ4740?

> +
> +Required properties:
> +
> +- compatible : should be "ingenic,jz4740-intc" or "ingenic,jz4780-intc"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +- interrupts - Specifies the CPU interrupt the controller is connected to.
> +
> +Optional properties:
> +- interrupt-parent: phandle of the CPU interrupt controller.
> +
> +Example:
> +
> +intc: intc@10001000 {

    Name it "interrupt-controller@10001000", please.

> +	compatible = "ingenic,jz4740-intc";
> +	reg = <0x10001000 0x14>;
> +
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	interrupt-parent = <&cpuintc>;
> +	interrupts = <2>;
> +};

WBR, Sergei
