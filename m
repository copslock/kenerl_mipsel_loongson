Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 11:51:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22063 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008633AbbC0KvtbMQ7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2015 11:51:49 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 72DC66D640CD2;
        Fri, 27 Mar 2015 10:51:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 27 Mar 2015 10:51:44 +0000
Received: from [192.168.154.138] (192.168.154.138) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 27 Mar
 2015 10:51:43 +0000
Message-ID: <5515363F.1050209@imgtec.com>
Date:   Fri, 27 Mar 2015 10:51:43 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <alsa-devel@alsa-project.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/6] ASoC: jz4740: Remove Makefile entry for removed file
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.138]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 04/22/2014 09:46 PM, Lars-Peter Clausen wrote:
> Commit 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
> jz4740-pcm.c file, but neglected to remove the Makefile entries.
> 
> Fixes: 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Reported-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/jz4740/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/jz4740/Makefile b/sound/soc/jz4740/Makefile
> index be873c1..d32c540 100644
> --- a/sound/soc/jz4740/Makefile
> +++ b/sound/soc/jz4740/Makefile
> @@ -1,10 +1,8 @@
>  #
>  # Jz4740 Platform Support
>  #
> -snd-soc-jz4740-objs := jz4740-pcm.o
>  snd-soc-jz4740-i2s-objs := jz4740-i2s.o
>  
> -obj-$(CONFIG_SND_JZ4740_SOC) += snd-soc-jz4740.o
>  obj-$(CONFIG_SND_JZ4740_SOC_I2S) += snd-soc-jz4740-i2s.o
>  
>  # Jz4740 Machine Support
> 
Hi,

This patch (eebdec044e82) is present in 3.15-rc1 but the build failure
that was introduced by 0406a40a0 ("ASoC: jz4740: Use the generic
dmaengine PCM driver") is present in 3.14-rc1 so 3.14 is still broken.

Greg, would it be possible to cherry pick eebdec044e82 ("ASoC: jz4740:
Remove Makefile entry for removed file") to 3.14 stable branch? It seems
to apply without conflicts.

Thank you

-- 
markos
