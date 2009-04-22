Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 07:54:50 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:29213 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20039667AbZDVSGv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 19:06:51 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ef5c860000>; Wed, 22 Apr 2009 14:05:58 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 11:05:22 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 11:05:22 -0700
Message-ID: <49EF5C62.9080803@caviumnetworks.com>
Date:	Wed, 22 Apr 2009 11:05:22 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com> <20090422175044.GA28623@cuplxvomd02.corp.sa.net>
In-Reply-To: <20090422175044.GA28623@cuplxvomd02.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2009 18:05:22.0276 (UTC) FILETIME=[E7683A40:01C9C374]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> On Tue, Apr 21, 2009 at 02:33:24PM -0700, David Daney wrote:
>> This is a preliminary patch to add a vdso to all user processes.
> ...
>> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
>> new file mode 100644
>> index 0000000..a1f38a6
> ...
>> +static void __init install_trampoline(u32 *tramp, unsigned int sigreturn)
>> +{
>> +	tramp[0] = 0x24020000 + sigreturn;	/* li v0, sigreturn */
>> +	tramp[1] = 0x0000000c;			/* syscall */
>> +}
> 
> We can do away with magic constants by building on asm/inst.h:
> 
> static void __init install_trampoline(union mips_instruction *tramp,
> 	short sigreturn)
> {
> 	static struct i_format li_sigreturn = {	/* li, v0, sigreturn */
> 		.opcode = addiu_op,
> 		.rs = 0,			/* zero */
> 		.rt = 2,			/* v0 */
> 	};
> 	static struct r_format syscall = {		/* syscall */
> 		.opcode = spec_op,
> 		.func = syscall_op
> 	};
> 	tramp[0].i_format = li_sigreturn;
> 	tramp[0].i_format.simmediate = sigreturn;
> 	tramp[1].r_format = syscall;
> }
> 
> Admittedly, this isn't really a proper use of the r_format structure. The
> right way is to add another structure to asm/inst.h and use that:

Perhaps using the uasm would be even better.

[...]
> 
>> +int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>> +{
>> +	int ret;
>> +	unsigned long addr;
>> +	struct mm_struct *mm = current->mm;
>> +
>> +	down_write(&mm->mmap_sem);
>> +
>> +	addr = vdso_addr(mm->start_stack);
>> +
>> +	addr = get_unmapped_area(NULL, addr, PAGE_SIZE, 0, 0);
>> +	if (IS_ERR_VALUE(addr)) {
>> +		ret = addr;
>> +		goto up_fail;
>> +	}
>> +
>> +	ret = install_special_mapping(mm, addr, PAGE_SIZE,
>> +				      VM_READ|VM_EXEC|
>> +				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
>> +				      VM_ALWAYSDUMP,
>> +				      &vdso_page);
>> +
>> +	if (ret)
>> +		goto up_fail;
>> +
>> +	mm->context.vdso = (void *)addr;
>> +
>> +up_fail:
> 
> It seems that this is an unexpected condition that probably indicates
> a failure of the expected state of the process at this point. Perhaps
> a pr_err() or pr_warning() would be appropriate?
> 
>> +	up_write(&mm->mmap_sem);
>> +	return ret;
>> +}

Really it should always succeed.  Something is seriously wrong if you 
cannot map that page and we should probably panic().

David Daney
