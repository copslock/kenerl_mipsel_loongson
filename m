Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 19:37:46 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:33720 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011844AbbDXRhopKNHS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 19:37:44 +0200
Received: by layy10 with SMTP id y10so40488354lay.0
        for <linux-mips@linux-mips.org>; Fri, 24 Apr 2015 10:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Or5hF6usy3ujicacCaDfqH58u1KmvOikXDF6XSktvEE=;
        b=SM7ukN1xSyQEK7oFi6qBJV55NoAoVGmhrtuosy1+hxtAAwfR7MjQSZT26tDyyoVuQA
         DOYqa4f16EcXPqfNvuX2rpl8mXXZq14eVxVdZvlqNwPJ+CqlJ+RFfhh/ukDi2dm4OCnw
         glJjwlMGgJx/V6KYi6tSBRoYl/+RWLH2b5efAJpHCSkTx/nlzL4DAmI9HYqe2DjezLcO
         OhKU+CsZKhMAMkj9tssemlFit9F6Vc57kC40XyrPTeHOOFcX5JuL973LD9TU9IgqmHk9
         VqyvBvH1Q2sq6fBSdDYYsHyKiajWBW3vc+JC4c6KtTsI/tjeRQdf4YdYn/AoQ82z8oPD
         bqYw==
X-Gm-Message-State: ALoCoQmD8qXKrz+fTfl31YkVvnvIzfORL8yk3tlCCJLSj7+VHRSAxbTyaTfSheOvQAhSte3DVCDw
X-Received: by 10.112.168.165 with SMTP id zx5mr7710721lbb.111.1429897061054;
        Fri, 24 Apr 2015 10:37:41 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp85-141-192-99.pppoe.mtu-net.ru. [85.141.192.99])
        by mx.google.com with ESMTPSA id ml10sm2778809lbc.29.2015.04.24.10.37.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 10:37:40 -0700 (PDT)
Message-ID: <553A7F62.80108@cogentembedded.com>
Date:   Fri, 24 Apr 2015 20:37:38 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Alban Bedel <albeu@free.fr>, linux-spi@vger.kernel.org
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] devicetree: add binding documentation for the AR7100
 SPI controller
References: <1429885164-28501-1-git-send-email-albeu@free.fr> <1429885164-28501-2-git-send-email-albeu@free.fr>
In-Reply-To: <1429885164-28501-2-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47079
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

On 04/24/2015 05:19 PM, Alban Bedel wrote:

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>   .../devicetree/bindings/spi/spi-ath79.txt          | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-ath79.txt

> diff --git a/Documentation/devicetree/bindings/spi/spi-ath79.txt b/Documentation/devicetree/bindings/spi/spi-ath79.txt
> new file mode 100644
> index 0000000..f1ad9c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-ath79.txt
> @@ -0,0 +1,24 @@
> +Binding for Qualcomm Atheros AR7xxx/AR9xxx SPI controller
> +
> +Required properties:
> +- compatible: has to be "qca,<soc-type>-spi", "qca,ar7100-spi" as fallback.
> +- reg: Base address and size of the controllers memory area
> +- clocks: phandle to the AHB clock.

    s/to/of/?

> +- clock-names: has to be "ahb".
> +- #address-cells: <1>, as required by generic SPI binding.
> +- #size-cells: <0>, also as required by generic SPI binding.
> +
> +Child nodes as per the generic SPI binding.
> +
> +Example:
> +
> +	spi@1F000000 {

    All lowercase, please.

> +		compatible = "qca,ar9132-spi", "qca,ar7100-spi";
> +		reg = <0x1F000000 0x10>;

    Likewise.

[...]

WBR, Sergei
