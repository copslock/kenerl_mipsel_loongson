Received:  by oss.sgi.com id <S554221AbRBZAwc>;
	Sun, 25 Feb 2001 16:52:32 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:33307 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S554217AbRBZAwQ>;
	Sun, 25 Feb 2001 16:52:16 -0800
Received: from sydney.sydney.sgi.com (sydney.sydney.sgi.com [134.14.48.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id QAA11195
	for <linux-mips@oss.sgi.com>; Sun, 25 Feb 2001 16:51:10 -0800 (PST)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com by sydney.sydney.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id LAA23553; Mon, 26 Feb 2001 11:50:48 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     michaels@jungo.com
cc:     Tom Appermont <tea@sonycom.com>, linux-mips@oss.sgi.com
Subject: Re: ELF header kernel module wrong? 
In-reply-to: Your message of "Sun, 25 Feb 2001 11:06:29 +0200."
             <3A98CB15.CE4DE67D@jungo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 26 Feb 2001 11:50:50 +1100
Message-ID: <11701.983148650@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 25 Feb 2001 11:06:29 +0200, 
michaels@jungo.com wrote:
>I have seen this problem too. My kernel is 2.2.14 though, using modutils
>2.3.x.
>I tried to do many things with modutils, tried even not to check the
>boundary, but that caused crashes. The only solution that worked for me
>was to step downwards to modutils 2.2.2. Even then, depmod segfaults
>unless you put a remark on obj_free in some place... Hope you get a
>better solution. 

All you are doing by using old modutils is hiding the problem and
risking storage corruption.  modutils follows the ELF specification

  "A symbol table section's sh_info section header member holds the
  symbol table index for the first non-local symbol."

The mips toolchain is generating local symbols with index numbers
greater than sh_info.  Old modutils did not check for that and silently
created corrupt modules.  New modutils check this field for
correctness.  Fix the mips toolchain.
