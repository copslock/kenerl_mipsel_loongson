Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 20:34:17 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:44855 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3HWSeMpsFbJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Aug 2013 20:34:12 +0200
Received: by mail-la0-f42.google.com with SMTP id ep20so749552lab.15
        for <linux-mips@linux-mips.org>; Fri, 23 Aug 2013 11:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CFRzLRqxIglSdFXTxHmOFeCPUXG4FGyxjjO9iMbMsl8=;
        b=DudOXfCbL7t8S329lTE4tntj9t1SFsy0K+REbtbIx4wUHWVt0HDqyTQkS90VN6nHBQ
         4HUy/xrxFrqVFT4WLyp6TdeQve7gydjGS+lJsfjvurBSaY0fiZVXbgN06OTYYS2OBdRY
         a9jb530WHldUa5OhHbqvlYbL8cm5LCS/jElhPXdX36n9ZH2/TMcuBmN7FpjunTi1aZg1
         5sXkWfZzMq3lSOax22c/LdpOSaEpY8mi7n5HOHtANkCGjuANRFBo/qw8LKQBKzw4Bhxx
         +gGZfnwO8VXt5+VO0rW7xxNTuhfFa5HNQIz2Sctca8Z8JJtvU38kkokp6bhB7gKsjdTH
         nnxw==
X-Gm-Message-State: ALoCoQnRHjFTRlHLzdKLkIE23l9kJc8MiZjBqgNeqpmFTx8XIDivbampX/TFWotaYX+pkkBmyGNL
X-Received: by 10.152.21.225 with SMTP id y1mr642544lae.18.1377282846825;
        Fri, 23 Aug 2013 11:34:06 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-147-116.pppoe.mtu-net.ru. [91.76.147.116])
        by mx.google.com with ESMTPSA id l1sm767772lbj.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 11:34:05 -0700 (PDT)
Message-ID: <5217AB25.3050106@cogentembedded.com>
Date:   Fri, 23 Aug 2013 22:34:13 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 4/6] DT: MIPS: ralink: add RT2880 dts files
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org> <1365843026-11015-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365843026-11015-4-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37667
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

On 04/13/2013 12:50 PM, John Crispin wrote:

> Add a dtsi file for RT2880 SoC and a sample dts file.

    You forgot to mention Kconfig entry...

> Signed-off-by: John Crispin <blogic@openwrt.org>
[...]

> diff --git a/arch/mips/ralink/dts/Makefile b/arch/mips/ralink/dts/Makefile
> index 1a69fb3..f635a01 100644
> --- a/arch/mips/ralink/dts/Makefile
> +++ b/arch/mips/ralink/dts/Makefile
> @@ -1 +1,2 @@
> +obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
>   obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
> diff --git a/arch/mips/ralink/dts/rt2880.dtsi b/arch/mips/ralink/dts/rt2880.dtsi
> new file mode 100644
> index 0000000..182afde
> --- /dev/null
> +++ b/arch/mips/ralink/dts/rt2880.dtsi
> @@ -0,0 +1,58 @@
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ralink,rt2880-soc";
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "mips,mips4KEc";
> +		};
> +	};
> +
> +	cpuintc: cpuintc@0 {

    According to ePAPR spec [1], the node name should be "interrupt-controller".

> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		compatible = "mti,cpu-interrupt-controller";

    So, it's "mips" or "mti"?

> +	};
> +
> +	palmbus@300000 {
> +		compatible = "palmbus";
> +		reg = <0x300000 0x200000>;
> +                ranges = <0x0 0x300000 0x1FFFFF>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysc@0 {

    Perhaps "system-controller" to be in the same vein with other correct 
naming I'm saying about?

> +			compatible = "ralink,rt2880-sysc";
> +			reg = <0x0 0x100>;
> +		};
> +
> +		intc: intc@200 {

    According to ePAPR spec [1], the node name should be "interrupt-controller".

> +			compatible = "ralink,rt2880-intc";
> +			reg = <0x200 0x100>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			interrupt-parent = <&cpuintc>;
> +			interrupts = <2>;
> +		};
> +
> +		memc@300 {

    According to ePAPR spec [1], the node name should be "memory-controller".

> +			compatible = "ralink,rt2880-memc";
> +			reg = <0x300 0x100>;
> +		};
> +
> +		uartlite@c00 {

    According to ePAPR spec [1], the node name should be "serial".

[...]
> diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
> new file mode 100644
> index 0000000..e967b43
> --- /dev/null
> +++ b/arch/mips/ralink/dts/rt2880_eval.dts
> @@ -0,0 +1,48 @@
> +/dts-v1/;
> +
> +/include/ "rt2880.dtsi"
> +
> +/ {
[...]
> +	cfi@1f000000 {

    According to ePAPR spec [1], the node name should be "flash".

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
