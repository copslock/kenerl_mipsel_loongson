Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 17:58:44 +0200 (CEST)
Received: from mail-lf1-x142.google.com ([IPv6:2a00:1450:4864:20::142]:40213
        "EHLO mail-lf1-x142.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993394AbeGTP6i50el0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 17:58:38 +0200
Received: by mail-lf1-x142.google.com with SMTP id y200-v6so2135508lfd.7
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2018 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCBRE1RBwaBYP6TEOEG2PtX89AQtE7B84ASQZC1eJbU=;
        b=R1IgeJ59XxMuB1xbxCCLueT8TK41qUviyjadZ84CsW/OQL5WJhgsk1Nlp2w8HeVASD
         jUZquG7326Ob7gjB7Rzt7IwK3zLHaQWT0LU16JU1ksfPHd0hEikHrerf60jeL576HULL
         fOhilPWD9g6Wrw1vwDobuR+daZxZp900AcAWZt0deo1w/Ib0sykMRARx6TJNpvOiNNdd
         K7g5ZSdZxjdodcrtA5XPJ5Yx2gzNLRwdjutkZ2RCZIdXHXksIe7L0k3OE6eIKwjDgbKN
         BUYCgTmaBDqDZwlHfNRdszA/P9aGVDoW706oKCeY/vLMu7I26XUXyTYrDT9DU9HEO/1w
         t9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pCBRE1RBwaBYP6TEOEG2PtX89AQtE7B84ASQZC1eJbU=;
        b=AU1JmnHDAvmhJ7qUZCK5GldzjL89Z4I6wCef7hWVAVw3GhBX1nSkiiq8kmCggWLdGg
         HgXCqNCAHSJYZ+I7Rhsu3g/9GCWTuzgLFX5RDgB9w1v20WJljhjXsUBsCaQ5VjFs/4Bn
         qRwATZGA/lmyfBNhYMWd+LJlLk+ryopPZvHVmveBNkMX0W5+J8SeMC4XHPlrv1o4XOZj
         ohZfZR+eF8vPGDzNC+9bzLeSlLLn+xiDryOCXwqOvQ/Va+XNg483fd9fU/eZJ89Q4oAe
         oe4A3XcOZORaH2norXgq0KdHX4a8Op93Kb0M/SMQ7mYFWfCK7aiN5iFQ2mcG7TjC5bip
         yGfA==
X-Gm-Message-State: AOUpUlFrakVrqByffRbL4/h+BLH1bvKvHNkcfcTTpm3Gpm5ds0g4850n
        VjTnSoYZ57nNp56ZhlrYZkK1irbuTF0=
X-Google-Smtp-Source: AAOMgpc8BqEoDbt40iTn5dJXaGdebZgMK8SLqBAGoFOX0kssoxWA0yRynU7A6e9kn2rwQU32ZnM84w==
X-Received: by 2002:a19:ce51:: with SMTP id e78-v6mr1826670lfg.99.1532102313294;
        Fri, 20 Jul 2018 08:58:33 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.110])
        by smtp.gmail.com with ESMTPSA id k10-v6sm429336ljh.5.2018.07.20.08.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 08:58:32 -0700 (PDT)
Subject: Re: [PATCH V2 09/25] dt-bindings: PCI: qcom,ar7100: adds binding doc
To:     John Crispin <john@phrozen.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20180720115842.8406-1-john@phrozen.org>
 <20180720115842.8406-10-john@phrozen.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <36726687-6e6b-18d7-a930-829910f8eb4f@cogentembedded.com>
Date:   Fri, 20 Jul 2018 18:58:31 +0300
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
X-archive-position: 64991
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

    Overlooked it -- should be just "pcie@180c0000".

> +		compatible = "qca,ar7100-pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0x0>;
> +		reg = <0x17010000 0x100>;

   Doesn't match the <unit-address> part of the node name above.

> +		reg-names = "cfg_base";
> +		ranges = <0x2000000 0 0x10000000 0x10000000 0 0x07000000
> +			  0x1000000 0 0x00000000 0x00000000 0 0x00000001>;

   1 byte?!

[...]

MNR, Sergei
