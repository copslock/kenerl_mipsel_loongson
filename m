Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 18:07:21 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43246 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825725Ab3AaRHSotgeH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jan 2013 18:07:18 +0100
Received: by mail-pa0-f52.google.com with SMTP id fb1so411441pad.11
        for <multiple recipients>; Thu, 31 Jan 2013 09:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xQcexh85Znj65JUO+yJHkJorP0PgYhkjXjhbc11bfhI=;
        b=zaXyG97u/ihVulMLusttBbhaOWBHYjAhXfh8imP/Yh1VL9UhMGLtLjBENBGKuCjlV+
         4ea7jYX3Mzq9eoJWXU9FMs97Kqx/PVpZpFcij691hyQ+QPO37/jo4bVRTDB3JMiDcrNk
         15qbi0DUi7+oUqAdAc6/HCnV8yuQmNgtZX0CKovuZC9S5g5Ld//7KQyRWmkCohB+Fges
         XUhSWXrwKUrT6uwPRV1pPq5tpkha4fMrLz9mIM+DnLN9AVmsxaS+RUX+EpcUb85zS5NZ
         9vZX9jE2ZjG2XV0dCsvjFXSii282f52nA+Qj7D2KAvPCYSWp71lKfJk/1iKkPgLwHKxK
         InBQ==
X-Received: by 10.68.209.230 with SMTP id mp6mr23975764pbc.8.1359652031605;
        Thu, 31 Jan 2013 09:07:11 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ba3sm5520376pbd.29.2013.01.31.09.07.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 09:07:10 -0800 (PST)
Message-ID: <510AA4BD.2030000@gmail.com>
Date:   Thu, 31 Jan 2013 09:07:09 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 1/3] Document: devicetree: add OF documents for MIPS interrupt
 controller
References: <1359638444-8891-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359638444-8891-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/31/2013 05:20 AM, John Crispin wrote:
> Signed-off-by: John Crispin <blogic@openwrt.org>
Acked-by: David Daney <david.daney@cavium.com>

> ---
>   Documentation/devicetree/bindings/mips/cpu_irq.txt |   47 ++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.txt
>
> diff --git a/Documentation/devicetree/bindings/mips/cpu_irq.txt b/Documentation/devicetree/bindings/mips/cpu_irq.txt
> new file mode 100644
> index 0000000..13aa4b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/cpu_irq.txt
> @@ -0,0 +1,47 @@
> +MIPS CPU interrupt controller
> +
> +On MIPS the mips_cpu_intc_init() helper can be used to initialize the 8 CPU
> +IRQs from a devicetree file and create a irq_domain for IRQ controller.
> +
> +With the irq_domain in place we can describe how the 8 IRQs are wired to the
> +platforms internal interrupt controller cascade.
> +
> +Below is an example of a platform describing the cascade inside the devicetree
> +and the code used to load it inside arch_init_irq().
> +
> +Required properties:
> +- compatible : Should be "mti,cpu-interrupt-controller"
> +
> +Example devicetree:
> +	cpu-irq: cpu-irq@0 {
> +		#address-cells = <0>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		compatible = "mti,cpu-interrupt-controller";
> +	};
> +
> +	intc: intc@200 {
> +		compatible = "ralink,rt2880-intc";
> +		reg = <0x200 0x100>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		interrupt-parent = <&cpu-irq>;
> +		interrupts = <2>;
> +	};
> +
> +
> +Example platform irq.c:
> +static struct of_device_id __initdata of_irq_ids[] = {
> +	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_intc_init },
> +	{ .compatible = "ralink,rt2880-intc", .data = intc_of_init },
> +	{},
> +};
> +
> +void __init arch_init_irq(void)
> +{
> +	of_irq_init(of_irq_ids);
> +}
>
