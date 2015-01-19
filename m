Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 13:08:26 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:58917 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011794AbbASMIXkyjJ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 13:08:23 +0100
Received: by mail-lb0-f182.google.com with SMTP id l4so2323252lbv.13
        for <linux-mips@linux-mips.org>; Mon, 19 Jan 2015 04:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iosw5aKYYpFPJO+8ANszhsXJYx+j4DZhtfQqe+tc3kE=;
        b=AwDxlHXC2+9SHELNILyM1ZAQ6g9uM/JdUHb7N+zY18ZLG+J550rGr2l2kcCAFxdIAv
         heg+ze+bKHxftdY0HdEA5nRfNSZWz/ISJXlcwMfxDyrARxsNjLpkp1DWfKaNm/pADd21
         kvqAqKBK0o8rKAXwohdmmVShK2tBLr74A/XvICNu+QhEv9NccpDHHI/unPYy6sT3Rj3I
         A2x/W2oE8WEgFA4WRW3lox2QnOQ873IiMPTgmFM4v1tbYNoyyI6YJxt5WgbdJbyHfe5n
         e8U6Ya5qor+MMuD/qRBDYRZkUdmd/ZemmqL2Ecxj2U0Pdw+Nvkx5+aijTrtlXTjrdtOn
         hhRg==
X-Gm-Message-State: ALoCoQlXfFwGGjJbmG2xclTMfL8gBezPqBGHSg232YEOtrg2KfjH91dwoKDR63Le2HpTuFe94i5t
X-Received: by 10.112.188.201 with SMTP id gc9mr24718675lbc.6.1421669298239;
        Mon, 19 Jan 2015 04:08:18 -0800 (PST)
Received: from [192.168.3.68] ([81.195.28.153])
        by mx.google.com with ESMTPSA id l1sm3613386lag.11.2015.01.19.04.08.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2015 04:08:17 -0800 (PST)
Message-ID: <54BCF3AE.2080704@cogentembedded.com>
Date:   Mon, 19 Jan 2015 15:08:14 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH 31/36] devicetree: document ingenic,jz4780-intc binding
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com> <1421620945-25502-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1421620945-25502-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45305
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

On 1/19/2015 1:42 AM, Paul Burton wrote:

> Add binding documentation for the Ingenic jz4780 interrupt controller.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: devicetree@vger.kernel.org
> ---
>   .../interrupt-controller/ingenic,jz4780-intc.txt   | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4780-intc.txt

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4780-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4780-intc.txt
> new file mode 100644
> index 0000000..c6164d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4780-intc.txt
> @@ -0,0 +1,24 @@
> +Ingenic jz4780 SoC Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : should be "ingenic,jz4780-intc"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +- interrupt-parent: phandle of the CPU interrupt controller.

    This is never a required prop, it can be inherited from an upper level node.

> +- interrupts - Specifies the CPU interrupt the controller is connected to.
> +
> +Example:
> +
> +intc: intc@10001000 {

    Again, should be "interrupt-controller@10001000".

WBR, Sergei
