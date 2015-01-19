Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 12:54:22 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:54609 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011585AbbASLyUsFLZA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 12:54:20 +0100
Received: by mail-lb0-f182.google.com with SMTP id l4so2258835lbv.13
        for <linux-mips@linux-mips.org>; Mon, 19 Jan 2015 03:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1E11RnaDOpIHm67XVI4ocb6k6aKUMULBvNKTiUgsfdE=;
        b=ccGO09SDVK3A5OqDhNdUZhIcMc6Va+pStHYAxg7sBZd8DL3FAdO/sbRvKpDkPfvV+B
         8mNBtDIty5wFOMZXVFaW3tsUt9EgvNhDWMsW1vNvRCbLtusZ1DE7u/Ymjd2GIg4bGZIF
         GrLDdyLG92042ev4lCb1iDDqb0ReM2l5xnllzkcEqT48FpWGWNexHvi/hjELjmyC4l44
         AnTc01ESCtHlarDrhhzr34C7YQ+oaTAr/8mtPVnsCNH6RqM6oxMuKHzTrrmqOIoKMpEf
         mLMB0haoAnYYVkIqvnBAYIcabOX7KaDI3h07dZ9ihlA82QYYEr3zZBhN4nsI95f+L6Gg
         0rAw==
X-Gm-Message-State: ALoCoQlSTZOSnSYrM/DQAgaCOJi01RyN38/Y7055BD6qSqeqiXWWSBuZdTedfOO1mRyGGPIu4cRZ
X-Received: by 10.152.7.180 with SMTP id k20mr16689902laa.4.1421668453467;
        Mon, 19 Jan 2015 03:54:13 -0800 (PST)
Received: from [192.168.3.68] (ppp28-153.pppoe.mtu-net.ru. [81.195.28.153])
        by mx.google.com with ESMTPSA id ci9sm3600144lad.21.2015.01.19.03.54.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2015 03:54:12 -0800 (PST)
Message-ID: <54BCF062.1010009@cogentembedded.com>
Date:   Mon, 19 Jan 2015 14:54:10 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/36] devicetree: document ingenic,jz4740-intc binding
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com> <1421620067-23933-8-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1421620067-23933-8-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45303
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

On 1/19/2015 1:27 AM, Paul Burton wrote:

> Add binding documentation for the Ingenic jz4740 interrupt controller.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: devicetree@vger.kernel.org
> ---
>   .../interrupt-controller/ingenic,jz4740-intc.txt   | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt
> new file mode 100644
> index 0000000..3c06ef1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt
> @@ -0,0 +1,24 @@
> +Ingenic jz4740 SoC Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : should be "ingenic,jz4740-intc"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +- interrupt-parent: phandle of the CPU interrupt controller.
> +- interrupts - Specifies the CPU interrupt the controller is connected to.
> +
> +Example:
> +
> +intc: intc@10001000 {

    The node name should be "interrupt-controller@10001000", according to the 
ePAPR standard.

WBR, Sergei
