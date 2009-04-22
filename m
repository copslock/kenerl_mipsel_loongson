Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 07:53:44 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:30253 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S29563986AbZDVRux (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 18:50:53 +0100
X-IronPort-AV: E=Sophos;i="4.40,231,1238976000"; 
   d="scan'208";a="175337288"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-1.cisco.com with ESMTP; 22 Apr 2009 17:50:45 +0000
Received: from sj-core-4.cisco.com (sj-core-4.cisco.com [171.68.223.138])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n3MHojt0017197;
	Wed, 22 Apr 2009 10:50:45 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-4.cisco.com (8.13.8/8.13.8) with ESMTP id n3MHojSb029262;
	Wed, 22 Apr 2009 17:50:45 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id RAA22804; Wed, 22 Apr 2009 17:50:44 GMT
Date:	Wed, 22 Apr 2009 10:50:44 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
Message-ID: <20090422175044.GA28623@cuplxvomd02.corp.sa.net>
References: <49EE3B0F.3040506@caviumnetworks.com> <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2432; t=1240422645; x=1241286645;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=201/2]=20MIPS=3A=20Preliminary=2
	0vdso.
	|Sender:=20;
	bh=OpU0kyye0vjYaxdYR8XboMyq0p/nn8SikgucKC5iLV0=;
	b=REoZXUBB1E8pP4OBBs4kHJnD+8R9X/Wh3tGovHCIoMRY4UPHBETNObFzJ4
	cixQTWN63ItubwdTSpJO2NAPmUT/2CQBxCMsfB0b7yPn7aKthwyT6ku71Qfi
	SSlS88iG03;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 21, 2009 at 02:33:24PM -0700, David Daney wrote:
> This is a preliminary patch to add a vdso to all user processes.
...
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> new file mode 100644
> index 0000000..a1f38a6
...
> +static void __init install_trampoline(u32 *tramp, unsigned int sigreturn)
> +{
> +	tramp[0] = 0x24020000 + sigreturn;	/* li v0, sigreturn */
> +	tramp[1] = 0x0000000c;			/* syscall */
> +}

We can do away with magic constants by building on asm/inst.h:

static void __init install_trampoline(union mips_instruction *tramp,
	short sigreturn)
{
	static struct i_format li_sigreturn = {	/* li, v0, sigreturn */
		.opcode = addiu_op,
		.rs = 0,			/* zero */
		.rt = 2,			/* v0 */
	};
	static struct r_format syscall = {		/* syscall */
		.opcode = spec_op,
		.func = syscall_op
	};
	tramp[0].i_format = li_sigreturn;
	tramp[0].i_format.simmediate = sigreturn;
	tramp[1].r_format = syscall;
}

Admittedly, this isn't really a proper use of the r_format structure. The
right way is to add another structure to asm/inst.h and use that:

#ifdef __MIPSEB__
...
	struct syscall_format {
		unsigned int opcode : 6;
		unsigned int code : 20;
		unsigned int func : 6;
	};
...
#else
...
	struct syscall_format {
		unsigned int func : 6;
		unsigned int code : 20;
		unsigned int opcode : 6;
	};
...
#endif

Then we could do the syscall the right way by using syscall_format
instead of r_format...

...

> +int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
> +{
> +	int ret;
> +	unsigned long addr;
> +	struct mm_struct *mm = current->mm;
> +
> +	down_write(&mm->mmap_sem);
> +
> +	addr = vdso_addr(mm->start_stack);
> +
> +	addr = get_unmapped_area(NULL, addr, PAGE_SIZE, 0, 0);
> +	if (IS_ERR_VALUE(addr)) {
> +		ret = addr;
> +		goto up_fail;
> +	}
> +
> +	ret = install_special_mapping(mm, addr, PAGE_SIZE,
> +				      VM_READ|VM_EXEC|
> +				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> +				      VM_ALWAYSDUMP,
> +				      &vdso_page);
> +
> +	if (ret)
> +		goto up_fail;
> +
> +	mm->context.vdso = (void *)addr;
> +
> +up_fail:

It seems that this is an unexpected condition that probably indicates
a failure of the expected state of the process at this point. Perhaps
a pr_err() or pr_warning() would be appropriate?

> +	up_write(&mm->mmap_sem);
> +	return ret;
> +}
