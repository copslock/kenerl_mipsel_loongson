Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 May 2013 03:29:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46040 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822527Ab3EZB257EocV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 May 2013 03:28:57 +0200
Date:   Sun, 26 May 2013 02:28:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, Steven.Hill@imgtec.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: microMIPS: Refactor mips16 get_frame_info
 support
In-Reply-To: <20130525163216.GA5956@hades>
Message-ID: <alpine.LFD.2.03.1305252349290.18557@linux-mips.org>
References: <20130525163216.GA5956@hades>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36597
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

Hi Tony,

 Thanks for doing this work.  A couple of notes below.  Many are 
preexisting problems, but fiddling with this code is a good opportunity to 
get it right.

On Sun, 26 May 2013, Tony Wu wrote:

> Current get_frame_info implementation works on word boundary, this
> can lead to alignment and endian issues in microMIPS/MIPS16 mode,
> due to:
> 
> 1. MIPS16 instructions can be 16bit or 32bit
> 2. MIPS16 32bit instructions may not be on the word boundary
> 3. MIPS16 instructions are placed in 32-bit memory element, in
>    endian-dependent order.
> 
> Example:
>     insn1 = 16bit => word1, hword[0]
>     insn2 = 32bit => word1, hword[1], word2, hword[0]
>     insn3 = 16bit => word2, hword[1]
> 
>        Big Endian
>             hword[0]     hword[1]      hword[0]     hword[1]
>        +-------------+-------------+-------------+-------------+
>        |    insn1    |    insn2    |    insn2'   |    insn3    |
>        +-------------+-------------+-------------+-------------+
>        31          word1          0 31         word2           0
> 
>        Little Endian
>             hword[1]     hword[0]      hword[1]     hword[0]
>        +-------------+-------------+-------------+-------------+
>        |    insn2    |    insn1    |    insn3    |    insn2'   |
>        +-------------+-------------+-------------+-------------+
>        31          word1          0 31         word2           0
> 
> This patch refactors microMIPS get_frame_info by implementing
> fetch_instruction() to fetch instructions on word boundary, and
> MIPS16_fetch_halfword() to assemble halfwords into 16bit/32bit MIPS16
> instructions for further processing.

 I think you're overcomplicating things a bit.  In the MIPS16 and 
microMIPS modes instructions are simply sequences of 16-bit halfwords 
(unlike the standard MIPS mode where instructions are 32-bit words), each 
of which is stored in memory using the bus endianness.  Then in the MIPS16 
mode instructions are either one or two 16-bit halfwords and in the 
microMIPS mode they are any between one and three 16-bit halfwords (the 
POOL48 major opcode for the latters; we may ignore them until we support 
the 64-bit microMIPS mode).  I think it's easier to see them this way, and 
also likely to process them.

 Also I suggest to avoid referring to the MIPS16 mode except perhaps the 
first sentence, because none of this code actually handles MIPS16 
instructions.  If you want to refer to both MIPS16 and microMIPS 
instruction sets in a generic way, then you may use "compressed ISA mode 
instructions" or suchlike.

 I hope you're not confusing the two instruction sets.

> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index c6a041d..edbe0a8 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -211,124 +211,168 @@ struct mips_frame_info {
>  	int		pc_offset;
>  };
>  
> -#define J_TARGET(pc,target)	\
> -		(((unsigned long)(pc) & 0xf0000000) | ((target) << 2))
> -
>  static inline int is_ra_save_ins(union mips_instruction *ip)
>  {
> -#ifdef CONFIG_CPU_MICROMIPS
> -	union mips_instruction mmi;
> -
> -	/*
> -	 * swsp ra,offset
> -	 * swm16 reglist,offset(sp)
> -	 * swm32 reglist,offset(sp)
> -	 * sw32 ra,offset(sp)
> -	 * jradiussp - NOT SUPPORTED
> -	 *
> -	 * microMIPS is way more fun...
> -	 */
> -	if (mm_insn_16bit(ip->halfword[0])) {
> -		mmi.word = (ip->halfword[0] << 16);
> -		return ((mmi.mm16_r5_format.opcode == mm_swsp16_op &&
> -			 mmi.mm16_r5_format.rt == 31) ||
> -			(mmi.mm16_m_format.opcode == mm_pool16c_op &&
> -			 mmi.mm16_m_format.func == mm_swm16_op));
> -	}
> -	else {
> -		mmi.halfword[0] = ip->halfword[1];
> -		mmi.halfword[1] = ip->halfword[0];
> -		return ((mmi.mm_m_format.opcode == mm_pool32b_op &&
> -			 mmi.mm_m_format.rd > 9 &&
> -			 mmi.mm_m_format.base == 29 &&
> -			 mmi.mm_m_format.func == mm_swm32_func) ||
> -			(mmi.i_format.opcode == mm_sw32_op &&
> -			 mmi.i_format.rs == 29 &&
> -			 mmi.i_format.rt == 31));
> +	if (kernel_uses_mmips) {
> +		/*
> +		 * swsp ra,offset
> +		 * swm16 reglist,offset(sp)
> +		 * swm32 reglist,offset(sp)
> +		 * sw32 ra,offset(sp)
> +		 * jradiussp - NOT SUPPORTED

 The instruction is called JRADDIUSP, however it's irrelevant here as it's 
an SP restore instruction.  I think this reference can be removed.  

> +		 *
> +		 * microMIPS is way more fun...
> +		 */
> +		return ((ip->mm16_r5_format.opcode == mm_swsp16_op &&
> +			 ip->mm16_r5_format.rt == 31) ||
> +			(ip->mm16_m_format.opcode == mm_pool16c_op &&
> +			 ip->mm16_m_format.func == mm_swm16_op) ||
> +			/* 32bit instruction */
> +			(ip->mm_m_format.opcode == mm_pool32b_op &&

 This:

> +			 ip->mm_m_format.rd > 9 &&

 should be:

			 ip->mm_m_format.rd >= 16 &&

I believe -- codes 10-15 are reserved and from the current encoding it's 
clear it's bit #4 that denotes $ra.

> +			 ip->mm_m_format.base == 29 &&
> +			 ip->mm_m_format.func == mm_swm32_func) ||
> +			(ip->i_format.opcode == mm_sw32_op &&

 This should be:

			(ip->mm_i_format.opcode == mm_sw32_op &&

I believe, and consequently this:

> +			 ip->i_format.rs == 29 && ip->i_format.rt == 31));

should be:

			 ip->mm_i_format.rs == 29 &&
			 ip->mm_i_format.rt == 31));

-- note that rs (aka base) and rt are swapped between the standard MIPS 
and the microMIPS instruction format, so the above change is not even 
remotely cosmetical.

> +	} else {
> +		/* sw / sd $ra, offset($sp) */
> +		return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op) &&

 Oversize line here.

> +			ip->i_format.rs == 29 &&
> +			ip->i_format.rt == 31;
>  	}
> -#else
> -	/* sw / sd $ra, offset($sp) */
> -	return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op) &&
> -		ip->i_format.rs == 29 &&
> -		ip->i_format.rt == 31;
> -#endif
>  }
>  
>  static inline int is_jump_ins(union mips_instruction *ip)
>  {
> -#ifdef CONFIG_CPU_MICROMIPS
> -	/*
> -	 * jr16,jrc,jalr16,jalr16
> -	 * jal
> -	 * jalr/jr,jalr.hb/jr.hb,jalrs,jalrs.hb
> -	 * jraddiusp - NOT SUPPORTED
> -	 *
> -	 * microMIPS is kind of more fun...
> -	 */
> -	union mips_instruction mmi;
> -
> -	mmi.word = (ip->halfword[0] << 16);
> -
> -	if ((mmi.mm16_r5_format.opcode == mm_pool16c_op &&
> -	    (mmi.mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op) ||
> -	    ip->j_format.opcode == mm_jal32_op)
> -		return 1;
> -	if (ip->r_format.opcode != mm_pool32a_op ||
> -			ip->r_format.func != mm_pool32axf_op)
> -		return 0;
> -	return (((ip->u_format.uimmediate >> 6) & mm_jalr_op) == mm_jalr_op);
> -#else
> -	if (ip->j_format.opcode == j_op)
> -		return 1;
> -	if (ip->j_format.opcode == jal_op)
> -		return 1;
> -	if (ip->r_format.opcode != spec_op)
> -		return 0;
> -	return ip->r_format.func == jalr_op || ip->r_format.func == jr_op;
> -#endif
> +	if (kernel_uses_mmips) {
> +		/*
> +		 * jr16,jrc,jalr16,jalr16
> +		 * jal
> +		 * jalr/jr,jalr.hb/jr.hb,jalrs,jalrs.hb
> +		 * jraddiusp - NOT SUPPORTED

 I think that JRADDIUSP should really be supported here, GCC is pretty 
keen on using this instruction where possible.

> +		 *
> +		 * microMIPS is kind of more fun...
> +		 */
> +		if ((ip->mm16_r5_format.opcode == mm_pool16c_op &&

 This:

> +		    (ip->mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op))

 should be:

		    (ip->mm16_r5_format.rt & ~0x3) == mm_jr16_op))

I believe (and also mm_jr16_op is wrongly defined as 0x18 instead of 0xc; 
mm_jrc_op, mm_jalr16_op and mm_jalrs16_op are likewise wrong -- all need 
to be right-shifted by one bit).

> +			return 1;
> +
> +		if (ip->j_format.opcode == mm_jal32_op ||

 This:

		    ip->j_format.opcode == mm_jals32_op ||

is missing here.

> +		    ip->j_format.opcode == mm_j32_op)
> +			return 1;
> +
> +		if (ip->r_format.opcode != mm_pool32a_op ||
> +		    ip->r_format.func != mm_pool32axf_op)
> +			return 0;

 I think this:

> +		return (((ip->u_format.uimmediate >> 6) & mm_jalr_op) == mm_jalr_op);

should be fully decoded (and oversize line fixed too):

		return (((ip->u_format.uimmediate >> 6) & ~0x14) == 
			mm_jalr_op);

> +	} else {
> +		if (ip->j_format.opcode == j_op)
> +			return 1;
> +		if (ip->j_format.opcode == jal_op)
> +			return 1;
> +		if (ip->r_format.opcode != spec_op)
> +			return 0;
> +		return ip->r_format.func == jalr_op || ip->r_format.func == jr_op;

 Oversize line here.

> +	}
>  }
>  
>  static inline int is_sp_move_ins(union mips_instruction *ip)
>  {
> -#ifdef CONFIG_CPU_MICROMIPS
> -	/*
> -	 * addiusp -imm
> -	 * addius5 sp,-imm
> -	 * addiu32 sp,sp,-imm
> -	 * jradiussp - NOT SUPPORTED
> -	 *
> -	 * microMIPS is not more fun...
> -	 */
> -	if (mm_insn_16bit(ip->halfword[0])) {
> -		union mips_instruction mmi;
> -
> -		mmi.word = (ip->halfword[0] << 16);
> -		return ((mmi.mm16_r3_format.opcode == mm_pool16d_op &&
> -			 mmi.mm16_r3_format.simmediate && mm_addiusp_func) ||
> -			(mmi.mm16_r5_format.opcode == mm_pool16d_op &&
> -			 mmi.mm16_r5_format.rt == 29));
> +	if (kernel_uses_mmips) {
> +		/*
> +		 * addiusp -imm
> +		 * addius5 sp,-imm
> +		 * addiu32 sp,sp,-imm
> +		 * jradiussp - NOT SUPPORTED

 Again, typo here, but should this instruction should be supported?  It 
can't have a negative immediate argument, it's a function return 
instruction, so I think the reference should be removed.

> +		 *
> +		 * microMIPS is not more fun...
> +		 */
> +		return ((ip->mm16_r3_format.opcode == mm_pool16d_op &&
> +			 ip->mm16_r3_format.simmediate && mm_addiusp_func) ||
> +			(ip->mm16_r5_format.opcode == mm_pool16d_op &&
> +			 ip->mm16_r5_format.rt == 29) ||
> +			/* 32bit instruction */
> +			(ip->mm_i_format.opcode == mm_addiu32_op &&
> +			 ip->mm_i_format.rt == 29 && ip->mm_i_format.rs == 29));
> +	} else {
> +		/* addiu/daddiu sp,sp,-imm */
> +		if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
> +			return 0;
> +		if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
> +			return 1;
>  	}
> -	return (ip->mm_i_format.opcode == mm_addiu32_op &&
> -		 ip->mm_i_format.rt == 29 && ip->mm_i_format.rs == 29);
> -#else
> -	/* addiu/daddiu sp,sp,-imm */
> -	if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
> -		return 0;
> -	if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
> -		return 1;
> -#endif
>  	return 0;
>  }

 I think for readability's sake it would make sense to rewrite these three 
for a consistent return style, i.e. either "if (foo) return 1; if (bar) 
return 1;" etc. or "return foo || bar;" etc., and not a mixture of both.

> +/*
> + * A few fun facts on MIPS16
> + *
> + * 1. MIPS16 instructions are either 16-bit or 32-bit in length
> + * 2. MIPS16 32-bit instruction may not be on word boundary
> + * 3. MIPS16 instructions are placed in 32-bit memory element, in
> + *    endian-dependent order.
> + *
> + * Big Endian
> + *      hword[0]     hword[1]      hword[0]     hword[1]
> + * +-------------+-------------+-------------+-------------+
> + * |    insn1    |    insn2    |    insn2'   |    insn3    |
> + * +-------------+-------------+-------------+-------------+
> + * 31          word1          0 31         word2           0
> + *
> + * Little Endian
> + *      hword[1]     hword[0]      hword[1]     hword[0]
> + * +-------------+-------------+-------------+-------------+
> + * |    insn2    |    insn1    |    insn3    |    insn2'   |
> + * +-------------+-------------+-------------+-------------+
> + * 31          word1         0 31          word2           0
> + *
> + * In MIPS16 mode, MIPS16_fetch_halfword does the followings:
> + *
> + * 1. fetch word from word-aligned address
> + * 2. access the fetched word using halfword (defeat endian issue)
> + * 3. assemble 16/32 bit MIPS16 instruction from halfword(s)
> + */

 So my note at the beginning also applies here.  Please rewrite the 
comment and reshape the figures so they refer to 16-bit halfwords rather 
than 32-bit words for compressed ISA modes.

> +static void MIPS16_fetch_halfword(union mips_instruction **ip,

 Linux doesn't use capital letters in function names, and having my note 
above in mind please make this mmips_fetch_halfword or suchlike.

> +				  unsigned short *this_halfword,
> +				  unsigned short *prev_halfword)
> +{
> +	if (*prev_halfword) {
> +		*this_halfword = *prev_halfword;
> +		*prev_halfword = 0;
> +	} else {
> +		/* advance pointer to next word */
> +		*this_halfword = (*ip)->halfword[0];
> +		*prev_halfword = (*ip)->halfword[1];
> +		*ip += 1;
> +	}
> +}
> +
> +static void fetch_instruction(union mips_instruction **ip,
> +			      union mips_instruction *mi,
> +			      unsigned short *prev_halfword)
> +{
> +	if (kernel_uses_mmips) {
> +		/* fetch the first MIPS16 instruction */
> +		MIPS16_fetch_halfword(ip, &mi->halfword[0], prev_halfword);
> +
> +		/* fetch the second half if it is a 32bit one */
> +		if (mm_insn_16bit(mi->halfword[0]))
> +			mi->halfword[1] = 0;
> +		else
> +			MIPS16_fetch_halfword(ip, &mi->halfword[1], prev_halfword);

 Oversize line here.

> +	} else {
> +		/* do simple assignment for mips32 mode */

 I suggest "standard MIPS mode" or suchlike as we do support MIPS64 
execution as well.  Also I suggest formatting sentences properly, starting 
with a capital letter and ending with a full stop.

> +		*mi = **ip;
> +		*ip += 1;
> +	}
> +}
> +

 As I noted above, I think this is all overcomplicated.  I suggest 
rewriting it such that it operates on ip being an u16 pointer (or maybe a 
union of an u16 and an u32 pointer) and only returning the 
mips_instruction union.  This will make all this shuffling and the use of 
the prev_halfword temporary in the upper frame unnecessary.

> @@ -340,37 +384,37 @@ static int get_frame_info(struct mips_frame_info *info)
>  		max_insns = 128U;	/* unknown function size */
>  	max_insns = min(128U, max_insns);
>  
> -	for (i = 0; i < max_insns; i++, ip++) {
> +	if (kernel_uses_mmips) {
> +		/* align start address to word boundary, lose mode bit. */
> +		ip = (union mips_instruction *)((unsigned long)ip & ~0x3);

 Is it OK to decode possibly half an instruction back here?

 There will be no need to do this with the approach I outlined above, and 
also please use msk_isa16_mode(...) then.

> +				unsigned short tmp;
> +
> +				if (inst.halfword[0] & mm_addiusp_func) {
> +					tmp = (((inst.halfword[0] >> 1) & 0x1ff) << 2);
> +					info->frame_size = -(signed short)(tmp | ((tmp & 0x100) ? 0xfe00 : 0));
> +				} else {
> +					tmp = (inst.halfword[0] >> 1);
> +					info->frame_size = -(signed short)(tmp & 0xf);
> +				}

 The immediate is signed in both cases, you need to take care of this, 
e.g.:

				short tmp;
[...]
					info->frame_size =
						0x8 - ((tmp & 0xf) ^ 0x8);

and please observe the special decoding rules of the ADDIUSP instruction's 
immediate value (the 0, 1, 510 and 511 encoded cases).

 Also oversize lines.

> @@ -390,20 +434,36 @@ static unsigned long get___schedule_addr(void)
>  {
>  	return kallsyms_lookup_name("__schedule");
>  }
> -#else
> +#else /* CONFIG_KALLSYMS */
>  static unsigned long get___schedule_addr(void)
>  {
>  	union mips_instruction *ip = (void *)schedule;
> +	union mips_instruction inst;
> +	union mips_instruction *max_ip;
>  	int max_insns = 8;
> -	int i;
> +	unsigned short halfword = 0;
>  
> -	for (i = 0; i < max_insns; i++, ip++) {
> -		if (ip->j_format.opcode == j_op)
> -			return J_TARGET(ip, ip->j_format.target);
> +	if (kernel_uses_mmips) {
> +		/* align start address to word boundary, lose mode bit */
> +		ip = (union mips_instruction *)((unsigned long)ip & ~0x3);

 See the note on instruction decoding above here as well.

 Also all corrections for the preexisting bugs noted above need to be 
separate patches.

  Maciej
