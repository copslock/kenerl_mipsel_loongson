Received:  by oss.sgi.com id <S554051AbRAZAul>;
	Thu, 25 Jan 2001 16:50:41 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:49671 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S554049AbRAZAu2>; Thu, 25 Jan 2001 16:50:28 -0800
Received: from redhat.com (IDENT:joe@dhcp-4.wirespeed.com [172.16.17.4])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id SAA10182;
	Thu, 25 Jan 2001 18:45:33 -0600
Message-ID: <3A70CA98.102@redhat.com>
Date:   Thu, 25 Jan 2001 18:53:44 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125165530.B12576@paradigm.rfc822.org> <3A70705C.5020600@redhat.com> <3A707FFB.60802@redhat.com> <20010125141952.C2311@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf,
	Thanks for the help. I generally consider myself a pseudo-expert on 
Linux, but at the same time I'm amazed by how much I learn on a daily basis.

So I've got the following code which seems to work... (I can't use the 
ll/sc ops on the Vr41xx since they are not implemeted!)

#ifdef CONFIG_CPU_VR41XX
	/* this version is inherently single processor! */
	
	case MIPS_ATOMIC_SET: {
		unsigned int tmp;
		unsigned long flags;

		p = (int *) arg1;
		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
		if (errno)
			return errno;
		errno = 0;

		/* the Vr processors can't be SMP, so just lock ints */
		save_and_cli(flags);
		tmp = *p ;
		*p = arg2 ;
		restore_flags(flags);
		return tmp;

	}
#endif

The trailer in the normal call is like :

		/* We're skipping error handling etc.  */
		if (current->ptrace & PT_TRACESYS)
			syscall_trace();

		__asm__ __volatile__(
			"move\t$29, %0\n\t"
			"j\tret_from_sys_call"
			: /* No outputs */
			: "r" (&cmd));
		/* Unreached */

Which says "no outputs" although sysmips is specified as

extern int sysmips __P ((__const cmd, __const int arg1,
			 __const int arg2, __const int arg3));

and the usage of this call in glibc pthreads implies that there should 
be a return value. Should I be bypassing the scheduler to return also?

The end goal of this is to make pthreads work on the Vr4181...it's 
certainly an interesting task so far...

Ralf Baechle wrote:

> On Thu, Jan 25, 2001 at 01:35:23PM -0600, Joe deBlaquiere wrote:
> 
> 
>> sysmips(MIPS_ATOMIC_SET,ptr,val)
>> {
>> 	 *ptr = val ;
>> 	val 0 ;
>> }
>> 
>> but it is an atomic operation
>> 
>> if this correct in a pseudo-code sense?
> 
> 
> It's more:
> 
> sysmips(MIPS_ATOMIC_SET, ptr, val)
> {
> 	result = *ptr;
> 	*ptr = val;
> 
> 	return result;
> }
> 
>    Ralf


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
