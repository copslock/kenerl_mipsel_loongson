Return-Path: <SRS0=LT8O=XZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A57C32792
	for <linux-mips@archiver.kernel.org>; Mon, 30 Sep 2019 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C966420842
	for <linux-mips@archiver.kernel.org>; Mon, 30 Sep 2019 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569849803;
	bh=K1X/LM2y9yXpMnbgviUmn2rRziUsB+yUUxJQF3csMak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZUrasvUmF4BNIJifWSbhsxDTZYL0wP5qGqc/j1SRgaltUwDyduBXgVZHWdmdKrKpm
	 ipl1kwg6yDDse5eoX2wsYZPUXSDE6bMemobABe3EYtS9zBaSCSAeCslY1iUe252x1K
	 9Uscl1L4+EgKo5DMr9lbVl+YcHDfpVYSLY7BiC9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfI3NXX (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:23:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35849 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfI3NXX (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 30 Sep 2019 09:23:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so8274778oto.3;
        Mon, 30 Sep 2019 06:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlVOGEFQPYDeCnC7zwYGU5iysyB+/XWQh6SCYFQQJ1c=;
        b=NMv3PLO8PecYB9KK/4iWm0o67CDG3R+4bfislK/3zbbfc4smiX0tMdWqLUcw3XomzR
         1IVyvrrJytwUDBvVwSw8YxKWJ7GWO3ejk4ohDw/Mk9IfcC3oIzn4VmDxo4dTDsbwDpQd
         nDnng4K7LtXxuyGTM4on++2YWLoa/o3n81IRXFv4VKPMFKUMTQadE3XnKPCa2GIj7ysd
         PxWzPYbO/vnpvLcyHB0kDWFiiNlD7JqbKgn2ahnYl86gSCFEDvTXYBSO0HF/NtRQpoms
         rCsOixL+EHhYfewgV1T1hfDGxLK3kQXd4HaZrA/ZexAaOwzrk7kNMp45QA4YobjDOqOv
         LgDA==
X-Gm-Message-State: APjAAAVwzyYThSWo6KY4M+ghUPwtQEx6sGO0pfmDGgi6laIiueAuY0xS
        KpjoLFLdawehQhI51GkoXA==
X-Google-Smtp-Source: APXvYqxhcn+ULmdDut2zMGEI0lHJ+Aj9hd73OKBqxsI5/hUT3TRBr4WwV85TaUSHgFLu9pXXzWdhUw==
X-Received: by 2002:a05:6830:1403:: with SMTP id v3mr13168367otp.348.1569849801438;
        Mon, 30 Sep 2019 06:23:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d194sm4376960oib.47.2019.09.30.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:23:20 -0700 (PDT)
Date:   Mon, 30 Sep 2019 08:23:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, chenhc@lemote.com,
        paul.burton@mips.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 12/19] dt-bindings: mips: Add loongson boards
Message-ID: <20190930132320.GB3354@bogus>
References: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
 <20190905144316.12527-13-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905144316.12527-13-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Sep 05, 2019 at 10:43:09PM +0800, Jiaxun Yang wrote:
> Prepare for later dts.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../bindings/mips/loongson/devices.yaml       | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/loongson/devices.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mips/loongson/devices.yaml b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
> new file mode 100644
> index 000000000000..0665f0f7ec45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mips/loongson/devices.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson based Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Jiaxun Yang <jiaxun.yang@flygoat.com>
> +description: |
> +  Devices with a Loongson CPU shall have the following properties.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +
> +      - description: Loongson 3A1000 + RS780E
> +        items:
> +          - const: loongson,ls3a1000-780e

These should reflect the specific maker and model of board, not just 
what's the cpu and south bridge.

> +
> +      - description: Loongson 3A2000 + RS780E
> +        items:
> +          - const: loongson,ls3a2000-780e
> +
> +      - description: Loongson 3A3000 + RS780E
> +        items:
> +          - const: loongson,ls3a3000-780e
> +
> +      - description: Loongson 3A3000 + 7A
> +        items:
> +          - const: loongson,ls3a3000-7a
> +
> +      - description: Loongson 3B1000/1500 + RS780E 2Way
> +        items:
> +          - const: loongson,ls3b1x00-780e
> +...
> -- 
> 2.22.0
> 
