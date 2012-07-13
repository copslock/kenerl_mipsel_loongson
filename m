Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 10:30:56 +0200 (CEST)
Received: from service88.mimecast.com ([195.130.217.12]:35334 "EHLO
        service88.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903258Ab2GMIat convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 10:30:49 +0200
Received: from emea-cam-gw1.Emea.Arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.21]) (Using TLS) by service88.mimecast.com; Fri, 13 Jul 2012
 09:30:47 +0100
Received: from [10.1.215.139] (10.1.2.13) by emea-cam-gw1.Emea.Arm.com
 (10.1.248.203) with Microsoft SMTP Server id 8.2.254.0; Fri, 13 Jul 2012
 09:31:49 +0100
Message-ID: <4FFFDCB2.3030700@arm.com>
Date:   Fri, 13 Jul 2012 09:30:42 +0100
From:   viresh kumar <viresh.kumar2@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Viresh Kumar <viresh.kumar@st.com>,
        Russell King <linux@arm.linux.org.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH] MIPS: BCM63XX: select HAVE_CLK
References: <1342166315-17765-1-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1342166315-17765-1-git-send-email-jonas.gorski@gmail.com>
X-MC-Unique: 112071309304701002
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
X-archive-position: 33901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar2@arm.com
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

On 13/07/12 08:58, Jonas Gorski wrote:
> BCM63XX implements the clk interface, but does not advertise it.
>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>
> This fixes a build failure in linux-next caused by
> 5afae362dc79cb8b6b3965422d13d118c63d4ee4 ("clk: Add non CONFIG_HAVE_CLK
> routines"):
>
>   CC      arch/mips/bcm63xx/clk.o
> arch/mips/bcm63xx/clk.c:285:5: error: redefinition of 'clk_enable'
> include/linux/clk.h:294:19: note: previous definition of 'clk_enable' was here
>
> and so on (I think you have already seen one of these).
>
> @Andrew: This patch should apply cleanly to any tree, so maybe you
> could add it to your patch series in front of the mentioned
> patch, to keep bisectability for bcm63xx.
>
> @Ralf: I hope it is okay for you that this goes through a different
> tree.
>
>  arch/mips/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 09ab87e..80d9199 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -122,6 +122,7 @@ config BCM63XX
>       select SYS_HAS_EARLY_PRINTK
>       select SWAP_IO_SPACE
>       select ARCH_REQUIRE_GPIOLIB
> +     select HAVE_CLK
>       help
>        Support for BCM63XX based boards

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

--
Viresh



-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
