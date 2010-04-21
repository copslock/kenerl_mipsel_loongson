Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2010 19:45:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5981 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492207Ab0DURpm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Apr 2010 19:45:42 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bcf39cf0000>; Wed, 21 Apr 2010 10:45:51 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 21 Apr 2010 10:45:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 21 Apr 2010 10:45:17 -0700
Message-ID: <4BCF39A7.3020708@caviumnetworks.com>
Date:   Wed, 21 Apr 2010 10:45:11 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>,
        linux-mips@linux-mips.org, a.p.zijlstra@chello.nl,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com,
        jamie.iles@picochip.com
Subject: Re: [PATCH 1/3] MIPS: use the generic atomic64 operations for perf
 counter support
References: <1271349525.7467.420.camel@fun-lab> <4BCDD58F.7020201@caviumnetworks.com> <20100421171915.GA29010@linux-mips.org>
In-Reply-To: <20100421171915.GA29010@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2010 17:45:17.0614 (UTC) FILETIME=[67BC64E0:01CAE17A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/21/2010 10:19 AM, Ralf Baechle wrote:
[...]
>
> -#ifdef CONFIG_64BIT
> +typedef struct {
> +	long long counter;
> +} atomic64_t;
>

How does this not conflict with the definition in linux/types.h for a 
64-bit kernel?


>   #define ATOMIC64_INIT(i)    { (i) }
>
> @@ -410,14 +414,44 @@ static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
>    * @v: pointer of type atomic64_t
>    *
>    */
> -#define atomic64_read(v)	((v)->counter)
> +static long long __inline__ atomic64_read(const atomic64_t *v)
> +{
> +	unsigned long flags;
> +	raw_spinlock_t *lock;
> +	long long val;
> +
> +	if (cpu_has_64bit_gp_regs)	/* 64-bit regs imply 64-bit ld / sd  */
> +		return v->counter;
> +

How is this atomic for the o32 ABI?  counter is now not volatile, in 
o32, u64 values are often split between two registers.  There is nothing 
to guarantee that the compiler will use LD.


David Daney
