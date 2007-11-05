Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 11:24:48 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37023 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029888AbXKELYq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 11:24:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA5BOTV9028519;
	Mon, 5 Nov 2007 11:24:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA5BOT0r028518;
	Mon, 5 Nov 2007 11:24:29 GMT
Date:	Mon, 5 Nov 2007 11:24:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Kill __bzero()
Message-ID: <20071105112429.GC27893@linux-mips.org>
References: <472D8058.5080209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472D8058.5080209@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 04, 2007 at 09:18:32AM +0100, Franck Bui-Huu wrote:

>   1/ Its unconventional prototype is error prone: its prototype is
>   the same as memset one but was documented by mips_ksym.c like the
>   following:
> 
> 	   extern void *__bzero(void *__s, size_t __count);
> 
>   2/ For the caller, it makes no difference to call memset instead
>   since it has to setup the second parameter of __bzero to 0.
> 
>   3/ It's not part of the Linux user access API, so no module can use
>   it.
> 
>   4/ It needs to be exported with EXPORT_SYMBOL and therefore consumes
>   some extra bytes.
> 
>   5/ It has only one user.
> 
> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> ---
> 
>  I'm wondering if I'm missing something, because this function seems
>  so ugly and useless in the first place, that I can't refrain to
>  submit a patch to get rid of it.

Memset is almost always only ever invoked with a zero argument.  So the
idea was to have something like this:

extern void *__memset(void *__s, int __c, size_t __count);
extern void *bzero(void *__s, size_t __count);

static inline void *memset(void *s, int c, size_t count)
{
	if (__builtin_constant_p(c) && c == 0) {
		bzero(s, count);
		return s;
	} else
		return __memset(s, __c, count);
}

But that was never quite implemented like this as you noticed.

As for the differences in the return value, they're because of of
clear_user and __clear_user which return the number of bytes that could
_not_ be cleared in $a2.  Memset being invoked through the normal C calling
conventions ignores this value while it's the actual result of interest for
__clear_user.

I hope that explains things a little.

  Ralf
