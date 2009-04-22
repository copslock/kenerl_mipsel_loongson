Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 03:15:22 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:37621 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S29581754AbZDVSaA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 19:30:00 +0100
X-IronPort-AV: E=Sophos;i="4.40,231,1238976000"; 
   d="scan'208";a="175360874"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-1.cisco.com with ESMTP; 22 Apr 2009 18:28:30 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n3MISUIK022305;
	Wed, 22 Apr 2009 11:28:30 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n3MISU0S025858;
	Wed, 22 Apr 2009 18:28:30 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id SAA07136; Wed, 22 Apr 2009 18:28:30 GMT
Date:	Wed, 22 Apr 2009 11:28:30 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
Message-ID: <20090422182830.GA9184@cuplxvomd02.corp.sa.net>
References: <49EE3B0F.3040506@caviumnetworks.com> <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com> <20090422175044.GA28623@cuplxvomd02.corp.sa.net> <49EF5C62.9080803@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49EF5C62.9080803@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1246; t=1240424910; x=1241288910;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=201/2]=20MIPS=3A=20Preliminary=2
	0vdso.
	|Sender:=20;
	bh=cKFsFv3okm0sC/S6GRuCGgkyfmaisLA4gJfgGBO8bVQ=;
	b=lO64XAJkzjYMNiPwswKXjtsvKHLxlwt7YkxNf6WmHlCJ/BTqHlUoRXpScF
	SyYgg9GrmsPrUcNvI8h8TMQwPiowshUVshWrlOCGGoKuKZL5QBsUpT+tCyNF
	hZuEUfLQTW;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

>>> +int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>> +{
>>> +	int ret;
>>> +	unsigned long addr;
>>> +	struct mm_struct *mm = current->mm;
>>> +
>>> +	down_write(&mm->mmap_sem);
>>> +
>>> +	addr = vdso_addr(mm->start_stack);
>>> +
>>> +	addr = get_unmapped_area(NULL, addr, PAGE_SIZE, 0, 0);
>>> +	if (IS_ERR_VALUE(addr)) {
>>> +		ret = addr;
>>> +		goto up_fail;
>>> +	}
>>> +
>>> +	ret = install_special_mapping(mm, addr, PAGE_SIZE,
>>> +				      VM_READ|VM_EXEC|
>>> +				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
>>> +				      VM_ALWAYSDUMP,
>>> +				      &vdso_page);
>>> +
>>> +	if (ret)
>>> +		goto up_fail;
>>> +
>>> +	mm->context.vdso = (void *)addr;
>>> +
>>> +up_fail:
>>
>> It seems that this is an unexpected condition that probably indicates
>> a failure of the expected state of the process at this point. Perhaps
>> a pr_err() or pr_warning() would be appropriate?
>>
>>> +	up_write(&mm->mmap_sem);
>>> +	return ret;
>>> +}
>
> Really it should always succeed.  Something is seriously wrong if you  
> cannot map that page and we should probably panic().

It seems like it may be recoverable, so perhaps BUG() is better.

> David Daney

David VomLehn
