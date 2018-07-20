Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 18:11:17 +0200 (CEST)
Received: from mail-lj1-x241.google.com ([IPv6:2a00:1450:4864:20::241]:34211
        "EHLO mail-lj1-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993422AbeGTQLNN7aq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 18:11:13 +0200
Received: by mail-lj1-x241.google.com with SMTP id f8-v6so11586633ljk.1
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2018 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tsDjWZ5v49WNG5rrSxjCY9uUTA08y8QJ5+EADTiAnlw=;
        b=qLvgLA+L2BHa/oCn7CMiE8hskNxa10eO49AvoKQnu2Q6csLFGFt7CdUWgKPP42WaVX
         P4LjedM8yxGF1+iGuVmYHGs2Qcu0bgdBbtMFfOzgzAhwX5iIVjAHyNa84W7frkLdsdcc
         kPPwmwcJrWxjO2sqhPh78fWwaLD2Qigvg9WvDlym36w97AKa9R8VDR9Txl4nSXyFqbdk
         RfgFSKGV6dDaZYIkQft/hPU3p7rSgk+PC/0EprMqKkMTBspIYfQbpsuwLNHih+VECUYi
         4+QJwMRuw8EOjnodKgt8R2CAAP+BcI+vCpXhA13+mZVYss1APXsGrN3Nkf9LPI3QED87
         07Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tsDjWZ5v49WNG5rrSxjCY9uUTA08y8QJ5+EADTiAnlw=;
        b=F20jv/UA5aNklKQ4h2RyUowZ9MVaMu5sb692UR4W0gptTlw7Wi7NCWwZGpX8UVF/RN
         cj4K4TGmPdb+5A6uQRbZWfIeWbz8Pu25yXVsODeKuk4T+ydrmuVIQBPEsCC8a9aZHut8
         hPpDJQEUDeydLPJ5AwNPceV22jYZyIyB8eCqxsYUMwsSPpl98VYuLruE2s6S5ac013Dp
         ErbqF3mgq9gSnGMPOPBT8dG5OxAtzKzcycV4IECheOKDgYui77I5Ik4vONgaJsxJLbzA
         v3kgB/Hm3ZLc1dk65lDYDtq5wk/Dy3TdTr0btnVOPb+pBbKClNIZ/JBvUecCLohcIXy3
         Txkg==
X-Gm-Message-State: AOUpUlGUliE+j9w+scrlbEYByNAsnzsZrQroqsZ9KaEAk3F0tz6kCF0x
        KFIPPgQfHSo2HsmM5c3DZY6r+A==
X-Google-Smtp-Source: AAOMgpf7GaLDodWwud/gyIEK/Ly0+4nU7d25HvVWE+jeDCc6Eobke2jv2hfclonrfN8cooGXauj/9Q==
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr2064766ljj.139.1532103067725;
        Fri, 20 Jul 2018 09:11:07 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.110])
        by smtp.gmail.com with ESMTPSA id x23-v6sm427682ljj.86.2018.07.20.09.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:11:06 -0700 (PDT)
Subject: Re: [PATCH V2 11/25] dt-bindings: PCI: qcom,ar7240: adds binding doc
To:     John Crispin <john@phrozen.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20180720115842.8406-1-john@phrozen.org>
 <20180720115842.8406-12-john@phrozen.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <dddf28c5-f70f-871f-0072-ea9e09f3a410@cogentembedded.com>
Date:   Fri, 20 Jul 2018 19:11:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180720115842.8406-12-john@phrozen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64992
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
>  .../devicetree/bindings/pci/qcom,ar7240-pci.txt    | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt b/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> new file mode 100644
> index 000000000000..5379affd4615
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> @@ -0,0 +1,42 @@
> +* Qualcomm Atheros AR724X PCI express root complex
> +
> +Required properties:
> +- compatible: should contain "qcom,ar7240-pci" to identify the core.
> +- reg: Should contain the register ranges as listed in the reg-names property.
> +- reg-names: Definition: Must include the following entries
> +	- "crp_base"	Configuration registers
> +	- "ctrl_base"	Control registers
> +	- "cfg_base"	IO Memory
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- ranges: ranges for the PCI memory and I/O regions
> +- interrupt-map-mask and interrupt-map: standard PCI
> +	properties to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- #interrupt-cells: set to <1>
> +- interrupt-parent: phandle to the MIPS IRQ controller
> +
> +Optional properties:
> +- interrupt-controller: define to enable the builtin IRQ cascade.
> +
> +* Example for qca9557
> +	pcie-controller@180c0000 {

   Just "pcie@180c0000".

> +		compatible = "qcom,ar7240-pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0x0>;

   Not described above.

> +		reg = <0x180c0000 0x1000>,
> +		      <0x180f0000 0x100>,
> +		      <0x14000000 0x1000>;
> +		reg-names = "crp_base", "ctrl_base", "cfg_base";
> +		ranges = <0x2000000 0 0x10000000 0x10000000 0 0x04000000
> +			  0x1000000 0 0x00000000 0x00000000 0 0x00000001>;
> +		interrupt-parent = <&intc2>;
> +		interrupts = <1>;

   Not described also.

[...]

MBR, Sergei
