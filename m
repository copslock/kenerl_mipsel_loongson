Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 12:11:47 +0100 (CET)
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34572 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009961AbcBBLLp6JE8e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2016 12:11:45 +0100
Received: by mail-lf0-f50.google.com with SMTP id j78so46066847lfb.1
        for <linux-mips@linux-mips.org>; Tue, 02 Feb 2016 03:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=DVRQAyhnS+RGhqqYrjzEKNcm1IARDaeS0zw1njy3REY=;
        b=qolsXl8dqHTwCuxJGwc+bEkW3IcFA8NuRR2Txwyk4XQv4z9xwNKKzdwRkpy/p4azj9
         8HghfGVQdR7tGAOsnkwBMBs0WkcOXRH+HvLECK7qy81IZiPZYrLn6OXUNXUUIqbdwY+A
         jop+ihHSgYVwwOcZo7jMm85PZVv/tqOlUgvdqiIrTR1yAnttAg5WNUxSbydpUA+NvW4H
         rfzigwGLe8kJ99hS4Hw5xLs4HdUDCDhZVi6mD7j1kt6oKvzvp1/U1RectHozr8JtbluA
         OWVC+U+NGeujbN7y3hPEF1drUr0PRjiwX1I3/WpLacbw2dgybj3xMUymxYO8iJyOb2l6
         6IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=DVRQAyhnS+RGhqqYrjzEKNcm1IARDaeS0zw1njy3REY=;
        b=Dw5tKMyLoU0Dr2kdUayoWxFLz+aK2PrcP/Vh0WGT0GELSC0GCX+4HKmPtejLL1xZV5
         GVSG0f/eSjYIxEx1YK4jXeXOnY/8RjafQcUy9Mr1TxwLKGGt5hlX5avj/IP6bS90qYcM
         h/5L3f0t0WE3DZgxFe3F5vLU2ldUSZYE5Lsf/ohkcX3g3R31CosbbWZrmCXV436DR5Nl
         YU1loewQ1kHTJSfZCdHHXWqXGt6ZH4n3ICj5y8n/8H9FEgpQjQ/ILQDQQEcB0TSjkkBA
         SJWTcpjgm7/d0uyPwUIx/LyImLVubDgFDz/vk2/oIk05LRmru3wnm3bd9I/q5jTtMw43
         WBGA==
X-Gm-Message-State: AG10YOQG3BMQqSTFZbgCaiJpT0iUkreNeolffEXuG/ddxM1/i8VgHF6Ipb8Zf3LcpPlx9g==
X-Received: by 10.25.21.29 with SMTP id l29mr7158962lfi.123.1454411500405;
        Tue, 02 Feb 2016 03:11:40 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.176])
        by smtp.gmail.com with ESMTPSA id p138sm138490lfb.22.2016.02.02.03.11.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Feb 2016 03:11:39 -0800 (PST)
Subject: Re: [PATCH 1/2] dt/bindings: Add bindings for the PIC32 SPI
 peripheral
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1454366701-10847-1-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56B08EEB.3050808@cogentembedded.com>
Date:   Tue, 2 Feb 2016 14:11:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454366701-10847-1-git-send-email-joshua.henderson@microchip.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51622
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

On 2/2/2016 1:44 AM, Joshua Henderson wrote:

> From: Purna Chandra Mandal <purna.mandal@microchip.com>
>
> Document the devicetree bindings for the SPI peripheral found
> on Microchip PIC32 class devices.
>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>   .../bindings/spi/microchip,spi-pic32.txt           |   44 ++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
> new file mode 100644
> index 0000000..a555618
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
> @@ -0,0 +1,44 @@
> +* Microchip PIC32 SPI device
> +
> +Required properties:
> +- compatible: Should be "microchip,pic32mzda-spi".
> +- reg: Address and length of the register set for the device
> +- interrupts: Should contain all three spi interrupts in sequence
> +              of <fault-irq>, <receive-irq>, <transmit-irq>.
> +- interrupt-names: Should be "fault","rx","tx" in order.

    Please insert spaces after commas.

> +- clocks: phandles of baud generation clocks. Maximum two possible clocks

    Baud in the SPI context?

> +	  can be provided (&PBCLK2, &REFCLKO1).

    Please align.

> +          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
> +- clock-names: Should be "mck0","mck1".

    Please insert space after comma.

[...]
> +Example:
> +
> +	spi1:spi@0x1f821000 {

     Please insert spaces after colon.

[...]

MBR, Sergei
