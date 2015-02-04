Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 21:56:55 +0100 (CET)
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:54259 "EHLO
        cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012471AbbBDU4wXkpzT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 21:56:52 +0100
Received: from cpsps-ews04.kpnxchange.com ([10.94.84.171]) by cpsmtpb-ews06.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 21:56:47 +0100
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 21:56:46 +0100
Received: from [192.168.10.108] ([77.173.140.92]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 21:56:47 +0100
Message-ID: <1423083406.27378.5.camel@x220>
Subject: Re: [PATCH_V2 33/34] MIPS: initial MIPS Creator CI20 board support
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, mturquette@linaro.org,
        sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz,
        tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de,
        paul.burton@imgtec.com
Date:   Wed, 04 Feb 2015 21:56:46 +0100
In-Reply-To: <1423063323-19419-34-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
         <1423063323-19419-34-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2015 20:56:47.0110 (UTC) FILETIME=[16E8DA60:01D040BD]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Wed, 2015-02-04 at 15:22 +0000, Zubair Lutfullah Kakakhel wrote:
> From: Paul Burton <paul.burton@imgtec.com>
> 
> Add a device tree for the Ingenic jz4780 based MIPS Creator CI20 board.
> Note that this is unselectable via Kconfig until the jz4780 SoC is made
> selectable in a later commit.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  arch/mips/boot/dts/Makefile      |   1 +
>  arch/mips/boot/dts/ci20.dts      |  21 +++++++
>  arch/mips/configs/ci20_defconfig | 127 +++++++++++++++++++++++++++++++++++++++
>  arch/mips/jz4740/Kconfig         |  10 +++
>  4 files changed, 159 insertions(+)
>  create mode 100644 arch/mips/boot/dts/ci20.dts
>  create mode 100644 arch/mips/configs/ci20_defconfig
>[...]
> diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
> index 4689030..72ac174 100644
> --- a/arch/mips/jz4740/Kconfig
> +++ b/arch/mips/jz4740/Kconfig
> @@ -7,3 +7,13 @@ config JZ4740_QI_LB60
>  	bool "Qi Hardware Ben NanoNote"
>  
>  endchoice
> +
> +choice
> +	prompt "Machine type"
> +	depends on MACH_JZ4780
> +	default JZ4780_CI20
> +
> +config JZ4780_CI20
> +	bool "MIPS Creator CI20"
> +
> +endchoice

This adds a choice with a single entry. What's the point?


Paul Bolle
