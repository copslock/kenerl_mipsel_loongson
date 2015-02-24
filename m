Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 14:17:41 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:42240 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007119AbbBXNRjREHdC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 14:17:39 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id D1F1E1538A; Tue, 24 Feb 2015 13:17:33 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v3] MIPS: kernel: elf: Improve the overall ABI and FPU mode checks
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
        <1422893593-1291-1-git-send-email-markos.chandras@imgtec.com>
Date:   Tue, 24 Feb 2015 13:17:33 +0000
In-Reply-To: <1422893593-1291-1-git-send-email-markos.chandras@imgtec.com>
        (Markos Chandras's message of "Mon, 2 Feb 2015 16:13:13 +0000")
Message-ID: <yw1xwq3778k2.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Markos Chandras <markos.chandras@imgtec.com> writes:

> The previous implementation did not cover all possible FPU combinations
> and it silently allowed ABI incompatible objects to be loaded with the
> wrong ABI. For example, the previous logic would set the FP_64 ABI as
> the matching ABI for an FP_XX object combined with an FP_64A object.
> This was wrong, and the matching ABI should have been FP_64A.
> The previous logic is now replaced with a new one which determines
> the appropriate FPU mode to be used rather than the FP ABI. This has
> the advantage that the entire logic is much simpler since it is the FPU
> mode we are interested in rather than the FP ABI resulting to code
> simplifications.
>
> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/asm/elf.h |  10 +-
>  arch/mips/kernel/elf.c      | 303 +++++++++++++++++++++++++++-----------------
>  2 files changed, 194 insertions(+), 119 deletions(-)

This patch (well, the variant that made it into 4.0-rc1) breaks
MIPS_ABI_FP_DOUBLE (the gcc default) apps on MIPS32.

> +void mips_set_personality_fp(struct arch_elf_state *state)
> +{
> +	/*
> +	 * This function is only ever called for O32 ELFs so we should
> +	 * not be worried about N32/N64 binaries.
> +	 */
>
> -	case MIPS_ABI_FP_XX:
> -	case MIPS_ABI_FP_ANY:
> -		if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> -			set_thread_flag(TIF_32BIT_FPREGS);
> -		else
> -			clear_thread_flag(TIF_32BIT_FPREGS);
> +	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
> +		return;

The problem is here.  In a 32-bit configuration, MIPS_O32_FP64_SUPPORT
is always disabled, so the FP mode doesn't get set.  Simply deleting
those two lines makes things work again, but that's probably not the
right fix.

> -		clear_thread_flag(TIF_HYBRID_FPREGS);
> +	switch (state->overall_fp_mode) {
> +	case FP_FRE:
> +		set_thread_fp_mode(1, 0);
> +		break;
> +	case FP_FR0:
> +		set_thread_fp_mode(0, 1);
> +		break;
> +	case FP_FR1:
> +		set_thread_fp_mode(0, 0);
>  		break;
> -
>  	default:
> -	case FP_ERROR:
>  		BUG();
>  	}
>  }
> -- 
> 2.2.2
>

-- 
Måns Rullgård
mans@mansr.com
