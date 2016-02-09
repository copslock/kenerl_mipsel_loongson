Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 22:53:08 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:24170 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012167AbcBIVxG7KeyL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Feb 2016 22:53:06 +0100
Received: from tock (unknown [80.171.101.200])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 89D83A621A;
        Tue,  9 Feb 2016 22:50:42 +0100 (CET)
Date:   Tue, 9 Feb 2016 22:52:54 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org
Subject: Re: [RFC v5 02/15] dt-bindings: clock: qca,ath79-pll: fix
 copy-paste typos
Message-ID: <20160209225254.1a03c2b1@tock>
In-Reply-To: <1455005641-7079-3-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
        <1455005641-7079-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51928
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

On Tue,  9 Feb 2016 11:13:48 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/clock/qca,ath79-pll.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
> index e0fc2c1..ae99f22 100644
> --- a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
> +++ b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
> @@ -3,7 +3,7 @@ Binding for Qualcomm Atheros AR7xxx/AR9XXX PLL controller
>  The PPL controller provides the 3 main clocks of the SoC: CPU, DDR and AHB.
>  
>  Required Properties:
> -- compatible: has to be "qca,<soctype>-cpu-intc" and one of the following
> +- compatible: has to be "qca,<soctype>-pll" and one of the following
>    fallbacks:
>    - "qca,ar7100-pll"
>    - "qca,ar7240-pll"
> @@ -21,7 +21,7 @@ Optional properties:
>  
>  Example:
>  
> -	memory-controller@18050000 {
> +	pll-controller@18050000 {
>  		compatible = "qca,ar9132-ppl", "qca,ar9130-pll";
>  		reg = <0x18050000 0x20>;
>  

Acked-by: Alban Bedel <albeu@free.fr>

Alban
