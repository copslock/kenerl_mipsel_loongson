Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 21:53:11 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.184]:5750 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28576552AbXKEVxD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 21:53:03 +0000
Received: by fk-out-0910.google.com with SMTP id f40so1753014fka
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2007 13:53:02 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=inh8iKzawZia56oMbQDxyWoH94RvI7v6wBeNxKsNI80=;
        b=Ar9EFX2MyWpKmn6kgDkM4y2KMjNF9gMTCw6fHBUwd1NeOKXz02tuOAXjsrb0RR5p81UWxCqqtpSu5IC4Hp97tjkSER7Kh63bzL0xiHQIqlIX5kqi0If0cHw/No7n6EDRZ+nHRLibN3r7i4/oKCBj40OCQ0QZpR6dpLyRcAS9z4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mhOwj1nqf5cbOBnLmxrac63BOSlDjl6uMQAzTpFz4ZIzSX+Pvac2SmSp/+vz0A5azpfwL01eoc3RmpH4F5QKAju27EUzCH47LXXZToSdMGXSgktF2+zPBgg0Vz7ueDYW5x1UTYK5se5pZ0oBUguqq+gpBynMWkLUBkSYAB422II=
Received: by 10.82.114.3 with SMTP id m3mr9670823buc.1194299581591;
        Mon, 05 Nov 2007 13:53:01 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j9sm15788325mue.2007.11.05.13.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 13:53:00 -0800 (PST)
Message-ID: <472F906F.7080205@gmail.com>
Date:	Mon, 05 Nov 2007 22:51:43 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Franck Bui-Huu <fbuihuu@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Kill __bzero()
References: <472D8058.5080209@gmail.com> <20071105112429.GC27893@linux-mips.org>
In-Reply-To: <20071105112429.GC27893@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> Memset is almost always only ever invoked with a zero argument.  So the
> idea was to have something like this:
> 
> extern void *__memset(void *__s, int __c, size_t __count);
> extern void *bzero(void *__s, size_t __count);
> 
> static inline void *memset(void *s, int c, size_t count)
> {
> 	if (__builtin_constant_p(c) && c == 0) {
> 		bzero(s, count);
> 		return s;
> 	} else
> 		return __memset(s, __c, count);
> }
> 
> But that was never quite implemented like this as you noticed.

Well I'm not sure we really need this. bzero() is not part of the
Linux string API, so it can only be used by MIPS specific code. And
with the current implementation of bzero(), $a1 needs to be setup to 0
anyway. That's why I simply killed it...

BTW, can memset() be an inlined function ?

> 
> As for the differences in the return value, they're because of of
> clear_user and __clear_user which return the number of bytes that could
> _not_ be cleared in $a2.  Memset being invoked through the normal C calling
> conventions ignores this value while it's the actual result of interest for
> __clear_user.
> 

Yes I noticed this. Actually I'm wondering if we couldn't add a new
function, fill_user() like the following:

extern size_t fill_user(void __user *to, int c, size_t len);

This could be used by both memset() and clear_user():

#define memset(s,c,l)	({ (void)fill(s,c,l); s; })
#define clear_user(t,l)	fill_user(t,0,l)

Therefore the definition of clear_user() could be saner.

What do you think ?

		Franck 
