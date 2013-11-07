Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 19:00:38 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:56461 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823013Ab3KGSAcQGl0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Nov 2013 19:00:32 +0100
Received: by mail-ie0-f171.google.com with SMTP id tp5so1389748ieb.2
        for <linux-mips@linux-mips.org>; Thu, 07 Nov 2013 10:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ghjhSJEh3z4Z+bprY7W0ZazduYjLZFybG9Fw1p+I4uA=;
        b=oae39H0N2QeLvFHcH2TNXERxVmT5UPC6ixHTAC2+Z2VtltQQyD92vmBchvFpDGkWO8
         kVvVGmyn+ySVOx310XBd+DQOkgXVMD9Vr+C5687SatZKHPSlhkTBqcQWtxeMeNAHtMdh
         hDbyxDP3Trqzw2Xcr4GWZrQRiLt4Yltn40X5dB07SDL706IQWL2njhn9YcjOWRJNmJUA
         8486vW41H6ZFbHGaRgJPu/2pABRiRMr3RqOXWmt3svQkurBoOrYtKxsVLeqIDOCiyPxW
         GxkYwBmYTnmyQ6uYcjLCEKu5IGzGemcAOnxBo6BOyBV5I76lNZoYsivzf5T4eHTla9Q3
         ZfSA==
X-Received: by 10.50.114.168 with SMTP id jh8mr2990249igb.6.1383847225462;
        Thu, 07 Nov 2013 10:00:25 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id v2sm5358644igz.3.2013.11.07.10.00.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 10:00:24 -0800 (PST)
Message-ID: <527BD537.4040903@gmail.com>
Date:   Thu, 07 Nov 2013 10:00:23 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/6] mips: use per-mm page to execute FP branch delay
 slots
References: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com> <1383828513-28462-6-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1383828513-28462-6-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

Nice work...

On 11/07/2013 04:48 AM, Paul Burton wrote:
[...]
> -	 * Algorithmics used a system call instruction, and
> -	 * borrowed that vector.  MIPS/Linux version is a bit
> -	 * more heavyweight in the interests of portability and
> -	 * multiprocessor support.  For Linux we generate a
> -	 * an unaligned access and force an address error exception.
> +	 *  1) Be a bug in the userland code, because it has a branch/jump in
> +	 *     a branch delay slot. So if we run out of emuframes and the
> +	 *     userland code hangs it's not exactly the kernels fault.

s/kernels/kernel's/


>   	 *
> -	 * For embedded systems (stand-alone) we prefer to use a
> -	 * non-existing CP1 instruction. This prevents us from emulating
> -	 * branches, but gives us a cleaner interface to the exception
> -	 * handler (single entry point).
> +	 *  2) Only affect that userland process, since emuframes are allocated
> +	 *     per-mm and kernel threads don't use them at all.
>   	 */
> +	if (!get_isa16_mode(regs->cp0_epc)) {
> +		if (!ir) {
> +			/* typical NOP encoding: sll r0, r0, r0 */
> +is_nop:
> +			regs->cp0_epc = cpc;
> +			regs->cp0_cause &= ~CAUSEF_BD;
> +			return 0;
> +		}
>
> -	/* Ensure that the two instructions are in the same cache line */
> -	fr = (struct emuframe __user *)
> -		((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
> +		switch (inst.j_format.opcode) {
> +		case bcond_op:
> +			switch (inst.i_format.rt) {
> +			case bltz_op:
> +			case bgez_op:
> +			case bltzl_op:
> +			case bgezl_op:
> +			case bltzal_op:
> +			case bgezal_op:
> +			case bltzall_op:
> +			case bgezall_op:
> +				goto is_branch;
> +			}
> +			break;

Is there any way to use the support in arch/mips/kernel/branch.c instead 
of duplicating the code here?

It may require some refactoring to make it work, but I think it would be 
worth it.

>
> -	/* Verify that the stack pointer is not competely insane */
> -	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
> +		case cop1_op:
> +			switch (inst.i_format.rs) {
> +			case bc_op:
> +				goto is_branch;
> +			}
> +			break;
> +
> +		case j_op:
> +		case jal_op:
> +		case beq_op:
> +		case bne_op:
> +		case blez_op:
> +		case bgtz_op:
> +		case beql_op:
> +		case bnel_op:
> +		case blezl_op:
> +		case bgtzl_op:
> +		case jalx_op:
> +is_branch:
> +			pr_warn("PID %d has a branch in an FP branch delay slot at 0x%08lx\n",
> +				current->pid, regs->cp0_epc);
> +			goto is_nop;
> +		}
> +	} else {
> +		if ((ir >> 16) == MM_NOP16)
> +			goto is_nop;
> +
> +		switch (inst.mm_i_format.opcode) {
> +		case mm_beqz16_op:
> +		case mm_beq32_op:
> +		case mm_bnez16_op:
> +		case mm_bne32_op:
> +		case mm_b16_op:
> +		case mm_j32_op:
> +		case mm_jalx32_op:
> +		case mm_jal32_op:
> +			goto is_branch;
> +
> +		case mm_pool32i_op:
> +			switch (inst.mm_i_format.rt) {
> +			case mm_bltz_op:
> +			case mm_bltzal_op:
> +			case mm_bgez_op:
> +			case mm_bgezal_op:
> +			case mm_blez_op:
> +			case mm_bnezc_op:
> +			case mm_bgtz_op:
> +			case mm_beqzc_op:
> +			case mm_bltzals_op:
> +			case mm_bgezals_op:
> +			case mm_bc2f_op:
> +			case mm_bc2t_op:
> +			case mm_bc1f_op:
> +			case mm_bc1t_op:
> +				goto is_branch;
> +			}
> +			break;
> +
> +		case mm_pool16c_op:
> +			switch (inst.mm16_r5_format.rt) {
> +			case mm_jr16_op:
> +			case mm_jrc_op:
> +			case mm_jalr16_op:
> +			case mm_jalrs16_op:
> +			case mm_jraddiusp_op:
> +				goto is_branch;
> +			}
> +			break;
> +		}
> +	}
> +
>
