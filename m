Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2013 13:08:35 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:41297 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823060Ab3KHMIdLsN3y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Nov 2013 13:08:33 +0100
Message-ID: <527CD403.8040407@imgtec.com>
Date:   Fri, 8 Nov 2013 12:07:31 +0000
From:   Paul Burton <paul.burton@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/6] mips: use per-mm page to execute FP branch delay
 slots
References: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com> <1383828513-28462-6-git-send-email-paul.burton@imgtec.com> <527BD537.4040903@gmail.com>
In-Reply-To: <527BD537.4040903@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2013_11_08_12_08_26
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 07/11/13 18:00, David Daney wrote:
> Nice work...
>
> On 11/07/2013 04:48 AM, Paul Burton wrote:
> [...]
>> -     * Algorithmics used a system call instruction, and
>> -     * borrowed that vector.  MIPS/Linux version is a bit
>> -     * more heavyweight in the interests of portability and
>> -     * multiprocessor support.  For Linux we generate a
>> -     * an unaligned access and force an address error exception.
>> +     *  1) Be a bug in the userland code, because it has a
>> branch/jump in
>> +     *     a branch delay slot. So if we run out of emuframes and the
>> +     *     userland code hangs it's not exactly the kernels fault.
>
> s/kernels/kernel's/
>

Yup, thanks.

>
>>        *
>> -     * For embedded systems (stand-alone) we prefer to use a
>> -     * non-existing CP1 instruction. This prevents us from emulating
>> -     * branches, but gives us a cleaner interface to the exception
>> -     * handler (single entry point).
>> +     *  2) Only affect that userland process, since emuframes are
>> allocated
>> +     *     per-mm and kernel threads don't use them at all.
>>        */
>> +    if (!get_isa16_mode(regs->cp0_epc)) {
>> +        if (!ir) {
>> +            /* typical NOP encoding: sll r0, r0, r0 */
>> +is_nop:
>> +            regs->cp0_epc = cpc;
>> +            regs->cp0_cause &= ~CAUSEF_BD;
>> +            return 0;
>> +        }
>>
>> -    /* Ensure that the two instructions are in the same cache line */
>> -    fr = (struct emuframe __user *)
>> -        ((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
>> +        switch (inst.j_format.opcode) {
>> +        case bcond_op:
>> +            switch (inst.i_format.rt) {
>> +            case bltz_op:
>> +            case bgez_op:
>> +            case bltzl_op:
>> +            case bgezl_op:
>> +            case bltzal_op:
>> +            case bgezal_op:
>> +            case bltzall_op:
>> +            case bgezall_op:
>> +                goto is_branch;
>> +            }
>> +            break;
>
> Is there any way to use the support in arch/mips/kernel/branch.c instead
> of duplicating the code here?
>
> It may require some refactoring to make it work, but I think it would be
> worth it.
>

Ah (how had I not spotted that code?) :)

It may fit better with the (mm_)isBranchInstr functions in 
arch/mips/math-emu/cp1emu.c since they already return a value specifying 
whether or not the instruction is a branch. The microMIPS variant is 
already used elsewhere too. I'll take a look at it.

Thanks,
     Paul

>>
>> -    /* Verify that the stack pointer is not competely insane */
>> -    if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
>> +        case cop1_op:
>> +            switch (inst.i_format.rs) {
>> +            case bc_op:
>> +                goto is_branch;
>> +            }
>> +            break;
>> +
>> +        case j_op:
>> +        case jal_op:
>> +        case beq_op:
>> +        case bne_op:
>> +        case blez_op:
>> +        case bgtz_op:
>> +        case beql_op:
>> +        case bnel_op:
>> +        case blezl_op:
>> +        case bgtzl_op:
>> +        case jalx_op:
>> +is_branch:
>> +            pr_warn("PID %d has a branch in an FP branch delay slot
>> at 0x%08lx\n",
>> +                current->pid, regs->cp0_epc);
>> +            goto is_nop;
>> +        }
>> +    } else {
>> +        if ((ir >> 16) == MM_NOP16)
>> +            goto is_nop;
>> +
>> +        switch (inst.mm_i_format.opcode) {
>> +        case mm_beqz16_op:
>> +        case mm_beq32_op:
>> +        case mm_bnez16_op:
>> +        case mm_bne32_op:
>> +        case mm_b16_op:
>> +        case mm_j32_op:
>> +        case mm_jalx32_op:
>> +        case mm_jal32_op:
>> +            goto is_branch;
>> +
>> +        case mm_pool32i_op:
>> +            switch (inst.mm_i_format.rt) {
>> +            case mm_bltz_op:
>> +            case mm_bltzal_op:
>> +            case mm_bgez_op:
>> +            case mm_bgezal_op:
>> +            case mm_blez_op:
>> +            case mm_bnezc_op:
>> +            case mm_bgtz_op:
>> +            case mm_beqzc_op:
>> +            case mm_bltzals_op:
>> +            case mm_bgezals_op:
>> +            case mm_bc2f_op:
>> +            case mm_bc2t_op:
>> +            case mm_bc1f_op:
>> +            case mm_bc1t_op:
>> +                goto is_branch;
>> +            }
>> +            break;
>> +
>> +        case mm_pool16c_op:
>> +            switch (inst.mm16_r5_format.rt) {
>> +            case mm_jr16_op:
>> +            case mm_jrc_op:
>> +            case mm_jalr16_op:
>> +            case mm_jalrs16_op:
>> +            case mm_jraddiusp_op:
>> +                goto is_branch;
>> +            }
>> +            break;
>> +        }
>> +    }
>> +
>>
