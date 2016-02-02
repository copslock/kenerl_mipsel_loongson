Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 12:14:51 +0100 (CET)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35841 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009961AbcBBLOrzR0Me (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2016 12:14:47 +0100
Received: by mail-lf0-f49.google.com with SMTP id 78so67330134lfy.3
        for <linux-mips@linux-mips.org>; Tue, 02 Feb 2016 03:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=K01IHjGvp5X+XVUXQMqgVC/i0H4EF/cytPuLyIutB2E=;
        b=N38/LuYzshBdn2tpCvtdD+VbvofEXAowb0cReyQ4phcoNRVBFgqHEYY0hrJZ+0jR9S
         JcxdXVvSZro5zQ8f17iVHWadrmi6Rsw86VL9zHpSQV5SfqfyZz8NZNCQzws1U9CGC+fZ
         h/L3BtL/1T8E8BpOzlYSuIe1RaIjFkvAIMK5VGULiRsbiGhnuny2rGHVa9bwiaf9I55f
         YMBIx/+xkCozF6lgV0XeCt3G8TlO+VGDiS13YtVYCbhmTEcsxhCQckjrFPoJDsXTSJ08
         PO1FqWDjWW1/5MwXrNiIIgKRFe2nnOnlSmbR/zhO9dQtuiBw+HOETel/P0QW50rP1o03
         4TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=K01IHjGvp5X+XVUXQMqgVC/i0H4EF/cytPuLyIutB2E=;
        b=dcCSHzqRE9UPmOWav/J1urut7o7f4TXHdYexPWyeAllJ8YWQy7tVGy9YvXmaoLlrFO
         S3vaEMD5GL2v2NOvi5NWdhj/88FS5byM21upcx/zLwydhtAra2GWp83+LPMlcPqOsSgn
         sLdRHHPR0YvJzkVssRplqNC2B49FWGgFnqVDb8AQfvYkdhC/+RBEbnMdCBMiEp0mkIDV
         Y7dHnhS+lIKTH4AKH4Hj2Wuqz1p8zZ00RkbZ9t++fUiHGrMDC7GU8++vBC9iO66pY0Sr
         8ZjtflNf7R4SZbZmKweAqLVV1NQh6qof7Gd2E9xB32qVzHoNvv2CgmlsW17EHNbw8q9c
         vMHg==
X-Gm-Message-State: AG10YORCVJro4yCfOfUSmVL4miP6eWY2Ms6clkoFZNV2Wse0rw1qquCk+qnd7XlfsoN1ew==
X-Received: by 10.25.32.75 with SMTP id g72mr8718484lfg.110.1454411682275;
        Tue, 02 Feb 2016 03:14:42 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.176])
        by smtp.gmail.com with ESMTPSA id b5sm137125lbc.14.2016.02.02.03.14.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Feb 2016 03:14:41 -0800 (PST)
Subject: Re: [PATCH 1/2] dt/bindings: Add bindings for PIC32 deadman timer
 peripheral
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1454371348-25104-1-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56B08FA0.9070008@cogentembedded.com>
Date:   Tue, 2 Feb 2016 14:14:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454371348-25104-1-git-send-email-joshua.henderson@microchip.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51623
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

On 2/2/2016 3:02 AM, Joshua Henderson wrote:

> From: Purna Chandra Mandal <purna.mandal@microchip.com>
>
> Document the devicetree bindings for the deadman timer peripheral found on
> Microchip PIC32 SoC class devices.
>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: <linux-mips@linux-mips.org>
> ---
> Note: Please merge this patch series through the MIPS tree.
> ---
>   .../bindings/watchdog/microchip,pic32-dmt.txt      |   19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt b/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt
> new file mode 100644
> index 0000000..f7374ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/microchip,pic32-dmt.txt
> @@ -0,0 +1,19 @@
> +* Microchip PIC32 Deadman Timer
> +
> +The deadman timer is used to reset the processor in the event of a software
> +malfunction. It is a free-running instruction fetch timer, which is clocked
> +whenever an instruction fetch occurs until a count match occurs.
> +
> +Required properties:
> +- compatible: must be "microchip,pic32mzda-dmt".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- clocks: phandle of parent clock (should be &PBCLK7).
> +
> +Example:
> +
> +	watchdog2: dmt@1f800a00 {

    The node names should be generic, i.e. "watchdog" in this case.

[...]

MBR, Sergei
