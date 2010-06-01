Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 12:28:32 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59417 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492446Ab0FAK22 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Jun 2010 12:28:28 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o51ASNMN020098;
        Tue, 1 Jun 2010 11:28:24 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o51ASMem020096;
        Tue, 1 Jun 2010 11:28:22 +0100
Date:   Tue, 1 Jun 2010 11:28:22 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
Message-ID: <20100601102822.GA20578@linux-mips.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
 <20100530153939.GA22352@merkur.ravnborg.org>
 <20100530231954.GA318@linux-mips.org>
 <20100531102954.GA12669@linux-mips.org>
 <20100531105550.GA15995@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100531105550.GA15995@merkur.ravnborg.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 26955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 243

On Mon, May 31, 2010 at 12:55:50PM +0200, Sam Ravnborg wrote:

> > I played with it for a bit.  The warning is present in all gcc 4.1.0 to
> > 4.1.2 and it is bogus.  When I first looked into this years ago I just
> > gave up on gcc 4.1 as a newer version was already available.
> > 
> > The variable returned by get_user is undefined in case of an error, so
> > what get_user() is doing is entirely legitimate.  This is different from
> > copy_from_user() which in case of an error will clear the remainder of
> > the destination area which couldn't not be copied from userspace.
> 
> What I looked at:
> 
> 1)	u32 word;
> 2)	if (unlikely(get_user(word, header)))
> 3)		word = 0;
> 4)	if (word == magic.cmp)
> 5)		return PAGE_SIZE;
> 
> If gcc does not see an assignment to word in line 2) then
> it complains about the use line 4).
> 
> If we look at the implementation of get_user it is more or less the
> following:
> ({
> 	int err = -EFAULT;
> 	if (access_ok(VERIFY_READ, header))
> 		switch (sizeof(word)) {
> 		case 4:
> 			word = *(u32 *)header;
> 			err = 0;
> 			break;
> 		default:
> 			__get_user_unknown();
> 			break;
> 		}
> 	err;
> })
> 
> Simplified a lot - I know. But it shows my point.
> (And simplifying the code also helped me understand the macros).
> 
> gcc needs to be smart enough to deduce that we always return != 0
> in the cases where word is not assigned - in which case line 3)
> will do the assignment.
> 
> So gcc is indeed wrong when is sas "uninitialized" but considering
> the complexity of these macros I think it is excused.
> 
> The x86 version has the following assignment
> 
>     (val) = (__typeof__(*(addr))) __gu_tmp; 
> 
> unconditionally - so they avoid the " = 0" thing.
> sparc has explicit "= 0" assignments.
> 
> So refactoring the macros may do the trick too.
> But I do not think it is worth the effort.

One reason for the being written as they are is also that this allows a
compiler to generate some useful warnings such as:

	get_user(var, ptr);
	printk("var is %d\n", var);

Where var indeed can be used uninitialzed.  The return value of get_user()
being ignored is really a separate problem which should be attacked as
well.  __must_check would be the obvious way of doing this but it can only
be used as a function attribute.  Will have to experiment to see if it's
possible to use it within get_user / put_user in something like:

static inline int __must_check __gu_must_check(int __gu_err)
{
	return __gu_err
}

#define __get_user_check(x, ptr, size)                                  \
({                                                                      \
        int __gu_err = -EFAULT;                                         \
        const __typeof__(*(ptr)) __user * __gu_ptr = (ptr);             \
                                                                        \
        might_fault();                                                  \
        if (likely(access_ok(VERIFY_READ,  __gu_ptr, size)))            \
                __get_user_common((x), size, __gu_ptr);                 \
                                                                        \
        __gu_must_check(__gu_err);					\
})

  Ralf
