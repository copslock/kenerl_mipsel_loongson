Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 13:40:19 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41305 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014312AbbBCMkRWOihI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 13:40:17 +0100
Date:   Tue, 3 Feb 2015 12:40:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI
 and FPU mode checks
In-Reply-To: <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502031223120.22715@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index c92b15df6893..2ac33d2375ca 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -11,29 +11,102 @@
>  #include <linux/elf.h>
>  #include <linux/sched.h>
>  
> +/* FPU modes */
>  enum {
> -	FP_ERROR = -1,
> -	FP_DOUBLE_64A = -2,
> +	FP_FRE,
> +	FP_FR0,
> +	FP_FR1,
>  };
>  
> +/**
> + * struct mode_req - ABI FPU mode requirements
> + * @single:	The program being loaded needs an FPU but it will only issue
> + *		single precision instructions meaning that it can execute in
> + *		either FR0 or FR1.
> + * @soft:	The soft(-float) requirement means that the program being
> + *		loaded needs has no FPU dependency at all (i.e. it has no
> + *		FPU instructions).
> + * @fr1:	The program being loaded depends on FPU being in FR=1 mode.
> + * @frdefault:	The program being loaded depends on the default FPU mode.
> + *		That is FR0 for O32 and FR1 for N32/N64.
> + * @fre:	The program being loaded depends on FPU with FRE=1. This mode is
> + *		a bridge which uses FR=1 whilst still being able to maintain
> + *		full compatibility with pre-existing code using the O32 FP32
> + *		ABI.
> + *
> + * More information about the FP ABIs can be found here:
> + *
> + * https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking#10.4.1._Basic_mode_set-up
> + *
> + */
> +
> +struct mode_req {
> +	bool single;
> +	bool soft;
> +	bool fr1;
> +	bool frdefault;
> +	bool fre;
> +};
> +
> +static const struct mode_req fpu_reqs[] = {
> +	[MIPS_ABI_FP_ANY]    = { true,  true,  true,  true,  true  },
> +	[MIPS_ABI_FP_DOUBLE] = { false, false, false, true,  true  },
> +	[MIPS_ABI_FP_SINGLE] = { true,  false, false, false, false },
> +	[MIPS_ABI_FP_SOFT]   = { false, true,  false, false, false },
> +	[MIPS_ABI_FP_OLD_64] = { false, false, false, false, false },
> +	[MIPS_ABI_FP_XX]     = { false, false, true,  true,  true  },
> +	[MIPS_ABI_FP_64]     = { false, false, true,  false, false },
> +	[MIPS_ABI_FP_64A]    = { false, false, true,  false, true  }
> +};
> +
> +/*
> + * Mode requirements when .MIPS.abiflags is not present in the ELF.
> + * Not present means that everything is acceptable except FR1.
> + */
> +static struct mode_req none_req = { true, true, false, true, true };
> +
>  int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
>  		     bool is_interp, struct arch_elf_state *state)
>  {
> -	struct elfhdr *ehdr = _ehdr;
> -	struct elf_phdr *phdr = _phdr;
> +	struct elf32_hdr *ehdr32 = _ehdr;
> +	struct elf32_phdr *phdr32 = _phdr;
> +	struct elf64_phdr *phdr64 = _phdr;

 Minor nit, I won't be picking on it if you have a strong feeling against, 
but I think it would be slightly cleaner if you had used unions here -- no 
risk of people picking bad habits that would hurt if any of these 
structures were written, causing aliasing issues.

 So e.g.:

	union {
		struct elf32_hdr e32;
		struct elf64_hdr e64;
	} *ehdr = _ehdr;
	union {
		struct elf32_phdr p32;
		struct elf64_phdr p64;
	} *phdr = _phdr;

and then:

> +	/* Lets see if this is an O32 ELF */
> +	if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
> +		/* FR = 1 for N32 */
> +		if (ehdr32->e_flags & EF_MIPS_ABI2)
> +			state->overall_fp_mode = FP_FR1;
> +		else
> +			/* Set a good default FPU mode for O32*/
> +			state->overall_fp_mode = cpu_has_mips_r6 ?
> +				FP_FRE : FP_FR0;
> +
> +		if (phdr32->p_type != PT_MIPS_ABIFLAGS)
> +			return 0;
> +
> +		if (phdr32->p_filesz < sizeof(abiflags))
> +			return -EINVAL;
> +
> +		ret = kernel_read(elf, phdr32->p_offset,
> +				  (char *)&abiflags,
> +				  sizeof(abiflags));

	/* Lets see if this is an O32 ELF */
	if (ehdr->e32.e_ident[EI_CLASS] == ELFCLASS32) {
		/* FR = 1 for N32 */
		if (ehdr->e32.e_flags & EF_MIPS_ABI2)
			state->overall_fp_mode = FP_FR1;
		else
			/* Set a good default FPU mode for O32*/
			state->overall_fp_mode = cpu_has_mips_r6 ?
				FP_FRE : FP_FR0;

		if (phdr->p32.p_type != PT_MIPS_ABIFLAGS)
			return 0;

		if (phdr->p32.p_filesz < sizeof(abiflags))
			return -EINVAL;

		ret = kernel_read(elf, phdr->p32.p_offset,
				  (char *)&abiflags,
				  sizeof(abiflags));

-- and so on...  As you can see the result isn't even much different in 
terms of readability or source code size, while avoiding any possible 
aliasing issues.

  Maciej
