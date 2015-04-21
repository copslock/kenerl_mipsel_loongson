Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 18:56:12 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33019 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012063AbbDUQ4LF3nHG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 18:56:11 +0200
Received: by lbbzk7 with SMTP id zk7so160619013lbb.0
        for <linux-mips@linux-mips.org>; Tue, 21 Apr 2015 09:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MrNHOfA0l9JgQzTRJXEius2/hnY+jgkLcWMq9h/MfmI=;
        b=DwL5n3wFxXGedDSZ9vsk3FQhcYzcBgX1wXBAeSOjRYqsy20YOr4Hp4vMnX8g67HkmS
         UFx+Xfelx8qrnO05utG9SWrYRC6wmJqtiuohWKCqpoqI4kUMOxcb7fdcSITOGbBGOrfo
         aaXUNEHZrbg4UVyBPyTpnsMzJ/EcrXa/HqqaeYtWmtJdfAFQFNCionscfItqZpngrMWl
         MImBqiWv4ArbZ1CaVbWiUnJZBZay5ZZ7Wb9g4IOm2jDdRfU1tdowhTQibQzbw8nbn3X9
         qyjp2ILNSkfJFEpaRSyykRy/MSg4xJ7ElFL/ULr9kLCFACr2dChHOtteE/pTOgW5OLxA
         pN0Q==
X-Gm-Message-State: ALoCoQnKud3Sj/4dR9XCaWWpp4PR0CQbJTZHwQdrGh1qK9HoiBs6+5Ip+L67Mxv1f8m44ewgEQuO
X-Received: by 10.152.239.135 with SMTP id vs7mr21007871lac.104.1429635366910;
        Tue, 21 Apr 2015 09:56:06 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-254-74.pppoe.mtu-net.ru. [83.237.254.74])
        by mx.google.com with ESMTPSA id aj4sm533922lbd.5.2015.04.21.09.56.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 09:56:05 -0700 (PDT)
Message-ID: <55368124.8020706@cogentembedded.com>
Date:   Tue, 21 Apr 2015 19:56:04 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 10/37] devicetree: document Ingenic SoC interrupt controller
 binding
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com> <1429627624-30525-11-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1429627624-30525-11-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46997
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

On 04/21/2015 05:46 PM, Paul Burton wrote:

> Add binding documentation for Ingenic SoC interrupt controllers.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: devicetree@vger.kernel.org
> ---
> Changes in v3:
>    - Merge documentation for various Ingenic SoCs, which only differ by
>      their compatible strings.

> Changes in v2:
>    - None.
> ---
>   .../bindings/interrupt-controller/ingenic,intc.txt | 25 ++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
> new file mode 100644
> index 0000000..5d652e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
> @@ -0,0 +1,25 @@
> +Ingenic SoC Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : should be "ingenic,<socname>-intc". For example
> +  "ingenic,jz4740-intc" or "ingenic,jz4780-intc".
> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +- interrupt-parent : phandle of the CPU interrupt controller.
> +- interrupts : Specifies the CPU interrupt the controller is connected to.
> +
> +Example:
> +
> +intc: intc@10001000 {

    The node should be named "interrupt-controller@10001000", according to the 
epAPR standard.

WBR, Sergei
