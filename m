Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 18:17:20 +0200 (CEST)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35656 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006593AbbEXQRPpGarp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 18:17:15 +0200
Received: by wgfl8 with SMTP id l8so55558624wgf.2
        for <linux-mips@linux-mips.org>; Sun, 24 May 2015 09:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=WrIJppAprqdmsJ/xjGwPeSOtEOTCL1B0lfC+vCYHIw0=;
        b=TktU5PP3D+EXx9+x9eqesOxZuBfEtjpKugYDiC5H+Y4XIGtHEuMK/mzVE+QiYfVrvC
         7zVqFiMBM9PwtEjkA3m8YKgZ2DyQqdY93yI9a1waykqVyBrzEsg3utiokglSkmjChL7x
         bUSQySR0KImaw5aYON0lGblkW2nnCngU4jMv9RPwcbFuC++OCWTgzOXY4D8cA240DrC4
         NtkqJtIE62Gmdyhd+I6lTjDg64lyHtvps4JvAEYbzgSOgw3NeKlCiSrWjnlGbNAz3Obx
         GMQaNncwZ2yw+n0B3qx1bZhgbhPBebX28FXCFqP/GzKYs9EA85FAq+Hgx8OIFR+6F7rN
         lsBQ==
X-Gm-Message-State: ALoCoQkhrXbQyY0sDwcdp6ouiIN2B+awxEDd2N6LUFCWfb2k6emCZ+chpukqfSMNVH8EffQPKZ4u
X-Received: by 10.180.94.106 with SMTP id db10mr23924021wib.1.1432484233121;
        Sun, 24 May 2015 09:17:13 -0700 (PDT)
Received: from wasted.cogentembedded.com ([193.86.243.7])
        by mx.google.com with ESMTPSA id a18sm12615650wja.46.2015.05.24.09.17.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2015 09:17:12 -0700 (PDT)
Message-ID: <5561EB79.30209@cogentembedded.com>
Date:   Sun, 24 May 2015 18:17:13 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC:     Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v5 07/37] MIPS: JZ4740: probe CPU interrupt controller
 via DT
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com> <1432480307-23789-8-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1432480307-23789-8-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47639
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

On 05/24/2015 06:11 PM, Paul Burton wrote:

> Use the generic irqchip_init function to probe irqchip drivers using DT,
> and add the appropriate node to the JZ4740 devicetree in place of the
> call to mips_cpu_irq_init.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---

> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Rebase.

> Changes in v2: None

>   arch/mips/boot/dts/ingenic/jz4740.dtsi | 7 +++++++
>   arch/mips/jz4740/irq.c                 | 4 ++--
>   2 files changed, 9 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> index c538691f..2d64765c 100644
> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> @@ -2,4 +2,11 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   	compatible = "ingenic,jz4740";
> +
> +	cpuintc: cpuintc@0 {

    The node shoiuld be called "inbterrupt-controller@0".

WBR, Sergei
