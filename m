Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Aug 2013 00:20:31 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:59257 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822527Ab3HSWUZXKLZ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Aug 2013 00:20:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id EFF655A6E4C;
        Tue, 20 Aug 2013 01:20:21 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id J2WdASCc36mx; Tue, 20 Aug 2013 01:20:17 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 0A90F5BC003;
        Tue, 20 Aug 2013 01:20:16 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Tue, 20 Aug 2013 01:20:12 +0300
Date:   Tue, 20 Aug 2013 01:20:12 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] MIPS: Remove unreachable break statements from
 cp1emu.c
Message-ID: <20130819222012.GJ3067@blackmetal.musicnaut.iki.fi>
References: <1376939435-19761-1-git-send-email-ddaney.cavm@gmail.com>
 <1376939435-19761-3-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376939435-19761-3-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Mon, Aug 19, 2013 at 12:10:35PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> There were many cases of:
> 
>    return something;
>    break;
> 
> All those break statements are unreachable and thus redundant.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/mips/math-emu/cp1emu.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 46048d2..efe0088 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -436,7 +436,6 @@ static int microMIPS32_to_MIPS32(union mips_instruction *insn_ptr)
>  				break;
>  			default:
>  				return SIGILL;
> -				break;
>  			}
>  			break;
>  		case mm_32f_74_op:	/* c.cond.fmt */
> @@ -451,12 +450,10 @@ static int microMIPS32_to_MIPS32(union mips_instruction *insn_ptr)
>  			break;
>  		default:
>  			return SIGILL;
> -			break;
>  		}
>  		break;
>  	default:
>  		return SIGILL;
> -		break;
>  	}
>  
>  	*insn_ptr = mips32_insn;
> @@ -491,7 +488,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  						dec_insn.next_pc_inc;
>  				*contpc = regs->regs[insn.mm_i_format.rs];
>  				return 1;
> -				break;
>  			}
>  		}
>  		break;
> @@ -513,7 +509,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  					dec_insn.pc_inc +
>  					dec_insn.next_pc_inc;
>  			return 1;
> -			break;
>  		case mm_bgezals_op:
>  		case mm_bgezal_op:
>  			regs->regs[31] = regs->cp0_epc +
> @@ -530,7 +525,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  					dec_insn.pc_inc +
>  					dec_insn.next_pc_inc;
>  			return 1;
> -			break;
>  		case mm_blez_op:
>  			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
>  				*contpc = regs->cp0_epc +
> @@ -541,7 +535,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  					dec_insn.pc_inc +
>  					dec_insn.next_pc_inc;
>  			return 1;
> -			break;
>  		case mm_bgtz_op:
>  			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
>  				*contpc = regs->cp0_epc +
> @@ -552,7 +545,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  					dec_insn.pc_inc +
>  					dec_insn.next_pc_inc;
>  			return 1;
> -			break;
>  		case mm_bc2f_op:
>  		case mm_bc1f_op:
>  			bc_false = 1;
> @@ -580,7 +572,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  				*contpc = regs->cp0_epc +
>  					dec_insn.pc_inc + dec_insn.next_pc_inc;
>  			return 1;
> -			break;
>  		}
>  		break;
>  	case mm_pool16c_op:
> @@ -593,7 +584,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  		case mm_jr16_op:
>  			*contpc = regs->regs[insn.mm_i_format.rs];
>  			return 1;
> -			break;
>  		}
>  		break;
>  	case mm_beqz16_op:
> @@ -605,7 +595,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  			*contpc = regs->cp0_epc +
>  				dec_insn.pc_inc + dec_insn.next_pc_inc;
>  		return 1;
> -		break;
>  	case mm_bnez16_op:
>  		if ((long)regs->regs[reg16to32map[insn.mm_b1_format.rs]] != 0)
>  			*contpc = regs->cp0_epc +
> @@ -615,12 +604,10 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  			*contpc = regs->cp0_epc +
>  				dec_insn.pc_inc + dec_insn.next_pc_inc;
>  		return 1;
> -		break;
>  	case mm_b16_op:
>  		*contpc = regs->cp0_epc + dec_insn.pc_inc +
>  			 (insn.mm_b0_format.simmediate << 1);
>  		return 1;
> -		break;
>  	case mm_beq32_op:
>  		if (regs->regs[insn.mm_i_format.rs] ==
>  		    regs->regs[insn.mm_i_format.rt])
> @@ -632,7 +619,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  				dec_insn.pc_inc +
>  				dec_insn.next_pc_inc;
>  		return 1;
> -		break;
>  	case mm_bne32_op:
>  		if (regs->regs[insn.mm_i_format.rs] !=
>  		    regs->regs[insn.mm_i_format.rt])
> @@ -643,7 +629,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  			*contpc = regs->cp0_epc +
>  				dec_insn.pc_inc + dec_insn.next_pc_inc;
>  		return 1;
> -		break;
>  	case mm_jalx32_op:
>  		regs->regs[31] = regs->cp0_epc +
>  			dec_insn.pc_inc + dec_insn.next_pc_inc;
> @@ -652,7 +637,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  		*contpc <<= 28;
>  		*contpc |= (insn.j_format.target << 2);
>  		return 1;
> -		break;
>  	case mm_jals32_op:
>  	case mm_jal32_op:
>  		regs->regs[31] = regs->cp0_epc +
> @@ -665,7 +649,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  		*contpc |= (insn.j_format.target << 1);
>  		set_isa16_mode(*contpc);
>  		return 1;
> -		break;
>  	}
>  	return 0;
>  }
> @@ -694,7 +677,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  		case jr_op:
>  			*contpc = regs->regs[insn.r_format.rs];
>  			return 1;
> -			break;
>  		}
>  		break;
>  	case bcond_op:
> @@ -716,7 +698,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  					dec_insn.pc_inc +
>  					dec_insn.next_pc_inc;
>  			return 1;
> -			break;
>  		case bgezal_op:
>  		case bgezall_op:
>  			regs->regs[31] = regs->cp0_epc +
> @@ -734,7 +715,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  					dec_insn.pc_inc +
>  					dec_insn.next_pc_inc;
>  			return 1;
> -			break;
>  		}
>  		break;
>  	case jalx_op:
> @@ -752,7 +732,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  		/* Set microMIPS mode bit: XOR for jalx. */
>  		*contpc ^= bit;
>  		return 1;
> -		break;
>  	case beq_op:
>  	case beql_op:
>  		if (regs->regs[insn.i_format.rs] ==
> @@ -765,7 +744,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  				dec_insn.pc_inc +
>  				dec_insn.next_pc_inc;
>  		return 1;
> -		break;
>  	case bne_op:
>  	case bnel_op:
>  		if (regs->regs[insn.i_format.rs] !=
> @@ -778,7 +756,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  				dec_insn.pc_inc +
>  				dec_insn.next_pc_inc;
>  		return 1;
> -		break;
>  	case blez_op:
>  	case blezl_op:
>  		if ((long)regs->regs[insn.i_format.rs] <= 0)
> @@ -790,7 +767,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  				dec_insn.pc_inc +
>  				dec_insn.next_pc_inc;
>  		return 1;
> -		break;
>  	case bgtz_op:
>  	case bgtzl_op:
>  		if ((long)regs->regs[insn.i_format.rs] > 0)
> @@ -802,7 +778,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  				dec_insn.pc_inc +
>  				dec_insn.next_pc_inc;
>  		return 1;
> -		break;
>  #ifdef CONFIG_CPU_CAVIUM_OCTEON
>  	case lwc2_op: /* This is bbit0 on Octeon */
>  		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt)) == 0)
> @@ -856,7 +831,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  						dec_insn.pc_inc +
>  						dec_insn.next_pc_inc;
>  				return 1;
> -				break;
>  			case 1:	/* bc1t */
>  			case 3:	/* bc1tl */
>  				if (fcr31 & (1 << bit))
> @@ -868,7 +842,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  						dec_insn.pc_inc +
>  						dec_insn.next_pc_inc;
>  				return 1;
> -				break;
>  			}
>  		}
>  		break;
> -- 
> 1.7.11.7
> 
> 
