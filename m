Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 16:19:24 +0100 (CET)
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35302 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007113AbbKUPTVz98e9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 16:19:21 +0100
Received: by lfdl133 with SMTP id l133so4234454lfd.2
        for <linux-mips@linux-mips.org>; Sat, 21 Nov 2015 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=0lk3nCT7b020L0/5QJl6K8w2RVhSVzzGNFKCXj+oPeo=;
        b=HJ5NZ3u3l5tI79hRU4R0KT1kZapF0/4YIWWo7OOl1tDK9l7KXLFz4jJR271ewrwb+H
         jGD3AjwrZOegv3v9drOWYB4zf9cDPE++mkk78KCVnZm8emLnIsLs59HaUBI3XIpbGmkL
         0GvbV7Ckk3iWqL+KVpIvyYCwofxZuz20MRH6scNROogvUCeGq9HCMP6yZf704RPEmiPj
         fjqszN6je/5TNyMDWSmdGeUI5YPF5gXT3mMn95zTeXH96KLxUkKgMfbf4uPEPN6jrHLu
         xyKKE4Jks4/OVlIdCvkXv7iyhV/MgDE6NlAdcibAW89oV/3k0kPxL/8HRx1aM1Vso6um
         B2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0lk3nCT7b020L0/5QJl6K8w2RVhSVzzGNFKCXj+oPeo=;
        b=U2yqgWVBIlIyYuh5gs80696R8FvChXzKcW1/1aj2Sc2W4umF9QhLLb5v3dDABXiA8m
         QHWAOw+OAuH5eDNBlHgvNLgEClju/Kv4YKeFH03J5xRpPB+RaD7qejGQpismUEEEczxN
         MffJUGSdu50/5l8782R8ec23KUil964MxUOkA7/qOl566anWvMa0FqBiEeJSW/ApwPaM
         BTbyUC7OKztmNANbstxZSDiSBg2vBu5c6LrBDUTcHDk39s9eWLztAGvfFbbc+Rv8UeJt
         KT4IkZjHZQQEKTaZKwuhD7E2K2jU78hn6L3rHLRZPKum2kn23wwbKszQg2kacICjDhfV
         3apQ==
X-Gm-Message-State: ALoCoQk43Ac14a0BU83EdY2S+MRVrWrzIzLUbmcoBNJDANd7FPCdjgYvy+nLt5QvM4nfJoqcupfV
X-Received: by 10.25.152.70 with SMTP id a67mr8310745lfe.100.1448119156464;
        Sat, 21 Nov 2015 07:19:16 -0800 (PST)
Received: from [192.168.4.126] ([83.149.8.200])
        by smtp.gmail.com with ESMTPSA id j83sm631623lfi.47.2015.11.21.07.19.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Nov 2015 07:19:15 -0800 (PST)
Subject: Re: [PATCH 12/14] DEVICETREE: Add bindings for PIC32 SDHC host
 controller
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-13-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56508B72.8070701@cogentembedded.com>
Date:   Sat, 21 Nov 2015 18:19:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1448065205-15762-13-git-send-email-joshua.henderson@microchip.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50025
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

On 11/21/2015 3:17 AM, Joshua Henderson wrote:

> From: Andrei Pistirica <andrei.pistirica@microchip.com>
>
> Document the devicetree bindings for the SDHC peripheral found on
> Microchip PIC32 class devices.
>
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>   .../devicetree/bindings/mmc/sdhci-pic32.txt        |   24 ++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
> new file mode 100644
> index 0000000..f16388c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
> @@ -0,0 +1,24 @@
> +* Microchip PIC32 SDHCI Controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci-pic32 driver.
> +
> +Required properties:
> +- compatible: Should be "microchip,pic32-sdhci"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +- pinctrl: Should contain pinctrl for data and command lines

    This is a required prop, yet the example doesn't contain it?

> +
> +Optional properties:
> +- no-1-8-v: 1.8V voltage selection not supported
> +- piomode: disable DMA support
> +
> +Example:
> +
> +	sdhci@1f8ec000 {
> +		compatible = "microchip,pic32-sdhci";
> +		reg = <0x1f8ec000 0x100>;
> +		interrupts = <SDHC_EVENT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&REFCLKO4>, <&PBCLK5>;
> +		clock-names = "base_clk", "sys_clk";

    The "clocks" and "clock-names" props are not documented.

[...]

MBR, Sergei
