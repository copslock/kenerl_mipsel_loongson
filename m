Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:46:39 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:27740 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011442AbcAYWqiN-heU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:46:38 +0100
Received: from tock (unknown [80.171.100.146])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 707E98227F;
        Mon, 25 Jan 2016 23:45:05 +0100 (CET)
Date:   Mon, 25 Jan 2016 23:46:30 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org
Subject: Re: [RFC v3 08/14] MIPS: dts: qca: introduce AR9331 devicetree
Message-ID: <20160125234630.16098b7f@tock>
In-Reply-To: <1453580251-2341-9-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-9-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sat, 23 Jan 2016 23:17:25 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> This patch introduces devicetree for Atheros AR9331 SoC (AKA Hornet).
> The AR9331 chip is a Wi-Fi System-On-Chip (WiSOC),
> typically used in very cheap Access Points and Routers.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Gabor Juhos <juhosg@openwrt.org>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/mips/boot/dts/qca/ar9331.dtsi | 123 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
> new file mode 100644
> index 0000000..bf128a2
> --- /dev/null
> +++ b/arch/mips/boot/dts/qca/ar9331.dtsi
> @@ -0,0 +1,123 @@
> +#include <dt-bindings/clock/ath79-clk.h>
> +
> +/ {
> +	compatible = "qca,ar9331";
> +

[...]

> +
> +	extosc: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};

This oscillator is on the board and not in the SoC, so it should
be in the board DTS.

Alban
