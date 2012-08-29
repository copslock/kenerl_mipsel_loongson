Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2012 23:49:03 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:53311 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903257Ab2H2Vsz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2012 23:48:55 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 403F0625C;
        Wed, 29 Aug 2012 15:56:15 -0600 (MDT)
Received: from springbank2.nvidia.com (unknown [38.96.16.75])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 0CA4FE40E5;
        Wed, 29 Aug 2012 15:48:48 -0600 (MDT)
Message-ID: <503E8E6E.1010101@wwwdotorg.org>
Date:   Wed, 29 Aug 2012 14:49:34 -0700
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@arm.linux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34376
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

On 08/28/12 13:35, Mark Brown wrote:
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

> @@ -674,6 +676,7 @@ config ARCH_TEGRA
>   	select GENERIC_CLOCKEVENTS
>   	select GENERIC_GPIO
>   	select HAVE_CLK
> +	select HAVE_CUSTOM_CLK

For 3.7, Tegra will switch to the common clock framework. I think this 
patch would then disable that. How should we resolve this - rebase the 
Tegra common-clk tree on top of any branch containing this patch in 
order to remove that select statement?
