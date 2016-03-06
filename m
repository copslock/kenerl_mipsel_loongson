Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2016 13:14:06 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33735 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008306AbcCFMOEDXM6A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Mar 2016 13:14:04 +0100
Received: by mail-lb0-f182.google.com with SMTP id k15so103961200lbg.0
        for <linux-mips@linux-mips.org>; Sun, 06 Mar 2016 04:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=9wHTAqghftLlZf3yI0up9Gi6Gr5NnzxrO65hxfM54ho=;
        b=EzekSCamioeRp3XfJdCm6QCLn6Oee9xaaiSJo6m3TVRiPGTgKw33+ebEHepjYsXM5L
         r1IdiED6gV+603gn2LzVO3+Xz4/5Rdz/vH6JHUBy56JRWWyHJTo0oTXRewj9nsjeuHRk
         XeZZPVHumnUj+WbHOf2gGlWPDC8+q833Y/EaXgxABy5jMYLzTXOt+ixHQMFWXjxAdfv8
         CrBlqe9TCL+5XlJlBO1GPW9QdDjEVpNDc90pQaBoIA15IpMcwaPTawRLU5tlp8kvoxZ4
         9NBGaIYl7S4JM0lvAvwiS632Lue8cQStN5Q0NCglkHQSnQzB83xFzt4s20l93GgbIhxO
         fw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9wHTAqghftLlZf3yI0up9Gi6Gr5NnzxrO65hxfM54ho=;
        b=N0LdbRugOD4GsG688NIJOZcMy6VWy0HNrCKFM3CW/bFnYBeLQ26BBtdFscr2qQpnew
         nEAO5U15cy3JAQ5j0aq9t9R0e1IptUo0I0EhoaArdKPRt9G7xs8MlcRdlD48ErcwlRLK
         M1/0ov+B1X4XKoPBxBqScZU2g9SN/AbhGu95Sy6wk+kxAX+E56aJjZObfcvi5I8aY2DA
         ciH3XC1l8itmiQzoKG0MyLZ7zMYaj3whAdneU6wTFzxn891Dvgg39NVvh0U+EOtqPRR2
         pTBOl0u/kDIFizzhdnqGLKiZJYTppc6QtxmB2LK5pbPL4aRt9dkX82nGAejQQ0/CkLlm
         qglg==
X-Gm-Message-State: AD7BkJJi3oOWLdXbo4sv7E/2znocInKvaSWZ+8cknbhaUOKwVF9muZKOeYNc1xoA037cBw==
X-Received: by 10.112.146.35 with SMTP id sz3mr6073558lbb.10.1457266438418;
        Sun, 06 Mar 2016 04:13:58 -0800 (PST)
Received: from [192.168.4.126] ([195.16.110.49])
        by smtp.gmail.com with ESMTPSA id f184sm2054217lfe.6.2016.03.06.04.13.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2016 04:13:57 -0800 (PST)
Subject: Re: [PATCH 2/5] Documentation: dt: Add binding info for jz4740-rtc
 driver
To:     Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-2-git-send-email-paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56DC1F04.7050907@cogentembedded.com>
Date:   Sun, 6 Mar 2016 15:13:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1457217531-26064-2-git-send-email-paul@crapouillou.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52476
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

On 3/6/2016 1:38 AM, Paul Cercueil wrote:

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 38 ++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>
> diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> new file mode 100644
> index 0000000..71e4ad0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> @@ -0,0 +1,38 @@
> +JZ4740 and similar SoCs real-time clock driver
> +
> +Required properties:
> +
> +- compatible: One of:
> +  - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
> +  - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
> +- reg: Address range of rtc register set
> +- interrupts: IRQ number for the alarm interrupt
> +- interrupt-parent: phandle of the interrupt controller

    This is never a required property, it can be inherited from the parent node.

[...]

MBR, Sergei
