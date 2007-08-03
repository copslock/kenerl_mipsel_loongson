Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 13:51:27 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.185]:5823 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023878AbXHCMvV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Aug 2007 13:51:21 +0100
Received: by fk-out-0910.google.com with SMTP id f40so715908fka
        for <linux-mips@linux-mips.org>; Fri, 03 Aug 2007 05:51:21 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CkCgBkEtTaryEtiBr9zBHlRi6G78rwOcF0yjb5iQYOkrdB6Qx+bffGSvx+otXR7EGKQVvb6+td1V7oES9pPycnY2zC6XJniAzRg4vbC1upSCHSTNa82oxPheXGQZ8L79tdKnpUsoSNpkt77fBmWpysBXAj0Zi5Urf7OHFqaQ86c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pEebOiQoCExvWeFfk8Ig6NMbBx6GfGZQ9R+fPESb5P7QHNAvDTIMPTbI6LOJwJXJidU7HuPsE8p/qJ03ICH5Lo+cWJ9OWfSU9+lTNxicMv9xNNhIc3ToYg1MYIev/kxfdgQ4NjWTbAe4RiYwIqvYJFA77VZ+8Q3R8/fl7Q5Xcmo=
Received: by 10.82.175.17 with SMTP id x17mr3862583bue.1186145481097;
        Fri, 03 Aug 2007 05:51:21 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Fri, 3 Aug 2007 05:51:21 -0700 (PDT)
Message-ID: <40378e40708030551i35ab13d8ladbb167bf4ab8eef@mail.gmail.com>
Date:	Fri, 3 Aug 2007 14:51:21 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Context switches & interrupts affecting cache?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070803124023.GA16519@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40378e40708030359h3729e4b1m5390c258b29d6ae0@mail.gmail.com>
	 <20070803124023.GA16519@linux-mips.org>
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/3/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Aug 03, 2007 at 12:59:41PM +0200, Mohamed Bamakhrama wrote:
>
> > Hi all,
> > I have one question regarding context switches between user and kernel
> > modes and interrupts. Do they invalidate the I-cache or D-cache?
>
> Never on MIPS.
>
> I call an architecture that would require a cacheflush for such a
> context switch totally broken and yes, they exist - but nothing from
> the MIPS family.

Thanks Ralf for your reply.
The problem that I face now is that the lock works only when I lock
the I-cache lines *just* before calling the function OR when I lock
the code and execute it with all interrupts disabled (via
local_irq_save() & restore()). I always do the lock with interrupts
disabled, but the strange thing is that it works only when the lock is
*close* enough to the code and in my case "close" means just before
calling it :-(
That's why I was wondering if the kernel is doing something strange
with the I-cache such as invalidation on interrupts or other events.

Greetings,

--
Mohamed
