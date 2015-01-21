Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 11:43:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31030 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011377AbbAUKn2yf-9p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 11:43:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8709865684344;
        Wed, 21 Jan 2015 10:43:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 10:43:22 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Jan
 2015 10:43:21 +0000
Message-ID: <54BF82C9.4040909@imgtec.com>
Date:   Wed, 21 Jan 2015 10:43:21 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC v2 45/70] MIPS: kernel: branch: Prevent BLTZL emulation
 for MIPS R6
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-46-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501210044050.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501210044050.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/21/2015 01:59 AM, Maciej W. Rozycki wrote:
> On Fri, 16 Jan 2015, Markos Chandras wrote:
> 
>> MIPS R6 removed the BLTZL instruction so do not try to emulate it
>> if the R2-to-R6 emulator is not present.
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
> 
>  I appreciate your effort in splitting 45-52/70 into separate patches, but 
> frankly I think removing individual branch instructions one by one seems 
> an overkill to me, and actually makes a review more difficult.  They 
> comprise a single functional entity and can really be treated as one 
> feature and splitting it into pieces makes it easy to miss the big 
> picture.
> 

Ok will do

>> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
>> index 9b622ca391d8..502bf2aeb834 100644
>> --- a/arch/mips/kernel/branch.c
>> +++ b/arch/mips/kernel/branch.c
>> @@ -436,6 +436,11 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>>  		switch (insn.i_format.rt) {
>>  		case bltz_op:
>>  		case bltzl_op:
>> +			if (NO_R6EMU && (insn.i_format.rt == bltzl_op)) {
>> +				ret = -SIGILL;
>> +				/* not emulating the branch likely for R6 */
>> +				break;
>> +			}
>>  			if ((long)regs->regs[insn.i_format.rs] < 0) {
>>  				epc = epc + 4 + (insn.i_format.simmediate << 2);
>>  				if (insn.i_format.rt == bltzl_op)
> 
>  For example here it is obvious that there is no need to repeat the 
> condition and:
> 
> 		switch (insn.i_format.rt) {
> 		case bltzl_op:
> 			if (NO_R6EMU) {
> 				ret = -SIGILL;
> 				/* not emulating the branch likely for R6 */
> 				break;
> 			}
> 			/* Fall through */
> 		case bltz_op:
> 
> will do.
> 
yes but i was trying to avoid touching more things than necessary. I
don't think the current code is unreadable, but I will change it as
suggested.

>  However the way how the return value is set and the error return path 
> handled here is inconsistent with how BPOSGE32 does these things here.  
> From how `__compute_return_epc' and `evaluate_branch_instruction' handle 
> error returns it looks to me it's BPOSGE32 that is right.  So you do need 
> to return -EFAULT instead and send a signal, probably SIGILL.
> 
>  So it looks to me you want to use `goto' instead, to a similar exit path 
> (a poor man's plain C exception handler) like BPOSGE32 uses, with a 
> similar message produced to the kernel log and SIGILL thrown, maybe 
> calling them `sigill_dsp' and `sigill_r6' respectively.  Why BPOSGE32 uses 
> SIGBUS instead escapes me, perhaps someone just copied and pasted the 
> `unaligned' case from `__compute_return_epc' without thinking much.  I 
> think it should be fixed too, or otherwise an explanatory comment added.
>

Ok I will do that.

-- 
markos
