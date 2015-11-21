Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 16:21:02 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35906 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007075AbbKUPVALQ7E9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 16:21:00 +0100
Received: by lbblt2 with SMTP id lt2so76600488lbb.3
        for <linux-mips@linux-mips.org>; Sat, 21 Nov 2015 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=rfm/8dwkcvhkmMOFf6fshhm1NELY8/4uruvAi2xgnkw=;
        b=ahQoL63Om0fw+2XAqSUHB4eJIPc3XO0LDxNEvpcAvXxxG1iAR8DqHAUG9a7xbyrrdL
         H8IMR8mv5whJn7ZfyUk2bD1lkXX/OJsBu/CwT+Vw4QCJapXM3+dsMxvkgG24O4758Aed
         wATm+n5G1TGlY83AhGR0+KWmjBXx1tQfdPcBwIyXw6boKg54OMmX36IEzn3c9yQP0qhX
         75HPk7bjpoiBCL60ax0dJlJFW3ZOHu1gCUseXQmyruVyWCQL8RkBrVA+5TvZFq+BryGm
         lS8tiBfmvUx9xicWHSHlK0jdSOCWimm7rQ3F/VoahIvCd2AdQeSriOaBhUumuPadl7U/
         oUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=rfm/8dwkcvhkmMOFf6fshhm1NELY8/4uruvAi2xgnkw=;
        b=gcV/9MJ/S0Gx43+qTfzdNBiZmkxtWq3Yxgs6xxQXntqDYqqq5fYkpzAo+rbHIIKfr4
         NFKNIJ7JjDkC5b2yScb1bIcyJIyU2jbU28nwgYlgYJ7kAZKiPVjqlw0272P+BFqEkYkA
         BUv4LXYMkDCOvQ2mNGlYA3Q9eDinrN/t//kRl7K2l0T//GwHGapf8baG46DFJcbMIW/H
         KNTYkxmEH2L8y42hiSNFkiK2GEBozTYu3mJGpk55iWamwsBD3Pb73dZDaoFevgHb5cgM
         gLgYuzjtvD7mH9UhG8Pm4w7UxNP9MIcNeGaHjs/L+xiz3i1UH1cLp8koM2UTtDKPgoi8
         l0AA==
X-Gm-Message-State: ALoCoQk9mijZdsaj+v+DDCwD9Kj5VJfVScMfdhdZuaZZlVvcRnuXEllmgE4B5hmFLkNkTkerIt/U
X-Received: by 10.112.30.145 with SMTP id s17mr7798164lbh.75.1448119254713;
        Sat, 21 Nov 2015 07:20:54 -0800 (PST)
Received: from [192.168.4.126] ([83.149.8.200])
        by smtp.gmail.com with ESMTPSA id t82sm616347lfe.14.2015.11.21.07.20.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Nov 2015 07:20:54 -0800 (PST)
Subject: Re: [PATCH 09/14] DEVICETREE: Add bindings for PIC32 usart driver
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-10-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56508BD5.5050003@cogentembedded.com>
Date:   Sat, 21 Nov 2015 18:20:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1448065205-15762-10-git-send-email-joshua.henderson@microchip.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50026
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
> Document the devicetree bindings for the USART peripheral found on
> Microchip PIC32 class devices.
>
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>   .../bindings/serial/microchip,pic32-usart.txt      |   29 ++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt b/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt
> new file mode 100644
> index 0000000..c87321c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt
> @@ -0,0 +1,29 @@
> +* Microchip Universal Synchronous Asynchronous Receiver/Transmitter (USART)
> +
> +Required properties:
> +- compatible: Should be "microchip,pic32-usart"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +- pinctrl: Should contain pinctrl for TX/RX/RTS/CTS

    No such prop in the example.

> +
> +Optional properties:
> +- microchip,uart-has-rtscts : Indicate the uart has hardware flow control
> +- rts-gpios: RTS pin for USP-based UART if microchip,uart-has-rtscts
> +- cts-gpios: CTS pin for USP-based UART if microchip,uart-has-rtscts
> +
> +Example:
> +	usart0: serial@1f822000 {
> +		compatible = "microchip,pic32-usart";
> +		reg = <0x1f822000 0x50>;
> +		interrupts = <UART1_FAULT DEFAULT_INT_PRI IRQ_TYPE_NONE>,
> +			     <UART1_RECEIVE_DONE DEFAULT_INT_PRI IRQ_TYPE_NONE>,
> +			     <UART1_TRANSFER_DONE DEFAULT_INT_PRI IRQ_TYPE_NONE>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <
> +			&pinctrl_uart1
> +			&pinctrl_uart1_cts
> +			&pinctrl_uart1_rts>;

    The above 2 props are undocumented.

[...]

MBR, Sergei
