Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 08:22:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23124 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006837AbbCCHWb57SRs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 08:22:31 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A3D8CEDED0074;
        Tue,  3 Mar 2015 07:22:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 3 Mar 2015 07:22:26 +0000
Received: from localhost (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 3 Mar
 2015 07:22:25 +0000
Date:   Tue, 3 Mar 2015 07:22:25 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH] MIPS: Call mips_set_personality_fp() in all O32 cases
Message-ID: <20150303072225.GA8339@mchandras-linux.le.imgtec.org>
References: <1425347348-12334-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1425347348-12334-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

On Tue, Mar 03, 2015 at 09:49:08AM +0800, Huacai Chen wrote:
> Commit 46490b572544f (MIPS: kernel: elf: Improve the overall ABI and
> FPU mode checks) assumes mips_set_personality_fp() is only needed in
> CONFIG_MIPS_O32_FP64_SUPPORT case. However, this assumption is wrong,
> because O32 binaries always need the correct thread flags to set
> FR/FRE, whether CONFIG_MIPS_O32_FP64_SUPPORT is configured or not.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/kernel/elf.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index d2c09f6..cec5bc3 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -245,7 +245,7 @@ void mips_set_personality_fp(struct arch_elf_state *state)
>  	 * not be worried about N32/N64 binaries.
>  	 */
>  
> -	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> +	if (!config_enabled(CONFIG_32BIT) && !config_enabled(CONFIG_MIPS32_O32))
>  		return;
>  
>  	switch (state->overall_fp_mode) {
> -- 
> 1.7.7.3
> 
> 
> 
> 
Hi,

I have already posted a patch for this problem. Could you try that instead?

http://patchwork.linux-mips.org/patch/9344/

-- 
markos
