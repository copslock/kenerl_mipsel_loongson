Received:  by oss.sgi.com id <S553665AbQLZQK3>;
	Tue, 26 Dec 2000 08:10:29 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:53999 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553650AbQLZQKI>; Tue, 26 Dec 2000 08:10:08 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S868147AbQLZQCE>;
	Tue, 26 Dec 2000 14:02:04 -0200
Date:	Tue, 26 Dec 2000 14:02:04 -0200
From:	Ralf Baechle <ralf@uni-koblenz.de>
To:	Joe deBlaquiere <jadb@redhat.com>
Cc:	the list <linux-kernel@vger.kernel.org>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: sysmips call and glibc atomic set
Message-ID: <20001226140204.D894@bacchus.dhis.org>
References: <3A46F4D8.9060605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A46F4D8.9060605@redhat.com>; from jadb@redhat.com on Mon, Dec 25, 2000 at 01:18:48AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Dec 25, 2000 at 01:18:48AM -0600, Joe deBlaquiere wrote:

> I'm working with a vr4181 target and started digging into the atomic 
> test and set stuff in the kernel and glibc. The first problem I had was 
> that the glibc code assumes that all mips III targets implement the mips 
> III ISA (funny assumption, no?) but the vr4181 doesn't include the 
> miltiprocessor oriented LL/SC operations for atomic test and set.

Ok, but since the kernel disables MIPS III you're limited to MIPS II anyway ...

> So I started looking at the glibc code (yes, I know this is the kernel 
> list... I'm getting there I promise) and notice the following operations:
> 
>    __asm__ __volatile__
>      (".set	mips2\n\t"
>       "/* Inline spinlock test & set */\n\t"
>       "1:\n\t"
>       "ll	%0,%3\n\t"
>       ".set	push\n\t"
>       ".set	noreorder\n\t"
>       "bnez	%0,2f\n\t"
>       " li	%1,1\n\t"
>       ".set	pop\n\t"
>       "sc	%1,%2\n\t"
>       "beqz	%1,1b\n"
>       "2:\n\t"
>       "/* End spinlock test & set */"
>       : "=&r" (ret), "=&r" (temp), "=m" (*spinlock)
>       : "m" (*spinlock)
>       : "memory");
> 
> The significant code here being the 'll' and 'sc' operations which are 
> supposed to ensure that the operation is atomic.
> 
> QUESTION 1) Will this _ALWAYS_ work from user land? I realize the 
> operations are temporally close, but isn't there the possibility that an 
> interrupt occurs in the meantime?

Read the ISA manual; sc will fail if the LL-bit in c0_status is cleared
which will be cleared when the interrupt returns using the eret instruction.

> Of course none of this code applies to my case anyway, since the vr4181 
> doesn't implement these ops. So once I hack^H^H^H^Hadjust glibc to use 
> the 'mips1' implementation, it uses the sysmips system call. regard :
> 
> _test_and_set (int *p, int v) __THROW
> {
>    return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
> }
> 
> So then I looked at the kernel and find the code below. The system I'm 
> working with is expressedly uniprocessor and doesn't have any swap, so 
> it looks like the initial caveats are met, but it looks to me like there 
> could be some confusion if the value of *arg1 at entry looks like 
> -ENOSYS or something like that.

Not having swap doesn't mean you're safe.  Think of any kind of previously
unmapped page.

> QUESTION 2) Wouldn't it be better to pass back the initial value of 
> *arg1 in *arg3 and return zero or negative error code?

The semantics of this syscall were previously defined by Risc/OS and later
on continued to be used by IRIX.

> 	case MIPS_ATOMIC_SET: {
> 		/* This is broken in case of page faults and SMP ...
> 		    Risc/OS faults after maximum 20 tries with EAGAIN.  */
> 		unsigned int tmp;
> 
> 		p = (int *) arg1;
> 		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
> 		if (errno)
> 			return errno;
> 		errno = 0;
> 		save_and_cli(flags);
> 		errno |= __get_user(tmp, p);
> 		errno |= __put_user(arg2, p);
> 		restore_flags(flags);
> 
> 		if (errno)
> 			return tmp;
> 
> 		return tmp;             /* This is broken ...  */
>          }
> 
> QUESTION 3) I notice that the code for this particular case of sysmips 
> has changed recently. The old code looked more like the 'll/sc' version 
> of glibc above. I would think that the 'll/sc' code would be better on 
> SMP systems.

Don't think about SMP without ll/sc.  There's algorithems available for
that but their complexity leaves them a unpractical, theoretical construct.

> Is there a good reason why this reverted?

Above code will break if the old content of memory has bit 31 set or you take
pagefaults.  The latter problem is a problem even on UP - think multi-
threading.

Finally, post such things to one of the MIPS-related mailing lists.  If
you're unlucky nobody of the MIPS'ers might see your posting on l-k.

  Ralf
