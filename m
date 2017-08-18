Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 18:04:41 +0200 (CEST)
Received: from mail-lf0-x229.google.com ([IPv6:2a00:1450:4010:c07::229]:34702
        "EHLO mail-lf0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994915AbdHRQE3VOKNs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 18:04:29 +0200
Received: by mail-lf0-x229.google.com with SMTP id g77so12246021lfg.1
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2017 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lAYN/xwFMjomELxZ7E0V+Ja6bZU+dAZFtjwW3sXVA8g=;
        b=Cw81v5iKRGhFkD2y7AgSb+2XV7OqOKKOQaBtzoL2feoXWhYe7vIyaxdD1/xeFdUrvH
         WLNOryqGC/zZk6Cvi63O8lXw/XnLUpJQspKvh0xMEp+Kc8HaAXp7SBMcnecG3LAaq1rX
         kzVdOyxms0HRAO6jhQKBbt0/CZKf3jUFvf14x6PwHEoJSMG796VzmpqobEt003K1TjTJ
         s8YSCMCmBUS3IYCDm9NJymhxaosqXlaVByUoEROXvpC67M6IzLTApytGs4ptW3el0iHK
         lL/hoh4ujgsdzDS7BeJ1/JHf81mwPumZD/CewDjxk2IE/Tw9K5x/Op9ahTLVoyxWBKT+
         7whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lAYN/xwFMjomELxZ7E0V+Ja6bZU+dAZFtjwW3sXVA8g=;
        b=YCm3+e5nnNr4cKPULBg59qbECq7oDU2/ygl5qYXVLbW1tNFHWZdkBRnQCZT2FOtqPZ
         qpZUwCjLpQJA6WiQnjKsDEBVbbWeF+Qd3V2sLy9zZzkH5XR58L/t4Tm6InA2oRq+1cds
         y6ee6NyAUXQd2zTqM6UnjroECcJ67/9TC4cGQBeGiMTeh/zcd/lqQHUqSS2a/784M2NK
         HewRVw1hC/YVvisWlwDukDdtZzfCtxVM+YFK92xd2yEHRpJZfX7UHNYNh36gJYZHRCgp
         6ZrqxCFnLs76oxVWnDhHniYGjTKruObGkXBzMTD0Jt9ni+vzrZ+vsJkJP2GgEM5RCddK
         /awg==
X-Gm-Message-State: AHYfb5iefz3WzBm5RIxaZZpU2Sq+ZVeGHnN7UgRzLQHulRcRBKQTLEcS
        QlBM7d5rsjIuqWHB
X-Received: by 10.25.38.85 with SMTP id m82mr3980815lfm.20.1503072263878;
        Fri, 18 Aug 2017 09:04:23 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.183])
        by smtp.gmail.com with ESMTPSA id h70sm1349750lfh.66.2017.08.18.09.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 09:04:22 -0700 (PDT)
Subject: Re: [PATCH v4 6/8] Documentation: Add device tree binding for
 Goldfish FB driver
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Bo Hu <bohu@google.com>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org,
        Douglas Leung <douglas.leung@imgtec.com>,
        dri-devel@lists.freedesktop.org,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-7-git-send-email-aleksandar.markovic@rt-rk.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <64418e6a-7ac2-ae2f-a064-937343ecb136@cogentembedded.com>
Date:   Fri, 18 Aug 2017 19:04:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1503061833-26563-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59674
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

On 08/18/2017 04:08 PM, Aleksandar Markovic wrote:

> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> 
> Add documentation for DT binding of Goldfish FB driver. The compatible
> string used by OS for binding the driver is "google,goldfish-fb".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>   .../devicetree/bindings/display/google,goldfish-fb.txt | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
> new file mode 100644
> index 0000000..9ce0615
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
> @@ -0,0 +1,18 @@
> +Android Goldfish framebuffer
> +
> +Android Goldfish framebuffer device used by Android emulator.
> +
> +Required properties:
> +
> +- compatible : should contain "google,goldfish-fb"
> +- reg        : <registers mapping>
> +- interrupts : <interrupt mapping>
> +
> +Example:
> +
> +	goldfish_fb@1f008000 {

    The node names should be generic according to the DT spec. It even has the 
fitting name: "display".

> +		compatible = "google,goldfish-fb";
> +		interrupts = <0x10>;
> +		reg = <0x1f008000 0x0 0x100>;
> +		compatible = "google,goldfish-fb";

    Why twice? :-)

> +	};
> 

MBR, Sergei
