Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 07:44:26 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.186]:18384 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021866AbXKFHoR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Nov 2007 07:44:17 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1361901nfd
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2007 23:44:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=RrGUCz7p4DwiQ0Kwr/vzcDShXumSIbeXEm+1JB2fxuc=;
        b=uq4HNf6RQTelvN/NtxZfbkEBeXUa3n8DUG5buLXJx3DCdakTtw5y7PXStW7mdTGTzG3hJQ0KiQUntC07nqtLbsIPYWXXPnzoU6ZjOMPkbnELKxypke6D2CihscNYg3af7LlulYSmFp7tnUu7abzsLUCAEOVcaKKLp46eDsb6XDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Tlo9mjOGmIDz5luln9G0V3GLtIpK8VVfhiwZdEw3ab/Obwf+oRz50Mpn4O9pOcgs9p49JEXpHFF0AVynkD9nlwUgYHxHzhYOQb5k2L8O3ZG3kX2GvfkKAwh4+bsqgcNcNL2C2MX6Le52z+Wd5Zbuj7nma+wkm9xhR9oMUywJ55I=
Received: by 10.86.51.2 with SMTP id y2mr4122683fgy.1194335047595;
        Mon, 05 Nov 2007 23:44:07 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 13sm13690421fks.2007.11.05.23.44.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 23:44:06 -0800 (PST)
Message-ID: <47301AF8.2000700@gmail.com>
Date:	Tue, 06 Nov 2007 08:42:48 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Kill __bzero()
References: <472D8058.5080209@gmail.com> <20071105112429.GC27893@linux-mips.org> <472F906F.7080205@gmail.com> <20071105231818.GA18820@linux-mips.org>
In-Reply-To: <20071105231818.GA18820@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Nov 05, 2007 at 10:51:43PM +0100, Franck Bui-Huu wrote:
> 
>>> Memset is almost always only ever invoked with a zero argument.  So the
>>> idea was to have something like this:
>>>
>>> extern void *__memset(void *__s, int __c, size_t __count);
>>> extern void *bzero(void *__s, size_t __count);
>>>
>>> static inline void *memset(void *s, int c, size_t count)
>>> {
>>> 	if (__builtin_constant_p(c) && c == 0) {
>>> 		bzero(s, count);
>>> 		return s;
>>> 	} else
>>> 		return __memset(s, __c, count);
>>> }
>>>
>>> But that was never quite implemented like this as you noticed.
>> Well I'm not sure we really need this. bzero() is not part of the
>> Linux string API, so it can only be used by MIPS specific code. And
>> with the current implementation of bzero(), $a1 needs to be setup to 0
>> anyway. That's why I simply killed it...
>>
>> BTW, can memset() be an inlined function ?
> 
> It can be anything, macro, inline or outline function.  In the kernel
> there are fewer restrictions than for a standards compliant library in
> userspace.
> 
> You may take the i386 implementation in include/asm-x86/string_32.h as
> an extreme example.
> 
> Older gcc used to generate significantly worse code for inline functions
> than for macros so Linux became a fairly excessive user of macros.  This
> has very much improved since, so these days inlines are prefered over
> macros where possible.

Yes but ISTR that gcc generates some calls to memset and since
builtin functions are disabled the final link failed if memset
is inlined. I'll try to reproduce...

> 
>> Yes I noticed this. Actually I'm wondering if we couldn't add a new
>> function, fill_user() like the following:
>>
>> extern size_t fill_user(void __user *to, int c, size_t len);
> 
> That's much better function name than the old __bzero - except that

Actually I named it '__fill_user', since it doesn't call access_ok().

> __bzero effectivly took a long argument for the 2nd argument so 32-bit
> on 32-bit kernels and 64-bit on 64-bit kernels.

Isn't size_t meaning ?

Perhaps in this case __kernel_size_t is better...

> 
>> This could be used by both memset() and clear_user():
>>
>> #define memset(s,c,l)	({ (void)fill(s,c,l); s; })
>> #define clear_user(t,l)	fill_user(t,0,l)
>>
>> Therefore the definition of clear_user() could be saner.
> 
> Looks alot nicer that way though an inline is probably preferable as
> expressed above.
> 

Yes I have a patchset which clean up a bit uaccess.h and does this but
it's under construction.  It actually tries to convert all macros into
inlines and the file is much more readable and as a bonus side we could
easily add __must_check annotations which are currently missing.

I'll try to finish it this week but in the meantime can we just kill
__bzero or do you want me to include it in the future patchset ?

		Franck
