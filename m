Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 15:00:14 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:53307 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818323Ab3DPNANVOakE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Apr 2013 15:00:13 +0200
Received: by mail-lb0-f182.google.com with SMTP id z13so509884lbh.41
        for <linux-mips@linux-mips.org>; Tue, 16 Apr 2013 06:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=X2+YP8fkZ14rabS5wjGSrFRn15gLl6nDfIzTd9Ye8Vg=;
        b=j05TGvJyeXGJ3xbyjY6jARTpbkqQMJbwN8K/zbVQgY9Gw8fXLVV4t+7xq6qd+aBZ7Z
         mEDFTi7U7UYMHhJ+HXlVFjh/K4++ibld3FD5vaXZxlNX3xp3XndfFS8FHUK1A2bi3tdw
         NZKnuRuBtpMmjHBG03HA1Mqlmre6tHRP3YGUch56speIiLZ33426rtqz3MFvApnibY24
         3F5619QU82Xd1ciwEoT0txxluduifU16+wIXY74Ww/IkxBnnztDSlVzFHJAIUg8Wqj5F
         7JupDwyYqNoxlDn45D5ZRs4bIqtyl3YUfQ0fPcizyOvDe29XTpxOrdl/dwuAocR1yYis
         g9tw==
X-Received: by 10.112.19.196 with SMTP id h4mr1290176lbe.111.1366117207458;
        Tue, 16 Apr 2013 06:00:07 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-67-213.pppoe.mtu-net.ru. [91.79.67.213])
        by mx.google.com with ESMTPS id p1sm822459lae.0.2013.04.16.06.00.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 06:00:06 -0700 (PDT)
Message-ID: <516D4B15.406@cogentembedded.com>
Date:   Tue, 16 Apr 2013 16:59:01 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH V2 6/6] DT: MIPS: ralink: add MT7620A dts files
References: <1366103562-21463-1-git-send-email-blogic@openwrt.org> <1366103562-21463-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1366103562-21463-6-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnr1FMPGxvL16ozLKEE9aTee4V78/AWvayyDroEvoQDRMSFqB4JalURwErVJ2IhkskgwdFw
X-archive-position: 36241
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

> Add a dtsi file for MT7620A SoC and a sample dts file.

> Signed-off-by: John Crispin <blogic@openwrt.org>
[...]

> diff --git a/arch/mips/ralink/dts/mt7620a.dtsi b/arch/mips/ralink/dts/mt7620a.dtsi
> new file mode 100644
> index 0000000..08bf24f
> --- /dev/null
> +++ b/arch/mips/ralink/dts/mt7620a.dtsi
> @@ -0,0 +1,58 @@
[...]
> +	cpuintc: cpuintc@0 {
> +		#address-cells = <0>;

    Why? There's no subnodes.

> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		compatible = "mti,cpu-interrupt-controller";
> +	};
> +
> +	palmbus@10000000 {
> +		compatible = "palmbus";
> +		reg = <0x10000000 0x200000>;
> +                ranges = <0x0 0x10000000 0x1FFFFF>;

    This line is indented with spaces. And the last cell should probably be 
0x200000.

WBR, Sergei
