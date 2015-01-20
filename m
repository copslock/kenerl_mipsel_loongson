Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 00:32:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50616 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011713AbbATXcf07wE8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 00:32:35 +0100
Date:   Tue, 20 Jan 2015 23:32:35 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 28/70] MIPS: kernel: cpu-probe.c: Add support for
 MIPS R6
In-Reply-To: <1421405389-15512-29-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501202227140.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-29-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45378
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

> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index cc77fdaca0eb..328b61f63430 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -237,6 +237,13 @@ static void set_isa(struct cpuinfo_mips *c, unsigned int isa)
>  		c->isa_level |= MIPS_CPU_ISA_II | MIPS_CPU_ISA_III;
>  		break;
>  
> +	/* R6 incopatible with everything else */
> +	case MIPS_CPU_ISA_M64R6:
> +		c->isa_level |= MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6;
> +	case MIPS_CPU_ISA_M32R6:
> +		c->isa_level |= MIPS_CPU_ISA_M32R6;
> +		/* Break here so we don't add incopatible ISAs */

 Typos here: s/incopatible/incompatible/

> @@ -541,7 +554,7 @@ static void decode_configs(struct cpuinfo_mips *c)
>  	}
>  
>  #ifndef CONFIG_MIPS_CPS
> -	if (cpu_has_mips_r2) {
> +	if (cpu_has_mips_r2 || cpu_has_mips_r6) {

 Hmm, maybe define a macro:

#define cpu_has_mips_r2_r6 (cpu_has_mips_r2 | cpu_has_mips_r6)

(bitwise OR used to follow our preexisting convention, it often produces 
shorter and faster code)?  To have it centrally controlled and to shorten 
source code.  We have precedents already, see the `Shortcuts' section in 
<asm/cpu-features.h>.

> @@ -1351,7 +1364,8 @@ void cpu_probe(void)
>  		c->fpu_id = cpu_get_fpu_id();
>  
>  		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
> -				    MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)) {
> +				    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R1 |
> +				    MIPS_CPU_ISA_M64R2 | MIPS_CPU_ISA_M64R6)) {

 Likewise, this could have used `cpu_has_mips_r' as it stands; with the
R6 update it can be `cpu_has_mips_r1_r2_r6'.

 This uses `c->isa_level' rather than `cpu_data[0].isa_level' that 
`cpu_has_*' macros use, but that's not a problem as we do not support 
mixed ISA levels anyway and standardising on these macros makes 
maintenance easier, e.g. if we decided to actually use 
`current_cpu_data.isa_level' or suchlike in these macros instead.

 As a side note I can see that as from a96102be, ISA flags are inclusive, 
so the macros in <asm/cpu-features.h> can and I think should be rearranged 
and simplified.  E.g. (indentation adjusted, we can afford it now):

#define cpu_has_mips_2_3_4_5	cpu_has_mips_2
#define cpu_has_mips_3_4_5	cpu_has_mips_3

#define cpu_has_mips_2_3_4_5_r	cpu_has_mips_2

#define cpu_has_mips32		cpu_has_mips32r1
#define cpu_has_mips64		cpu_has_mips64r1

#define cpu_has_mips_r		cpu_has_mips32r1

etc.  With R6 in the picture I think the `*_r' macros need to go, to avoid 
confusion; I suggest renaming them to `*_r1_r2' to follow the existing 
convention.  Then the above macros will look like:

#define cpu_has_mips_2_3_4_5		cpu_has_mips_2
#define cpu_has_mips_3_4_5		cpu_has_mips_3

#define cpu_has_mips_2_3_4_5_r1_r2	cpu_has_mips_2

#define cpu_has_mips32			(cpu_has_mips32r1 | cpu_has_mips32r6)
#define cpu_has_mips64			(cpu_has_mips64r1 | cpu_has_mips64r6)

#define cpu_has_mips_r1_r2		cpu_has_mips32r1

etc., plus new ones:

#define cpu_has_mips_r1_r2_r6		(cpu_has_mips32r1 | cpu_has_mips32r6)
#define cpu_has_mips_r2_r6		(cpu_has_mips32r2 | cpu_has_mips32r6)
#define cpu_has_mips_r6			cpu_has_mips32r6

etc.

 Thoughts?

  Maciej
