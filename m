Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 12:22:01 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:48069 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007218AbbBZLV7UUYXG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 12:21:59 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 49D2E1538A; Thu, 26 Feb 2015 11:21:54 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: asm: elf: Set O32 default FPU flags
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org>
        <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com>
Date:   Thu, 26 Feb 2015 11:21:54 +0000
In-Reply-To: <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com>
        (Markos Chandras's message of "Thu, 26 Feb 2015 11:11:30 +0000")
Message-ID: <yw1xwq346hpp.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45997
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

> Set good default FPU flags (FR0) for O32 binaries similar to what the
> kernel does for the N64/N32 ones. This also fixes a regression
> introduced in commit 46490b572544 ("MIPS: kernel: elf: Improve the
> overall ABI and FPU mode checks") when MIPS_O32_FP64_SUPPORT is
> disabled. In that case, the mips_set_personality_fp() did not set the
> FPU mode at all because it assumed that the FPU mode was already set
> properly. That led to O32 userland problems.
>
> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Reported-by: Mans Rullgard <mans@mansr.com>
> Fixes: 46490b572544 ("MIPS: kernel: elf: Improve the overall ABI and FPU mode checks")
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Tested-by: Mans Rullgard <mans@mansr.com>

> ---
>  arch/mips/include/asm/elf.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
> index 535f196ffe02..694925a26924 100644
> --- a/arch/mips/include/asm/elf.h
> +++ b/arch/mips/include/asm/elf.h
> @@ -294,6 +294,9 @@ do {									\
>  	if (personality(current->personality) != PER_LINUX)		\
>  		set_personality(PER_LINUX);				\
>  									\
> +	clear_thread_flag(TIF_HYBRID_FPREGS);				\
> +	set_thread_flag(TIF_32BIT_FPREGS);				\
> +									\
>  	mips_set_personality_fp(state);					\
>  									\
>  	current->thread.abi = &mips_abi;				\
> @@ -319,6 +322,8 @@ do {									\
>  	do {								\
>  		set_thread_flag(TIF_32BIT_REGS);			\
>  		set_thread_flag(TIF_32BIT_ADDR);			\
> +		clear_thread_flag(TIF_HYBRID_FPREGS);			\
> +		set_thread_flag(TIF_32BIT_FPREGS);			\
>  									\
>  		mips_set_personality_fp(state);				\
>  									\
> -- 
> 2.3.0
>

-- 
Måns Rullgård
mans@mansr.com
