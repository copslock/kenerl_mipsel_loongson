Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:29:54 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:42383 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011584AbcAYWZtIF7kA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:25:49 +0100
Received: from tock (unknown [80.171.100.146])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 6F16582246;
        Mon, 25 Jan 2016 23:24:17 +0100 (CET)
Date:   Mon, 25 Jan 2016 23:25:42 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC v3 05/14] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop
 unused alias node
Message-ID: <20160125232542.65f9b12e@tock>
In-Reply-To: <1453580251-2341-6-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-6-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51377
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

On Sat, 23 Jan 2016 23:17:22 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> The TP-LINK TL-WR1043ND board has only one serial port,
> so replacing the default of 0 with 0 does nothing useful.
> 
> Moreover, the correct name for aliases node is "aliases" not "alias".
> 
> An overview of the "aliases" node usage can be found
> on the device tree usage page at devicetree.org [1].
> 
> Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].
> 
> [1] http://devicetree.org/Device_Tree_Usage#aliases_Node
> [2] https://www.power.org/documentation/epapr-version-1-1/
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>

Acked-by: Alban Bedel <albeu@free.fr>

> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> index 53057ca..9618105 100644
> --- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> @@ -9,10 +9,6 @@
>  	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
>  	model = "TP-Link TL-WR1043ND Version 1";
>  
> -	alias {
> -		serial0 = "/ahb/apb/uart@18020000";
> -	};
> -
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x2000000>;
