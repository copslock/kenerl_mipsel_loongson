Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 03:29:03 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:62379 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491827AbZGBB25 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 03:28:57 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n621N93P004531;
	Wed, 1 Jul 2009 18:23:09 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 1 Jul 2009 18:23:08 -0700
Received: from [128.224.158.160] ([128.224.158.160]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 1 Jul 2009 18:23:08 -0700
Message-ID: <4A4C0C91.2010407@windriver.com>
Date:	Thu, 02 Jul 2009 09:25:37 +0800
From:	Yong Zhang <yong.zhang@windriver.com>
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: o32 application running on 64bit kernel core dump
References: <16bd35f2910f585740f4764fa1e80bf31c80d576.1242178813.git.yong.zhang@windriver.com> <4A4BB456.9090404@caviumnetworks.com>
In-Reply-To: <4A4BB456.9090404@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 01:23:08.0790 (UTC) FILETIME=[A862B160:01C9FAB3]
Return-Path: <yong.zhang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
Precedence: bulk
X-list: linux-mips



David Daney wrote:
> Yong Zhang wrote:
>> If an o32 application crashes and generates a core dump on
>> a 64 bit kernel, the core file will not be correctly
>> recognized. This is because ELF_CORE_COPY_REGS and
>> ELF_CORE_COPY_TASK_REGS are not correctly defined for o32
>> and will use the default register set which would
>> be CONFIG_64BIT in asm/elf.h.
>>
>> So we'll switch to use the right register defines in
>> this situation by checking for WANT_COMPAT_REG_H and
>> use the right defines of ELF_CORE_COPY_REGS and
>> ELF_CORE_COPY_TASK_REGS.
> 
> This patch looks plausible.  How was it tested?
> 
> Can you still obtain good core files with at 32-bit kernel?

Yeah, I also have tested 32-bit kernel. Actually this doesn't have any
side effect on that.

> 
> Are usable core files obtained for all three ABIs on 64-bit kernels?

Tested for all three ABIs, and all does the right thing.
Testing code is below:
/* test.c */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <strings.h>
#include <execinfo.h>
#include <sys/types.h>
#include <linux/unistd.h>
#include <errno.h>
#include <pthread.h>

#define MAX_THREADS 4

void foo7()
{
	int *i=0;
	char c =*i;
}

void foo6()
{
	int c6=1000;
	int i=9;
	while(c6--)
	{
		i=i*9+1;
	}
	printf("inside foo6\n");
	foo7();
}

void foo5()
{
	int c5=1000;
	int i=9;
	while(c5--)
	{
		i=i*9+1;
	}
	printf("inside foo5\n");
	foo6();
}

void foo4()
{
	int c4=1000;
	int i=9;
	while(c4--)
	{
		i=i*9+1;
	}
	printf("inside foo4\n");
	foo5();
}

void foo3()
{
	int c3=1000;
	int i=9;
	while(c3--)
	{
		i=i*9+1;
	}
	printf("inside foo3\n");
	foo4();
}

void foo2()
{
	int c2=1000;
	int i=9;
	while (c2--)
	{
		i=i*9+1;
	}
	printf("inside foo2\n");
	foo3();
}

void *foo1(void* arg)
{
	sleep(10);
	foo2();
}

int main()
{
	int i=0;
	pthread_t *threads;
	pthread_attr_t pthread_attr;

	printf("inside main\n");
	threads=(pthread_t *)malloc(MAX_THREADS*sizeof(*threads));
	pthread_attr_init(&pthread_attr);

	for(i=0;i<MAX_THREADS;i++)
	{
		pthread_create(&threads[i],&pthread_attr,foo1,NULL);
	}

	for(i=0;i<MAX_THREADS;i++)
	{
		pthread_join(threads[i],NULL);
	}

	exit(1);
}
> 
> Other than that, I have only the one comment below.
> 
> Thanks,
> David Daney
> 

<cut here>

>
>> +#define ELF_CORE_COPY_TASK_REGS(_tsk, _dest)                \
>> +({                                    \
>> +    int __res = 1;                            \
>> +    elf32_core_copy_regs((*_dest), (task_pt_regs(_tsk)));        \
>> +    __res;                                \
> 
> Why does __res exist?  Can't you have that last line just be '1;'?

Sounds good. Just be '1;' is good.

Thanks,
Yong

> 
>> +})
>> +
>>  #include <linux/module.h>
>>  #include <linux/elfcore.h>
>>  #include <linux/compat.h>
>> @@ -110,9 +127,6 @@ jiffies_to_compat_timeval(unsigned long jiffies,
>> struct compat_timeval *value)
>>      value->tv_usec = rem / NSEC_PER_USEC;
>>  }
>>  
>> -#undef ELF_CORE_COPY_REGS
>> -#define ELF_CORE_COPY_REGS(_dest, _regs) elf32_core_copy_regs(_dest,
>> _regs);
>> -
>>  void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs)
>>  {
>>      int i;
> 
> 
