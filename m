Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 21:15:24 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33939 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007276AbbEZTPWZlSm2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2015 21:15:22 +0200
Received: by lbcmx3 with SMTP id mx3so77598691lbc.1
        for <linux-mips@linux-mips.org>; Tue, 26 May 2015 12:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qRrQKCBiScs953JrChIvQ+JLZVzXAH9izMo8CDzx3Pg=;
        b=DexgrrTHmgDUl0mtX3/rDP30PtfEEXSSMg5uzVv1SbaELIuiCtzALhnDLX81MYia7c
         Y8nM3FJBHGK94J6pdPLQdpxRoqMQF4h/3kAHA/E7K+TUj6PNA32fyZJNuGqNejt+yyJd
         mwbu6f1xtKOWgIP1ag8dXq+JoH4bm0/SNSK/vJzg+mKfjq+nWtFq6UXKnhR6hpXBWQDX
         giNG/NyV5TaOpB1HqD+DCALPTarvjEYjZqZuOpUogNafpVy3+PSirK8zOsqmCQjHe1ol
         FEN/gMDtxeUp+mYu1SUWFhHsBIfjWFXXPgyBBpACPvENL22h+HA2rC9f0y98o84tOxRE
         T7cw==
X-Gm-Message-State: ALoCoQmIbu2mkmE7U+Hvsj8NV+E9EL6/6id+nwRvrBorOXN6bljkc7dWbicllJYCYyUqaj48qtQ5
X-Received: by 10.152.21.136 with SMTP id v8mr24339226lae.19.1432667719763;
        Tue, 26 May 2015 12:15:19 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp27-27.pppoe.mtu-net.ru. [81.195.27.27])
        by mx.google.com with ESMTPSA id wh9sm3222814lbb.45.2015.05.26.12.15.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2015 12:15:18 -0700 (PDT)
Message-ID: <5564C644.7040700@cogentembedded.com>
Date:   Tue, 26 May 2015 22:15:16 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj.Raja@imgtec.com, Damien.Horsley@imgtec.com,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 5/7] clocksource: Add Pistachio SoC general purpose
 timer binding document
References: <1432665548-16024-1-git-send-email-ezequiel.garcia@imgtec.com> <1432665671-16102-1-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1432665671-16102-1-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47679
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

On 05/26/2015 09:41 PM, Ezequiel Garcia wrote:

> Add a device-tree binding document for the clocksource driver provided
> by Pistachio SoC general purpose timers.

> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>   .../bindings/timer/img,pistachio-gptimer.txt       | 28 ++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt

> diff --git a/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt b/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
> new file mode 100644
> index 0000000..418379f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
> @@ -0,0 +1,28 @@
> +* Pistachio general-purpose timer based clocksource
> +
> +Required properties:
> + - compatible: "img,pistachio-gptimer".
> + - reg: Address range of the timer registers.
> + - interrupts: An interrupt for each of the four timers
> + - clocks : Should contain a clock specifier for each entry in clock-names
> + - clock-names : Should contain the following entries:

    Could you please be consistent about the spacing before colon?

[...]

WBR, Sergei
