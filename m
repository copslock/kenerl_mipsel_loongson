Received:  by oss.sgi.com id <S554235AbRBZLTr>;
	Mon, 26 Feb 2001 03:19:47 -0800
Received: from [194.90.113.98] ([194.90.113.98]:22021 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S554201AbRBZLTb>;
	Mon, 26 Feb 2001 03:19:31 -0800
Received: from jungo.com (michaels@kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id OAA18369;
	Mon, 26 Feb 2001 14:23:50 +0200
From:   michaels@jungo.com
Message-ID: <3A9A3B56.B0141D21@jungo.com>
Date:   Mon, 26 Feb 2001 13:17:42 +0200
Organization: Jungo LTD
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Keith Owens <kaos@melbourne.sgi.com>
CC:     Tom Appermont <tea@sonycom.com>, linux-mips@oss.sgi.com
Subject: Re: ELF header kernel module wrong?
References: <11701.983148650@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Keith,

If what you say is correct, then any module created by this toolchain
would be impossible to 'insmod', and that is not the case. As I said, we
have one module which we managed to install, and it was compiled with
exactly the same toolchain. The module is quite large, has a lot of
symbols, and was NOT taken from the kernel tree. I would suspect that
there is some problem with kernel module linkage that is incompatible
with mips toolchain. 

Besides that, in "old" modultils there IS a check for symtab size, and
it did work as expected. So, what you say is only part of the truth.

Keith Owens wrote:
> 
> On Sun, 25 Feb 2001 11:06:29 +0200,
> michaels@jungo.com wrote:
> >I have seen this problem too. My kernel is 2.2.14 though, using modutils
> >2.3.x.
> >I tried to do many things with modutils, tried even not to check the
> >boundary, but that caused crashes. The only solution that worked for me
> >was to step downwards to modutils 2.2.2. Even then, depmod segfaults
> >unless you put a remark on obj_free in some place... Hope you get a
> >better solution.
> 
> All you are doing by using old modutils is hiding the problem and
> risking storage corruption.  modutils follows the ELF specification
> 
>   "A symbol table section's sh_info section header member holds the
>   symbol table index for the first non-local symbol."
> 
> The mips toolchain is generating local symbols with index numbers
> greater than sh_info.  Old modutils did not check for that and silently
> created corrupt modules.  New modutils check this field for
> correctness.  Fix the mips toolchain.

-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D 
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
