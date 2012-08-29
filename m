Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2012 08:01:20 +0200 (CEST)
Received: from cassarossa.samfundet.no ([129.241.93.19]:32952 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901346Ab2H2F4y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2012 07:56:54 +0200
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.72)
        (envelope-from <egtvedt@samfundet.no>)
        id 1T6bGL-00067C-Sd; Wed, 29 Aug 2012 07:56:25 +0200
Date:   Wed, 29 Aug 2012 07:56:25 +0200
From:   Hans-Christian Egtvedt <egtvedt@samfundet.no>
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@arm.linux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20120829055625.GA17753@samfundet.no>
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 34375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: egtvedt@samfundet.no
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

Around Tue 28 Aug 2012 13:35:04 -0700 or thereabout, Mark Brown wrote:
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
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This depends on having one of the patches I've sent adding a generic
> clkdev.h added merged - Arnd was expecting to merge one of those, there
> was just the lack of clarity about the most practical Kbuild hookup.
> 
>  arch/arm/Kconfig            |   12 ++++++++++++
>  arch/avr32/Kconfig          |    1 +

For the AVR32 related changes

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

<snipp>

-- 
mvh
Hans-Christian Egtvedt
