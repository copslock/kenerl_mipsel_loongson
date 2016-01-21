Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 11:31:49 +0100 (CET)
Received: from smtp1-g21.free.fr ([212.27.42.1]:44894 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009492AbcAUKbrpIa4Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 11:31:47 +0100
Received: from tock (unknown [78.54.115.92])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 3D180940024;
        Thu, 21 Jan 2016 11:30:21 +0100 (CET)
Date:   Thu, 21 Jan 2016 11:31:41 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop
 unused alias node
Message-ID: <20160121113141.66ac374c@tock>
In-Reply-To: <1453370345-16688-2-git-send-email-antonynpavlov@gmail.com>
References: <1453370345-16688-1-git-send-email-antonynpavlov@gmail.com>
        <1453370345-16688-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51272
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

On Thu, 21 Jan 2016 12:59:03 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

This will need at least a small log that explain that why it is useless.
This board only have this one serial, so replacing the default of 0
with 0 does nothing usefull.

Alban

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> index 003015a..a6108f8 100644
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
