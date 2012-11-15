Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 19:09:58 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:42025 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825919Ab2KOSJxxbSyz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2012 19:09:53 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 59ABB9E23B;
        Thu, 15 Nov 2012 11:11:08 -0700 (MST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 4EAA6E40EF;
        Thu, 15 Nov 2012 11:09:50 -0700 (MST)
Message-ID: <50A52FEC.4080409@wwwdotorg.org>
Date:   Thu, 15 Nov 2012 11:09:48 -0700
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        Stephen Warren <swarren@nvidia.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
References: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com> <1352980284-2819-1-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1352980284-2819-1-git-send-email-grant.likely@secretlab.ca>
X-Enigmail-Version: 1.4.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 35014
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

On 11/15/2012 04:51 AM, Grant Likely wrote:
> Grant Likely wrote:
>> Or how about: I could pick up the patch with only the MIPS hunk and
>> every other user can be fixed up independently to use the new rule.
> 
> Here's a trial patch to fix up ARM. Does this look correct? This patch
> depends on the generic dtb build rule already being applied.

I think the patch looks OK technically, except for one minor comment below.

One issue with this patch is that it moves *.dts from arch/arm/boot to
arch/arm/boot/dts, which means everyone has to adjust their scripts/...
that package/install/... the kernel. I guess it's an easy change for
people to make, but could easily catch people unawares if they do
incremental builds so that arch/arm/boot/*.dtb still exists but is stale.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f37cf9f..2aef042 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -104,4 +104,8 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
>  	wm8505-ref.dtb \
>  	wm8650-mid.dtb
>  
> +targets += dtbs

Doesn't that make the "dtbs" target always run by default? Perhaps
that's reasonable though, and doesn't actually affect anything since the
make command for this directory always specifies an explicit target?

Or, was that meant to be the following that got removed from ../Makefile?

targets += $(dtb-y)

>  endif
> +
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +clean-files := *.dtb
