Received:  by oss.sgi.com id <S554081AbRAZPs4>;
	Fri, 26 Jan 2001 07:48:56 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:64010 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S554078AbRAZPsm>; Fri, 26 Jan 2001 07:48:42 -0800
Received: from redhat.com (IDENT:joe@dhcp-4.wirespeed.com [172.16.17.4])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id JAA18589;
	Fri, 26 Jan 2001 09:33:31 -0600
Message-ID: <3A719ABD.5030206@redhat.com>
Date:   Fri, 26 Jan 2001 09:41:49 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC:     Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
References: <Pine.GSO.3.96.1010126111156.8903B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf gently pointed out that there was the possibility of needing to 
fault the page for *p, which couldn't occur with ints off. So here's an 
updated version...

#ifndef CONFIG_CPU_HAS_LLSC
	/* this version is inherently single processor! */
	/* borrowed from Linux-2.4.0-test12 */
	/* mlock/munlock added - jadb@redhat.com */
	
	case MIPS_ATOMIC_SET: {
		unsigned int tmp;
		unsigned int flags;

		p = (int *) arg1;
		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
		if (errno)
			return errno;
		errno = 0;
		
		/* need to prevent page faults with ints off */
		if (sys_mlock(p,sizeof(*p)) != 0)
		{
			return -EAGAIN;
		}
		
		/* actually _do_ the exchange */
		save_and_cli(flags);
		errno |= __get_user(tmp, p);
		errno |= __put_user(arg2, p);
		restore_flags(flags);
		
		/* i don't think sys_munlock can fail here, and */
		/* I wouldn't know what to do if it did, so no  */
		/* reason to pay attention to the return value  */
		sys_munlock(p,sizeof(*p));

		return tmp;
	}
#endif

comments anyone?

Joe

Maciej W. Rozycki wrote:

> On Thu, 25 Jan 2001, Joe deBlaquiere wrote:
> 
> 
>> So I've got the following code which seems to work... (I can't use the 
>> ll/sc ops on the Vr41xx since they are not implemeted!)
>> 
>> #ifdef CONFIG_CPU_VR41XX
> 
> 
>  You are perfectly correct, with the exception you really want to make it: 
> 
> #ifndef CONFIG_CPU_HAS_LLSC
> 
> as that's the correct option -- just undef it in arch/mips/config.in for
> your CPU like it's done for others already.
> 
>  Shame on me I haven't sent the patch for MIPS_ATMIC_SET for non-ll/sc
> processors yet.  I have it but it needs a few minor cleanups.
> 
>  Ralf, BTW, what do you think if we send a segfault on a memory access
> violation instead of returning an error?  That would make the behaviour of
> MIPS_ATMIC_SET consistent for any memory contents.  Does anything actually
> rely on the function to return an error in such a situation? 
> 
>   Maciej


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
