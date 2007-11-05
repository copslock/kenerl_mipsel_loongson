Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 23:18:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:39094 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577428AbXKEXSV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 23:18:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA5NIIqR024424;
	Mon, 5 Nov 2007 23:18:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA5NIIjL024423;
	Mon, 5 Nov 2007 23:18:18 GMT
Date:	Mon, 5 Nov 2007 23:18:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Franck Bui-Huu <fbuihuu@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Kill __bzero()
Message-ID: <20071105231818.GA18820@linux-mips.org>
References: <472D8058.5080209@gmail.com> <20071105112429.GC27893@linux-mips.org> <472F906F.7080205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472F906F.7080205@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 05, 2007 at 10:51:43PM +0100, Franck Bui-Huu wrote:

> > Memset is almost always only ever invoked with a zero argument.  So the
> > idea was to have something like this:
> > 
> > extern void *__memset(void *__s, int __c, size_t __count);
> > extern void *bzero(void *__s, size_t __count);
> > 
> > static inline void *memset(void *s, int c, size_t count)
> > {
> > 	if (__builtin_constant_p(c) && c == 0) {
> > 		bzero(s, count);
> > 		return s;
> > 	} else
> > 		return __memset(s, __c, count);
> > }
> > 
> > But that was never quite implemented like this as you noticed.
> 
> Well I'm not sure we really need this. bzero() is not part of the
> Linux string API, so it can only be used by MIPS specific code. And
> with the current implementation of bzero(), $a1 needs to be setup to 0
> anyway. That's why I simply killed it...
> 
> BTW, can memset() be an inlined function ?

It can be anything, macro, inline or outline function.  In the kernel
there are fewer restrictions than for a standards compliant library in
userspace.

You may take the i386 implementation in include/asm-x86/string_32.h as
an extreme example.

Older gcc used to generate significantly worse code for inline functions
than for macros so Linux became a fairly excessive user of macros.  This
has very much improved since, so these days inlines are prefered over
macros where possible.

> Yes I noticed this. Actually I'm wondering if we couldn't add a new
> function, fill_user() like the following:
> 
> extern size_t fill_user(void __user *to, int c, size_t len);

That's much better function name than the old __bzero - except that
__bzero effectivly took a long argument for the 2nd argument so 32-bit
on 32-bit kernels and 64-bit on 64-bit kernels.

> This could be used by both memset() and clear_user():
> 
> #define memset(s,c,l)	({ (void)fill(s,c,l); s; })
> #define clear_user(t,l)	fill_user(t,0,l)
> 
> Therefore the definition of clear_user() could be saner.

Looks alot nicer that way though an inline is probably preferable as
expressed above.

  Ralf
