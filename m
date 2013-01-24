Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 14:52:51 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:57616 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833437Ab3AXNwuCn-hU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 14:52:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id DC7A025BAD6;
        Thu, 24 Jan 2013 14:52:44 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1SO9zJtDe-rn; Thu, 24 Jan 2013 14:52:44 +0100 (CET)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPSA id 979A625BAD0;
        Thu, 24 Jan 2013 14:52:44 +0100 (CET)
Message-ID: <51013CB9.8060401@openwrt.org>
Date:   Thu, 24 Jan 2013 14:52:57 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 10/11] MIPS: ralink: adds rt305x devicetree
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-11-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-11-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Antivirus: avast! (VPS 130124-0, 2013.01.24), Outbound message
X-Antivirus-Status: Clean
X-archive-position: 35540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.01.23. 13:05 keltezéssel, John Crispin írta:
> This adds the devicetree file that describes the rt305x evaluation kit.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/dts/rt305x.dts |  156 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 arch/mips/ralink/dts/rt305x.dts
> 
> diff --git a/arch/mips/ralink/dts/rt305x.dts b/arch/mips/ralink/dts/rt305x.dts
> new file mode 100644
> index 0000000..6554cfd
> --- /dev/null
> +++ b/arch/mips/ralink/dts/rt305x.dts
> @@ -0,0 +1,156 @@
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ralink,rt305x";
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "mips,mips24KEc";
> +		};
> +	};
> +
> +	memory@0 {
> +		reg = <0x0 0x4000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,57600 init=/init";
> +	};
> +
> +	palmbus@10000000 {
> +		compatible = "palmbus";
> +		reg = <0x10000000 0x200000>;
> +                ranges = <0x0 0x10000000 0x1FFFFF>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysc@0 {
> +			compatible = "ralink,sysc";

The <model> part of the compatible string should contain the SoC name as well.

For this particular node, the compatible property should be:
    compatible = "ralink,rt3050-sysc", "ralink,rt2880-sysc";

The first entry specifies the exact device and the second entry states that it
is compatible with the SYSC controller introduced in the RT2880 SoC.

This note applies to all other nodes as well.

-Gabor
