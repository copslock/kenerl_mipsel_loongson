Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 16:37:36 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.238]:25408 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039210AbXBBQhc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 16:37:32 +0000
Received: by qb-out-0506.google.com with SMTP id e12so138635qba
        for <linux-mips@linux-mips.org>; Fri, 02 Feb 2007 08:36:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MLf1c2TKqs114cF8FixPEo8CJ2CM2jqWzh9cCSZwdNZRADi8ZgUJ6z+caF9cH337pk8ixSYjF4pbD4eOsLVfG7LT4NgtWRRXZ93LyRWtZgvD0GC3DUjC0usz0XdmHc/feOEgwJx3xJQHXhluuf/i3X5dYGyXPxWt8Cp8QYbQh5Q=
Received: by 10.115.78.1 with SMTP id f1mr306594wal.1170434190630;
        Fri, 02 Feb 2007 08:36:30 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Fri, 2 Feb 2007 08:36:30 -0800 (PST)
Message-ID: <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com>
Date:	Fri, 2 Feb 2007 17:36:30 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"David Daney" <ddaney@avtrex.com>
Subject: Re: Question about signal syscalls !
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <45C3611D.7000702@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com>
	 <20070201135734.GB12728@linux-mips.org>
	 <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
	 <45C21CFE.9060804@avtrex.com>
	 <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>
	 <45C3611D.7000702@avtrex.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> sys_sigreturn does not return to the caller in the conventional sense.

I expect you're talking about this bite of code taken from _sys_sigreturn():

        /*
         * Don't let your children do this ...
         */
        __asm__ __volatile__(
                "move\t$29, %0\n\t"
                "j\tsyscall_exit"
                :/* no outputs */
                :"r" (&regs));

> The entire user context (i.e. the value of *all* registers) is replaced
> with the values stored in the sigcontext structure on the caller's
> stack.  If all registers are being restored from the sigcontext, then
> there is no need to save the current values of the registers, because
> they will never be used.
>

But I don't see where _all_ registers are saved. Only static registers
are saved by save_static_function() right before calling
_sys_sigreturn() and I agree I don't why we need to save those.

And now I'm starting to think that we don't need to save static regs in
setup_sigcontext() either...

-- 
               Franck
