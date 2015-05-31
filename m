Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2015 14:24:05 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35013 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006675AbbEaMYD0uq64 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2015 14:24:03 +0200
Received: by lbbuc2 with SMTP id uc2so70322819lbb.2
        for <linux-mips@linux-mips.org>; Sun, 31 May 2015 05:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dffrSQCjOt96U7yn4ggmoAii2Xz52/DGe/WtfwL96zg=;
        b=GxjE7lhEzEq+vF5mPMvI5BBEUbhGn2AQNekzf6ci/arGr0DzLDLY0bEfJmQ1g+xZBA
         8WK9/dou8dcmyOwv5jHbA4qlO+1y2Fwjz7UXCLVcHowc2Bca/SgY5/nxlxzD2r9lvNvH
         ak2l+0MK6J/EcgqLulNaOVvORB2huP576geiCvCJ/cFWLCS4MzrYl7fQgewCdxZ37zsc
         PN/WLBaSnFIfNuVvgI203Zw7QX6A439hyd3TQujPbhrGzLw09l4qLyPTfWVzsNKhN+RB
         UCbZm5r4SN1kVk42tOS5Aa4V4oabZB09SS/lWh/zJ2y3DqRllro/fAX7JcxsGZzG4xot
         u4Kw==
X-Gm-Message-State: ALoCoQmKsWurMnE/y2DfwjeN3AyZbrqZZEv9Bw+p01xa3gD87IAB0m+JDm7hKBAkFBucfvrmtsEp
X-Received: by 10.152.26.230 with SMTP id o6mr16881275lag.7.1433075037137;
        Sun, 31 May 2015 05:23:57 -0700 (PDT)
Received: from [192.168.3.154] (ppp85-141-192-200.pppoe.mtu-net.ru. [85.141.192.200])
        by mx.google.com with ESMTPSA id ao10sm3248174lac.0.2015.05.31.05.23.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 05:23:56 -0700 (PDT)
Message-ID: <556AFD59.4080009@cogentembedded.com>
Date:   Sun, 31 May 2015 15:23:53 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
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
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/12] devicetree: Add bindings for the ATH79 DDR controllers
References: <1433029955-7346-1-git-send-email-albeu@free.fr> <1433029955-7346-4-git-send-email-albeu@free.fr>
In-Reply-To: <1433029955-7346-4-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47750
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

On 5/31/2015 2:52 AM, Alban Bedel wrote:

> The DDR controller of the ARxxx and AR9xxx families provides an
> interface to flush the FIFO between various devices and the DDR.
> This is mainly used by the IRQ controller to flush the FIFO before
> running the interrupt handler of such devices.

> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
> v2: * Fix the node names to respect ePAPR
> v3: * Fix some typos
>      * Really fix the node names this time
> ---
>   .../memory-controllers/ath79-ddr-controller.txt    | 35 ++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt

> diff --git a/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt b/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
> new file mode 100644
> index 0000000..efe35a06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
> @@ -0,0 +1,35 @@
> +Binding for Qualcomm  Atheros AR7xxx/AR9xxx DDR controller
> +
> +The DDR controller of the ARxxx and AR9xxx families provides an interface

    s/ARxxx/AR7xxx/.

> +to flush the FIFO between various devices and the DDR. This is mainly used
> +by the IRQ controller to flush the FIFO before running the interrupt handler
> +of such devices.
> +
> +Required properties:
> +
> +- compatible: has to be "qca,<soc-type>-ddr-controller",
> +  "qca,[ar7100|ar7240]-ddr-controller" as fallback.
> +  On SoC with PCI support "qca,ar7100-ddr-controller" should be used as
> +  fallback, otherwise "qca,ar7240-ddr-controller" should be used.
> +- reg: Base address and size of the controllers memory area

    Controller's.

> +- #qca,ddr-wb-channel-cells: has to be 1, the index of the write buffer
> +  channel

    Hm, index? The expectation for such props is the # of cells.

WBR, Sergei
