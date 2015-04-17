Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 18:20:24 +0200 (CEST)
Received: from mail-la0-f53.google.com ([209.85.215.53]:33797 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010571AbbDQQUWSg5-G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 18:20:22 +0200
Received: by laat2 with SMTP id t2so84302141laa.1
        for <linux-mips@linux-mips.org>; Fri, 17 Apr 2015 09:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8u+57XO2kufjYQkju2lYeVyaN6gdsN4W09b1Ng9QGYg=;
        b=ZIrzzZjBD6k5X/1uU3vSdDdtDuLobCvLmE7tElVxz7MV9t5bm5lnPZns4/QjKE40WV
         PSAPk9L1vSIeYkEQNgo6y+myoMadyYIHuREaYs+7VFDYi48Kr9Wcv9c/Mq3xj/7boJnJ
         JPj5mKEZ/c/Wn7npa2ah+ySBie/AcgtSuq3Ef5nlf2VJLvwGR2A7hJ9/QNEFjw3gQ5e6
         Ft50IfxUcPULF4gVn2WAGqXcVzgMCSgDr5cmE/lUUA/1I96XaPkISnMOwywmWCaFT1GX
         Ky4PyA/m14CjedI6yPQe+NToYjtpFutssQTCnw4v59zsbwOdBCoAOIO7kWJC60c0bhw3
         zYsQ==
X-Gm-Message-State: ALoCoQkzsXl73lAYAxDpU17pMdpa/rc+0mOaKJ6bZc/rXvAE3734Op/jRArprybIQg38mCS8mj5p
X-Received: by 10.152.179.39 with SMTP id dd7mr4799346lac.118.1429287618518;
        Fri, 17 Apr 2015 09:20:18 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp85-141-198-209.pppoe.mtu-net.ru. [85.141.198.209])
        by mx.google.com with ESMTPSA id ba4sm2500254lab.31.2015.04.17.09.20.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2015 09:20:17 -0700 (PDT)
Message-ID: <553132BE.9070602@cogentembedded.com>
Date:   Fri, 17 Apr 2015 19:20:14 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] devicetree: Add bindings for the ATH79 PLL controllers
References: <1429280669-2986-1-git-send-email-albeu@free.fr> <1429280669-2986-8-git-send-email-albeu@free.fr>
In-Reply-To: <1429280669-2986-8-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46899
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

On 04/17/2015 05:24 PM, Alban Bedel wrote:

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>   .../devicetree/bindings/clock/qca,ath79-pll.txt    | 33 ++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt

> diff --git a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
> new file mode 100644
> index 0000000..2d2da3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
> @@ -0,0 +1,33 @@
> +Binding for Qualcomm Atheros AR7xxx/AR9XXX PLL controller
> +
> +The PPL controller provides the 3 main clocks of the SoC: CPU, DDR and AHB.
> +
> +Required Properties:
> +- compatible: has to be "qca,<soctype>-cpu-intc" and one of the following
> +  fallback:

    Fallbacks.

> +  - "qca,ar7100-pll"
> +  - "qca,ar7240-pll"
> +  - "qca,ar9130-pll"
> +  - "qca,ar9330-pll"
> +  - "qca,ar9340-pll"
> +  - "qca,ar9550-pll"
> +- reg: Base address and size of the controllers memory area
> +- clock-names: Name of the input clock, has to be "ref"
> +- clock: phandle of the external reference clock

    The prop name is "clocks", not "clock".

[...]

WBR, Sergei
