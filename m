Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 13:28:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20864 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009238AbbAPM2bALfZY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 13:28:31 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A0B0C52B77BCF
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 12:28:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 12:28:24 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 16 Jan 2015 12:28:24 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <Paul.Burton@imgtec.com>
Subject: RE: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI
 and FPU mode checks
Thread-Topic: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall
 ABI and FPU mode checks
Thread-Index: AQHQMXrA9oeMJlZFEEijQwuHHAdWD5zCpU1Q
Date:   Fri, 16 Jan 2015 12:28:23 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FA8886@LEMAIL01.le.imgtec.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.116]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

> The previous implementation did not cover all possible FPU combinations
> and it silently allowed ABI incompatible objects to be loaded with the
> wrong ABI. For example, the previous logic would set the FP_64 ABI as
> the matching ABI for an FP_XX object combined with an FP_64A object.
> This was wrong, and the matching ABI should have been FP_64A.
> The previous logic is now replaced with a new one which determines the
> appropriate FPU mode to be used rather than the FP ABI. This has the
> advantage that the entire logic is much simpler since it is the FPU mode
> we are interested in rather than the FP ABI resulting to code
> simplifications.
> 

For the record this code has been tested against the GLIBC implementation
.MIPS.abiflags dynamic linker logic and a comprehensive ABI compatibility
testsuite posted here:

http://sourceware.org/ml/libc-alpha/2014-12/msg00852.html

> +	/* Lets see if this is an O32 ELF */
> +	if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
> +		/* FR = 1 for N32 */
> +		if (ehdr32->e_flags & EF_MIPS_ABI2)
> +			state->overall_fp_mode = FP_FR1;
> +		else
> +			/* Set a good default FPU mode for O32*/

Nit: spacing at the end of the comment.

>  	/* If the EF_MIPS_FP64 flag was set, return MIPS_ABI_FP_64 */

Should say return MIPS_ABI_FP_OLD_64 in the comment.

>  	if (ehdr->e_flags & EF_MIPS_FP64)
> -		return MIPS_ABI_FP_64;
> +		return MIPS_ABI_FP_OLD_64;
> 

A couple of suggestions for rewording the mode selection comments:

> +	 * - We want FR_FRE if FR=1 and FR=0 are both false. This means
> +	 *   that we don't have a single matching FR mode to satisfy
> +	 *   the requirements so our only solution is to use the emulated
> +	 *   mode

We want FR_FRE if FRE=1 is true but both FR=1 and FR=0 are false.
This means that we have a combination of program and interpreter
that inherently require the hybrid FP mode.

> +	 * - If FR1 and FRDEFAULT is true, that means we hit the any-abi or
> +	 *   fpxx case. This is because, in any-ABI (or no-ABI) we have no
> FPU
> +	 *   instructions so we don't care about the mode. We will simply
> use
> +	 *   the one preferred by the hardware. In fpxx case, that ABI can
> +	 *   handle both FR=1 and FR=0, so, again, we simply choose the one
> +	 *   preferred by the hardware. Next, if we only use single-
> precision
> +	 *   FPU instructions, and the default ABI FPU mode is not good
> +	 *   (ie single + any ABI combination), we set again the FPU mode
> to the
> +	 *   one is preferred by the hardware.

Next, if we know that the code will only use single-precision instructions,
shown by single being true but frdefault being false, then we again set
the FPU mode to the one that is preferred by the hardware.

> +	 * - We want FP_FR1 if that's the only matching mode and the
> default one
> +	 *   is not good.
> +	 * - Return with -ELIBADD if we can't find a matching FPU mode.
> +	 */
> +	if (prog_req.fre && !prog_req.frdefault && !prog_req.fr1)
> +		state->overall_fp_mode = FP_FRE;
> +	else if ((prog_req.fr1 && prog_req.frdefault) ||
> +		 (prog_req.single && !prog_req.frdefault))
> +		/* Make sure 64-bit MIPS III/IV will not pick FR1 */

This is 64-bit MIPS III/IV and MIPS64(R1)

> +		state->overall_fp_mode = ((current_cpu_data.fpu_id &
> MIPS_FPIR_F64) &&
> +					  (cpu_has_mips_r2 || cpu_has_mips_r6)) ?
> +					  FP_FR1 : FP_FR0;
> +	else if (prog_req.fr1)
> +		state->overall_fp_mode = FP_FR1;
> +	else  if (!prog_req.fre && !prog_req.frdefault &&
> +		  !prog_req.fr1 && !prog_req.single && !prog_req.soft)
>  		return -ELIBBAD;
> -	}
> 
>  	return 0;
>  }

Thanks,
Matthew
