Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 17:51:51 +0200 (CEST)
Received: from mail-lf1-x144.google.com ([IPv6:2a00:1450:4864:20::144]:43950
        "EHLO mail-lf1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993316AbeGTPvrxNXZ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 17:51:47 +0200
Received: by mail-lf1-x144.google.com with SMTP id m12-v6so2129618lfc.10
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2018 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s77QPZMTYaHHlVZmv/KHF2k3xtrejKbSBRTrGNfndjQ=;
        b=a7SdzSy7xawvI498HgcYcDiI3FxLM0XxbsHwqfLBd4t2mfR2y6tUMYRKwSqAnoMKJC
         lClymBchUn3A39GOpKfwmi4lQ5YtxakKLtU152n3/3tt5w3vPlVH8PI3FFCKMRlOfHdN
         ANmCFZtP/97pxcnot8BZ9CFBo+dT3T3GrJ/VChwsylf1OO+2WCwsRpS1iPPZOfIBX06G
         dRkUwic0R4pEbdCuolayUdEalg6TUGEL+9ZINiz0HIEbM4wGMwqDBJsL2hpuvUUqwTRt
         gncvedCpv+oNN2dv/9sUH8QfJ4n9irts7qBL5dnqd4ArJ01T6JwMQSn202Cf0f2FBBdT
         FfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s77QPZMTYaHHlVZmv/KHF2k3xtrejKbSBRTrGNfndjQ=;
        b=elaxpWqEObf8y1RNm1FfJWfS7CYNSxYGg2y08CD3mipnp3lY8zinRuOsIDeoDzt2mN
         ptDIHbp+VDTEuVQsI9pFZErq7dLTr0tZr8XAzH1PqtOEmY0GPo7aLWBTSrlD2ylXhMOp
         nx3PMm1ul7axyAhLsOYLLSNSX9YhOv6n6jfzZffz541aXRfBN5qsZ9XmcNV1cXHy6Wk6
         c3WXVon3SuA0xxPjSK2jjMSw4GPfp/yXvoXH7T5xXsEfpvnq+L+p81BoTuuVRzjmaiIQ
         RqeA8LAbjWHN483U0z1KNm+0Wmo1zLGwzwVTE/hGBif++1ELl42yRRqBdiTjxxKXv/V2
         TDVQ==
X-Gm-Message-State: AOUpUlHjwn7zwtwNOTMlgYGwgsBCpUiJVNUp+qhYR6yDqYyV9krd2qiP
        nuT4sF2w7lPeZgBqPaF4rpJ7DQ==
X-Google-Smtp-Source: AAOMgpcTmvd6/3uAXKrliyXyaHao4mNoq0Ni95JLBHpL1tOFgZIbRH9EUvfVo250dKuhy1JH29i2Ww==
X-Received: by 2002:a19:dd5c:: with SMTP id u89-v6mr1717873lfg.83.1532101902514;
        Fri, 20 Jul 2018 08:51:42 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.110])
        by smtp.gmail.com with ESMTPSA id m29-v6sm340243lfj.45.2018.07.20.08.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 08:51:41 -0700 (PDT)
Subject: Re: [PATCH V2 09/25] dt-bindings: PCI: qcom,ar7100: adds binding doc
To:     John Crispin <john@phrozen.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20180720115842.8406-1-john@phrozen.org>
 <20180720115842.8406-10-john@phrozen.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <f09ceb04-be84-a9ee-b383-d4314e4662d5@cogentembedded.com>
Date:   Fri, 20 Jul 2018 18:51:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180720115842.8406-10-john@phrozen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64990
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

On 07/20/2018 02:58 PM, John Crispin wrote:

> With the driver being converted from platform_data to pure OF, we need to
> also add some docs.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/pci/qcom,ar7100-pci.txt    | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt b/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> new file mode 100644
> index 000000000000..10085dd1cd11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> @@ -0,0 +1,38 @@
> +* Qualcomm Atheros AR7100 PCI express root complex
> +
> +Required properties:
> +- compatible: should contain "qcom,ar7100-pci" to identify the core.
> +- reg: Should contain the register ranges as listed in the reg-names property.
> +- reg-names: Definition: Must include the following entries
> +	- "cfg_base"	IO Memory
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- ranges: ranges for the PCI memory and I/O regions
> +- interrupt-map-mask and interrupt-map: standard PCI
> +	properties to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- #interrupt-cells: set to <1>
> +- interrupt-controller: define to enable the builtin IRQ cascade.
> +
> +Optional properties:
> +- interrupt-parent: phandle to the MIPS IRQ controller
> +
> +* Example for ar7100
> +	pcie-controller@180c0000 {
> +		compatible = "qca,ar7100-pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0x0>;

   Not documented above.

> +		reg = <0x17010000 0x100>;
> +		reg-names = "cfg_base";
> +		ranges = <0x2000000 0 0x10000000 0x10000000 0 0x07000000
> +			  0x1000000 0 0x00000000 0x00000000 0 0x00000001>;
> +		interrupt-parent = <&cpuintc>;
> +		interrupts = <2>;

   Not documented above.

[...]

MBR, Sergei
