Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2017 00:12:18 +0200 (CEST)
Received: from 5pmail.ess.barracuda.com ([64.235.154.203]:50800 "EHLO
        5pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdJYWMJVMF2v convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Oct 2017 00:12:09 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 25 Oct 2017 22:11:55 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Wed, 25 Oct 2017 15:09:58 -0700
From:   Paul Burton <Paul.Burton@mips.com>
To:     Matt Redfearn <Matt.Redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Matt Redfearn <Matt.Redfearn@mips.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: RE: [PATCH] MIPS: Boston: Fix earlycon baud rate selection
Thread-Topic: [PATCH] MIPS: Boston: Fix earlycon baud rate selection
Thread-Index: AQHTR0vTHE5eQMDsMUudJGZXvzzTsaL1KtyA
Date:   Wed, 25 Oct 2017 22:09:57 +0000
Message-ID: <0F3A6103614E5547AAE5309112E22E9102C5C4FA@MIPSMAIL01.mipstec.com>
References: <1508246879-20580-1-git-send-email-matt.redfearn@mips.com>
In-Reply-To: <1508246879-20580-1-git-send-email-matt.redfearn@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.1.18]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1508969515-321457-32054-41395-1
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186293
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Paul.Burton@mips.com
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

Hi Matt,

On Tuesday, October 17, 2017 at 6:28 AM Matt Redfearn wrote:
> During set up of the early console, the earlycon driver will attempt to
> configure a baud rate, if one is set in the earlycon structure.
> Previously, of_setup_earlycon left this field as 0, ignoring any baud
> rate selected by the DT. Commit 31cb9a8575ca ("earlycon: initialise baud
> field of earlycon device structure") changed this behaviour such that
> any selected baud rate is now set. The earlycon driver must deduce the
> divisor from the configured uartclk, which of_setup_earlycon sets to
> BASE_BAUD. MIPS generic kernels do not set BASE_BAUD (there is no
> practical way to set this generically for all supported platforms), so
> when the early console is configured an incorrect divisor is calculated
> for the selected baud rate, and garbage is printed to the console during
> boot.
> 
> Fix this by removing the configured baud rate from the device tree.
> This causes the early console to inherit the baud rate settings from the
> bootloader. By the time the real console is probed, the clock drivers
> necessary to calculate the divisor are enabled and the kernel can
> correctly configure the baud rate.

Sadly I think this breaks the proper console - my current understanding
is that we end up with it set to 9600 baud due to the defaults in
serial8250_console_setup(). So with your patch I see correct output from
the early console, then nothing when the proper console registers until
my userland starts a getty on ttyS0 which reconfigures it to 115200 baud.

Thanks,
    Paul

> Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device
> structure")
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> 
> ---
> 
>  arch/mips/boot/dts/img/boston.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/img/boston.dts
> b/arch/mips/boot/dts/img/boston.dts
> index 53bfa29a7093..179691aae7d7 100644
> --- a/arch/mips/boot/dts/img/boston.dts
> +++ b/arch/mips/boot/dts/img/boston.dts
> @@ -11,7 +11,7 @@
>  	compatible = "img,boston";
> 
>  	chosen {
> -		stdout-path = "uart0:115200";
> +		stdout-path = "uart0";
>  	};
> 
>  	aliases {
> --
> 2.7.4
