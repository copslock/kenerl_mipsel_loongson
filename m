Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Apr 2013 11:54:20 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41684 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824803Ab3DNJySoad9l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 14 Apr 2013 11:54:18 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9lMXQ0hFevil; Sun, 14 Apr 2013 11:53:30 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 94412281086;
        Sun, 14 Apr 2013 11:53:30 +0200 (CEST)
Message-ID: <516A7CF2.6020507@openwrt.org>
Date:   Sun, 14 Apr 2013 11:54:58 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 5/6] DT: MIPS: ralink: add RT3883 dts files
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org> <1365843026-11015-5-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365843026-11015-5-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36161
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

2013.04.13. 10:50 keltezéssel, John Crispin írta:
> Add a dtsi file for RT3883 SoC and a sample dts file.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/Kconfig             |    4 +++
>  arch/mips/ralink/dts/Makefile        |    1 +
>  arch/mips/ralink/dts/rt3883.dtsi     |   58 ++++++++++++++++++++++++++++++++++
>  arch/mips/ralink/dts/rt3883_eval.dts |   18 +++++++++++
>  4 files changed, 81 insertions(+)
>  create mode 100644 arch/mips/ralink/dts/rt3883.dtsi
>  create mode 100644 arch/mips/ralink/dts/rt3883_eval.dts

<...>

> diff --git a/arch/mips/ralink/dts/rt3883.dtsi b/arch/mips/ralink/dts/rt3883.dtsi
> new file mode 100644
> index 0000000..3b131dd
> --- /dev/null
> +++ b/arch/mips/ralink/dts/rt3883.dtsi
> @@ -0,0 +1,58 @@
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "ralink,rt3883-soc";
> +

<...>

> diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/ralink/dts/rt3883_eval.dts
> new file mode 100644
> index 0000000..0297f20
> --- /dev/null
> +++ b/arch/mips/ralink/dts/rt3883_eval.dts
> @@ -0,0 +1,18 @@
> +/dts-v1/;
> +
> +/include/ "rt3883.dtsi"
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;

These -cells properties are superfluous, because the rt3883.dtsi file contains
these already.

-Gabor
