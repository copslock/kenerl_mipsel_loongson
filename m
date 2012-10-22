Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2012 17:57:06 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:37767 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817053Ab2JVP5DbDuLI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2012 17:57:03 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 9E323622D;
        Mon, 22 Oct 2012 09:57:00 -0600 (MDT)
Received: from [IPv6:::1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 74EE0E4622;
        Mon, 22 Oct 2012 09:56:56 -0600 (MDT)
Message-ID: <50856CC6.7010403@wwwdotorg.org>
Date:   Mon, 22 Oct 2012 09:56:54 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
MIME-Version: 1.0
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
CC:     Russell King <linux@arm.linux.org.uk>,
        Mike Turquette <mturquette@linaro.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 10/22/2012 07:02 AM, Mark Brown wrote:
> Rather than requiring platforms to select the generic clock API to make
> it available make the API available as a user selectable option unless the
> user either selects HAVE_CUSTOM_CLK (if they have their own implementation)
> or selects COMMON_CLK (if they depend on the generic implementation).
> 
> All current architectures that HAVE_CLK but don't use the common clock
> framework have selects of HAVE_CUSTOM_CLK added.
> 
> This allows drivers to use the generic API on platforms which have no need
> for the clock API at platform level.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

> @@ -632,6 +634,7 @@ config ARCH_TEGRA
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_GPIO
>  	select HAVE_CLK
> +	select HAVE_CUSTOM_CLK
>  	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select SPARSE_IRQ

Since v3.7-rc1, Tegra uses common clock, so I don't think the change
above is right is it?
