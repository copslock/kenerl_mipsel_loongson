Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 16:43:53 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:32113 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22595252AbYJ1Qnp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 16:43:45 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490741380001>; Tue, 28 Oct 2008 12:43:36 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Oct 2008 09:43:33 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Oct 2008 09:43:33 -0700
Message-ID: <49074135.6060104@caviumnetworks.com>
Date:	Tue, 28 Oct 2008 09:43:33 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 07/36] Don't assume boot CPU is CPU0 if	MIPS_DISABLE_BOOT_CPU_ZERO
 set.
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <20081028064743.GA18610@linux-mips.org>
In-Reply-To: <20081028064743.GA18610@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2008 16:43:33.0215 (UTC) FILETIME=[50ACF6F0:01C9391C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 27, 2008 at 05:02:39PM -0700, David Daney wrote:
> 
>> MIPS SMP code currently assumes that the boot CPU will be CPU0
>> of the system.  For some systems, this may not be the case.
> 
> It always the logic CPU 0 though the physical number might be different.
> 
>> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>> index b79ea70..e2597ef 100644
>> --- a/arch/mips/kernel/smp.c
>> +++ b/arch/mips/kernel/smp.c
>> @@ -195,12 +195,14 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>  /* preload SMP state for boot cpu */
>>  void __devinit smp_prepare_boot_cpu(void)
>>  {
>> +#ifndef MIPS_DISABLE_BOOT_CPU_ZERO
>>  	/*
>>  	 * This assumes that bootup is always handled by the processor
>>  	 * with the logic and physical number 0.
>>  	 */
>>  	__cpu_number_map[0] = 0;
>>  	__cpu_logical_map[0] = 0;
>> +#endif
> 
> This assignment is redundant anyway - the kernel is starting with the array
> zeroed.  So just remove this entire initialization and do your array
> initialization in your mp_ops->smp_setup.
> 

We already do that.  I will just delete this section unconditionally.

David Daney
