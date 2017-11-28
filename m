Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 20:14:49 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:45227
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990490AbdK1TOmPvl1i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 20:14:42 +0100
Received: by mail-wr0-x242.google.com with SMTP id h1so1119531wre.12;
        Tue, 28 Nov 2017 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lfc/WlQZ9B37gcnfbM5iAsJiZU/icIxGsgAZu1Jx/gU=;
        b=WqFtpFz1LKCsCwRVyExU6XJVWHGy8mHV/rDUdmjSCCWy68daET/dlOg8buHk1sn/Nc
         N09sI1hm2WG0pr/MdA0eQKPSqdPmyUaRlE15XVqnyKn1jRur+n6QfbHUOY1lA/L1MylD
         yeURQE2x+7ZlW45ijMvauR4KVCBB+evLE85AEUri1MpWOMg4bQAebXQP/fsKujpVZ2St
         DLa7hgyHUxgP2lPFGFmbMUy4LUfOYz8oPX4OZkWfV9+Y1EE77PSyIH0ZMdV6jitOIxPF
         a6/L9SpwmbXUnJlBAdeJ2fiDINwPvTvIZYTemGORPkeQCwhvyMyamUqyLTlq/skNRBz5
         hrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfc/WlQZ9B37gcnfbM5iAsJiZU/icIxGsgAZu1Jx/gU=;
        b=R7uZKrSMUJPZRNuTCS11lRDLnc3I2UTy63N9uKZKy3ZwVTEQMJ4dk5SrsJ25DLrVDU
         3CPDh1jNSTqkwdvXYoYOrlP4899SrqA8DpXsfvSSNExKDkCZVyunEurImwO9DN0J/YiR
         aiG5Ufjxj5wlZ6jPUIsTQ0tERm0s7ObfcotNWac0XNJtFJgKMAepEYocnB6+9bC0P+E8
         YIL2Z81X087HXdvw3OA15JZbrYfdS+2jLkq7XKvSGNAqC1fGAFd4dXu0lg9gmGaKzXWx
         r77lIhQj+axzhyVBnKek1q6ShXCgAYm8EuyLQbuYsgKqZiZTNkjvFQRZFIfc9/33elHQ
         Z8NA==
X-Gm-Message-State: AJaThX6REghduFErJh0Dk61u4AW4S5H1Zn8PWk+zQQrzDvBuz1bceAgk
        mpJmSMPMjakCGcX0pFUQhIo=
X-Google-Smtp-Source: AGs4zMZEe1bFUxzeE0yYSA0pjA8T3Ir3YoIY6XQX467ewDw+K1raYuefVWaNeyTrcLymMFkWWOhxGA==
X-Received: by 10.223.186.67 with SMTP id t3mr177355wrg.276.1511896476689;
        Tue, 28 Nov 2017 11:14:36 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id q140sm236369wmd.35.2017.11.28.11.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 11:14:35 -0800 (PST)
Subject: Re: [PATCH 08/13] dt-bindings: mips: Add bindings for Microsemi SoCs
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-9-alexandre.belloni@free-electrons.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b6e921c4-ad7e-e4a8-9420-60da395ef960@gmail.com>
Date:   Tue, 28 Nov 2017 11:14:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171128152643.20463-9-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 11/28/2017 07:26 AM, Alexandre Belloni wrote:
> Add bindings for Microsemi SoCs. Currently only Ocelot is supported.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> 
>  Documentation/devicetree/bindings/mips/mscc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
> new file mode 100644
> index 000000000000..2c52e76b7142
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/mscc.txt
> @@ -0,0 +1,6 @@
> +* Microsemi MIPS CPUs
> +
> +Required properties:
> +- compatible: "brcm,ocelot"

You probably intended to use mscc,ocelot here, right?
-- 
Florian
