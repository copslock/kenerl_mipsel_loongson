Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 12:16:37 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34559 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009961AbcBBLQbpgLRe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2016 12:16:31 +0100
Received: by mail-lb0-f171.google.com with SMTP id e9so4184880lbp.1
        for <linux-mips@linux-mips.org>; Tue, 02 Feb 2016 03:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=OnZG9mZSog/YVB/WjXRjyiJczA4TSHP3vNLE5eu404U=;
        b=u6+j5p6lA8L98VapK/ZuUjuGQi464O8lCf2/Yhr9cLvqvAHYmdARJaQPYkGr1qVorz
         pRJx01HhdjsmGek42eGNQAKnyM5V+dOnsFKvqBLkFo8ZRP580vh1xXaS7+1usG6XwEPL
         f1B5St3kfTyKCCmZydKwhD6Lf7h+dv0JJxu6ZQjDjfz7kmckqmi6fkdQ1vZxamDj1WRB
         Gc+s34sgiBk5E1Xwd5UFp45KdR0Fn3kOzMdC3/HLh49EL29OzA4c+zZsmsFGyl9qugNG
         6IDeSa+DZ2yVTXzj/fLxvBHZuXZRO88EUDGsVQqJvNyluml+HFlnhzcbWeNYlOnjd6Lb
         J/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=OnZG9mZSog/YVB/WjXRjyiJczA4TSHP3vNLE5eu404U=;
        b=dMgqaRaaCKjzoXGUX/f1KOp88nyFW7qpEWenDhHn1HZW6RKzicHsUNQyRS8/xJNh4E
         5Qp7FhDf5LwuIN4nNf+JR8DeEeL+dmLFt914idW7wUxkhy538CR8WKufdbQDV4wSSI6n
         OMmas+btxxuwvWSCW97Ux2SgEoyzgT38QKhBpEZSl9hgI0FIpj9HnAHlHC6+sSUTrO4P
         LB2yuzsxXsY1PAFSiSW1kxzOCQxfdbg83d2SqMmC85pwh1f/suk43Le1m5AMrtzGSF8K
         mGf4WwPSV9zuUn8xGeqTXZG39LFGT2PKvqPt+XCMnM0phjjl1tHBxGV7oYpo/0E1zpTs
         jSBA==
X-Gm-Message-State: AG10YOQyHdUBSFm+iIzv/LtsmxZxI/iJacuhAj68QuuOFo4vjalO36xNx+XiK4/NxIJEWg==
X-Received: by 10.112.134.165 with SMTP id pl5mr11019173lbb.126.1454411785056;
        Tue, 02 Feb 2016 03:16:25 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.176])
        by smtp.gmail.com with ESMTPSA id ot1sm136725lbb.26.2016.02.02.03.16.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Feb 2016 03:16:24 -0800 (PST)
Subject: Re: [PATCH 1/2] dt/bindings: Add bindings for PIC32 watchdog
 peripheral
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1454371381-25160-1-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56B09005.2000006@cogentembedded.com>
Date:   Tue, 2 Feb 2016 14:16:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454371381-25160-1-git-send-email-joshua.henderson@microchip.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51624
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

> Document the devicetree bindings for the watchdog peripheral found on Microchip
> PIC32 SoC class devices.
>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: <linux-mips@linux-mips.org>
> ---
> Note: Please merge this patch series through the MIPS tree.
> ---
>   .../bindings/watchdog/microchip,pic32-wdt.txt      |   18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt b/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
> new file mode 100644
> index 0000000..3ce2839
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/microchip,pic32-wdt.txt
> @@ -0,0 +1,18 @@
> +* Microchip PIC32 Watchdog Timer
> +
> +When enabled, the watchdog peripheral can be used to reset the device if the
> +WDT is not cleared periodically in software.
> +
> +Required properties:
> +- compatible: must be "microchip,pic32mzda-wdt".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- clocks: phandle of source clk. should be <&LPRC> clk.
> +
> +Example:
> +
> +	watchdog0: wdt@1f800800 {

    The ePAPR standard tells to to use "watchdog@1f800800" as the node name.

[...]

MBR, Sergei
