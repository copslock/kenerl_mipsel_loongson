Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 00:35:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56870 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992547AbcGDWaxa8eLl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 00:30:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 22145726FF5D1;
        Mon,  4 Jul 2016 23:30:38 +0100 (IST)
Received: from [10.20.78.24] (10.20.78.24) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 4 Jul 2016
 23:30:41 +0100
Date:   Mon, 4 Jul 2016 23:30:23 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <adobriyan@gmail.com>, <john.stultz@linaro.org>,
        <mguzik@redhat.com>, <athorlton@sgi.com>, <mhocko@suse.com>,
        <ebiederm@xmission.com>, <gorcunov@openvz.org>, <luto@kernel.org>,
        <cl@linux.com>, <serge.hallyn@ubuntu.com>, <keescook@chromium.org>,
        <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        <f.fainelli@gmail.com>, <mingo@kernel.org>,
        <alex.smith@imgtec.com>, <markos.chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <david.daney@cavium.com>, <zhaoxiu.zeng@gmail.com>,
        <chenhc@lemote.com>, <Zubair.Kakakhel@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] mips: Add MXU context switching support
In-Reply-To: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
Message-ID: <alpine.DEB.2.00.1607042317480.4076@tp.orcam.me.uk>
References: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.24]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Sat, 25 Jun 2016, PrasannaKumar Muralidharan wrote:

> diff --git a/arch/mips/include/asm/mxu.h b/arch/mips/include/asm/mxu.h
> new file mode 100644
> index 0000000..cf77cbd
> --- /dev/null
> +++ b/arch/mips/include/asm/mxu.h
> @@ -0,0 +1,157 @@
> +/*
> + * Copyright (C) Ingenic Semiconductor
> + * File taken from Ingenic Semiconductor's linux repo available in github
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#ifndef _ASM_MXU_H
> +#define _ASM_MXU_H
> +
> +#include <asm/cpu.h>
> +#include <asm/cpu-features.h>
> +#include <asm/hazards.h>
> +#include <asm/mipsregs.h>
> +
> +static inline void __enable_mxu(void)
> +{
> +	unsigned int register val asm("t0");
> +	val = 3;
> +	asm volatile(".word	0x7008042f\n\t"::"r"(val));

 Can you please document your manually generated machine code, i.e. what 
instruction 0x7008042f actually is?

 Also our convention has been to separate asm operands with spaces, and 
there's no need for a new line or a tab character at the end of an 
inline as GCC will add these automatically as needed, i.e.:

	asm volatile(".word	0x7008042f" : : "r" (val));

Likewise throughout.

> +static inline void __save_mxu(void *tsk_void)
> +{
> +	struct task_struct *tsk = tsk_void;
> +
> +	register unsigned int reg_val asm("t0");
> +
> +	asm volatile(".word	0x7008042e\n\t");
> +	tsk->thread.mxu.xr[0] = reg_val;
> +	asm volatile(".word	0x7008006e\n\t");
> +	tsk->thread.mxu.xr[1] = reg_val;
> +	asm volatile(".word	0x700800ae\n\t");
> +	tsk->thread.mxu.xr[2] = reg_val;
> +	asm volatile(".word	0x700800ee\n\t");
> +	tsk->thread.mxu.xr[3] = reg_val;
> +	asm volatile(".word	0x7008012e\n\t");
> +	tsk->thread.mxu.xr[4] = reg_val;
> +	asm volatile(".word	0x7008016e\n\t");
> +	tsk->thread.mxu.xr[5] = reg_val;
> +	asm volatile(".word	0x700801ae\n\t");
> +	tsk->thread.mxu.xr[6] = reg_val;
> +	asm volatile(".word	0x700801ee\n\t");
> +	tsk->thread.mxu.xr[7] = reg_val;
> +	asm volatile(".word	0x7008022e\n\t");
> +	tsk->thread.mxu.xr[8] = reg_val;
> +	asm volatile(".word	0x7008026e\n\t");
> +	tsk->thread.mxu.xr[9] = reg_val;
> +	asm volatile(".word	0x700802ae\n\t");
> +	tsk->thread.mxu.xr[10] = reg_val;
> +	asm volatile(".word	0x700802ee\n\t");
> +	tsk->thread.mxu.xr[11] = reg_val;
> +	asm volatile(".word	0x7008032e\n\t");
> +	tsk->thread.mxu.xr[12] = reg_val;
> +	asm volatile(".word	0x7008036e\n\t");
> +	tsk->thread.mxu.xr[13] = reg_val;
> +	asm volatile(".word	0x700803ae\n\t");
> +	tsk->thread.mxu.xr[14] = reg_val;
> +	asm volatile(".word	0x700803ee\n\t");
> +	tsk->thread.mxu.xr[15] = reg_val;
> +}

 Not using an output operand with asms here?

  Maciej
