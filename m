Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 15:01:58 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63515 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835174Ab3DPNB4Ti1xg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Apr 2013 15:01:56 +0200
Received: by mail-lb0-f174.google.com with SMTP id s10so524022lbi.33
        for <linux-mips@linux-mips.org>; Tue, 16 Apr 2013 06:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=i8vy/pNWttW8/sxDAIkk98xxfAGOR8opEfLbT0T+JoI=;
        b=DNs+lEqZVHle9fEV55oBOUPxP4d+Fag2IEPq7k0YEe+R2fxXRgwje1Y8MiIkr6CR0c
         MTqa/LX6uvdZoY/QgGSdRcbd/kBRP79vQtsHQG6+a9SVnKM0k8/oAX2S/NqB9tbIXtzN
         rMNIaLoVyiP3Hqm/kiZaSH8QCOakZtw25jmdOxJ1KOwr4SbBOTmTRsmxHAUbSdpGzeIH
         aPzoZ6/1T4yYR1yUrWiP4IM6fJbNyrT2XII+jD6qqWwUUc5x8nROYhpKRA1MA2mhBMsg
         tsTZ3KxFIewBY+4Dd/4KO/JgBxohssccvaEX7DtUf1+BJstog98XohPlfPWvurvQ6ykB
         m98Q==
X-Received: by 10.152.109.208 with SMTP id hu16mr1148773lab.45.1366117310541;
        Tue, 16 Apr 2013 06:01:50 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-67-213.pppoe.mtu-net.ru. [91.79.67.213])
        by mx.google.com with ESMTPS id xw14sm815970lab.6.2013.04.16.06.01.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 06:01:49 -0700 (PDT)
Message-ID: <516D4B7D.1030302@cogentembedded.com>
Date:   Tue, 16 Apr 2013 17:00:45 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH V2 5/6] DT: MIPS: ralink: add RT3883 dts files
References: <1366103562-21463-1-git-send-email-blogic@openwrt.org> <1366103562-21463-5-git-send-email-blogic@openwrt.org>
In-Reply-To: <1366103562-21463-5-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQn55HN/CWj5Ur9rC0zEPS5MNCLSg5wrmOUrb+0zsZ+XkH8R/QmuSt/HurhHJGkhFwlkswlX
X-archive-position: 36242
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 16-04-2013 13:12, John Crispin wrote:

> Add a dtsi file for RT3883 SoC and a sample dts file.

> Signed-off-by: John Crispin <blogic@openwrt.org>
[...]

> diff --git a/arch/mips/ralink/dts/rt3883.dtsi b/arch/mips/ralink/dts/rt3883.dtsi
> new file mode 100644
> index 0000000..3b131dd
> --- /dev/null
> +++ b/arch/mips/ralink/dts/rt3883.dtsi
> @@ -0,0 +1,58 @@
[...]
> +	cpuintc: cpuintc@0 {
> +		#address-cells = <0>;

    There's no subnodes?

> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		compatible = "mti,cpu-interrupt-controller";
> +	};
> +
> +	palmbus@10000000 {
> +		compatible = "palmbus";
> +		reg = <0x10000000 0x200000>;
> +		ranges = <0x0 0x10000000 0x1FFFFF>;

    Why the last cell is not 0x200000?

WBR, Sergei
