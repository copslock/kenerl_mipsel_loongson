Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 10:45:51 +0200 (CEST)
Received: from out03.mta.xmission.com ([166.70.13.233]:41515 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeENIpnJfHvt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 10:45:43 +0200
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fGxpx-0004gr-Bi; Thu, 10 May 2018 20:31:13 -0600
Received: from [97.90.247.198] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fGxpv-00043G-LM; Thu, 10 May 2018 20:31:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, <linux-mips@linux-mips.org>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-8-ebiederm@xmission.com>
        <e0a5bde2-7817-3e05-1c8d-c8fa8f6aa5f2@mips.com>
        <8736z0s087.fsf@xmission.com>
        <6811e06d-ac0d-35a6-7d86-57838d5d7f8e@mips.com>
Date:   Thu, 10 May 2018 21:31:06 -0500
In-Reply-To: <6811e06d-ac0d-35a6-7d86-57838d5d7f8e@mips.com> (Matt Redfearn's
        message of "Thu, 10 May 2018 08:59:26 +0100")
Message-ID: <87603uordh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fGxpv-00043G-LM;;;mid=<87603uordh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/G3kHU/VtO4wj28jvOhsdLgSc3TS+8TqY=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 08/22] signal/mips: Use force_sig_fault where appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
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

Matt Redfearn <matt.redfearn@mips.com> writes:

> Hi Eric,
>
> On 10/05/18 03:39, Eric W. Biederman wrote:
>> Matt Redfearn <matt.redfearn@mips.com> writes:
>>
>>> Hi Eric,
>>>
>>> On 20/04/18 15:37, Eric W. Biederman wrote:
>>>> Filling in struct siginfo before calling force_sig_info a tedious and
>>>> error prone process, where once in a great while the wrong fields
>>>> are filled out, and siginfo has been inconsistently cleared.
>>>>
>>>> Simplify this process by using the helper force_sig_fault.  Which
>>>> takes as a parameters all of the information it needs, ensures
>>>> all of the fiddly bits of filling in struct siginfo are done properly
>>>> and then calls force_sig_info.
>>>>
>>>> In short about a 5 line reduction in code for every time force_sig_info
>>>> is called, which makes the calling function clearer.
>>>>
>>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>>> Cc: James Hogan <jhogan@kernel.org>
>>>> Cc: linux-mips@linux-mips.org
>>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>> ---
>>>>    arch/mips/kernel/traps.c | 65 ++++++++++++++----------------------------------
>>>>    arch/mips/mm/fault.c     | 19 ++++----------
>>>>    2 files changed, 23 insertions(+), 61 deletions(-)
>>>>
>>>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>>>> index 967e9e4e795e..66ec4b0b484d 100644
>>>> --- a/arch/mips/kernel/traps.c
>>>> +++ b/arch/mips/kernel/traps.c
>>>> @@ -699,17 +699,11 @@ static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
>>>>    asmlinkage void do_ov(struct pt_regs *regs)
>>>>    {
>>>>    	enum ctx_state prev_state;
>>>> -	siginfo_t info;
>>>> -
>>>> -	clear_siginfo(&info);
>>>> -	info.si_signo = SIGFPE;
>>>> -	info.si_code = FPE_INTOVF;
>>>> -	info.si_addr = (void __user *)regs->cp0_epc;
>>>>      	prev_state = exception_enter();
>>>>    	die_if_kernel("Integer overflow", regs);
>>>>    -	force_sig_info(SIGFPE, &info, current);
>>>> +	force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->cp0_epc, current);
>>>>    	exception_exit(prev_state);
>>>>    }
>>>>    @@ -722,32 +716,27 @@ asmlinkage void do_ov(struct pt_regs *regs)
>>>>    void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
>>>>    		     struct task_struct *tsk)
>>>>    {
>>>> -	struct siginfo si;
>>>> -
>>>> -	clear_siginfo(&si);
>>>> -	si.si_addr = fault_addr;
>>>> -	si.si_signo = SIGFPE;
>>>> +	int si_code;
>>>
>>> This is giving build errors in Linux next
>>> (https://storage.kernelci.org/next/master/next-20180509/mips/defconfig+kselftest/build.log)
>>>
>>> si_code would have ended up as 0 before from the clear_siginfo(), but perhaps
>>
>> And si_code 0 is not a valid si_code to use with a floating point
>> siginfo layout.
>>
>>> int si_code = FPE_FLTUNK;
>>>
>>> Would make a more sensible default?
>>
>> FPE_FLTUNK would make a more sensible default.
>>
>> I seem to remember someone telling me that case can never happen in
>> practice so I have simply not worried about it.  Perhaps I am
>> misremembering this.
>
> It probably can't happen in practise - but the issue is that the
> kernel doesn't even compile because -Werror=maybe-uninitialized
> results in a build error since the compiler can't know that one of the
> branches will definitely be taken to set si_code.

My cross compile work.  So I don't know where that
-Werror=maybe-unitialized comes from.

I agree it is an issue.   I agree that FPE_FLTUNK is one of the good
solutions.  Another is to add a final else where you return without
doing anything.

Right now this looks like mips people issue that I have unearthed.
I could appreciate some guidance on which way mips folks would like to
handle this.

If you can point me to where the fatal error is coming from I will
definitely do something in my tree so that this is not a harmful issue.

Eric
