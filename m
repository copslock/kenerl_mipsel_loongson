Received:  by oss.sgi.com id <S42337AbQITA0F>;
	Tue, 19 Sep 2000 17:26:05 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:45642 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42234AbQITAZq>; Tue, 19 Sep 2000 17:25:46 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id RAA03224
	for <linux-mips@oss.sgi.com>; Tue, 19 Sep 2000 17:32:31 -0700 (PDT)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA10582; Wed, 20 Sep 2000 11:24:25 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Brady Brown <bbrown@ti.com>
cc:     SGI news group <linux-mips@oss.sgi.com>
Subject: Re: ELF/Modutils problem 
In-reply-to: Your message of "Tue, 19 Sep 2000 18:03:08 MDT."
             <39C7FEBC.5DB355A2@ti.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 20 Sep 2000 11:24:25 +1100
Message-ID: <1289.969409465@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 19 Sep 2000 18:03:08 -0600, 
Brady Brown <bbrown@ti.com> wrote:
>I'm having trouble getting modutils 2.3.10 to work on a little endian
>MIPS box running a 2.4.0-test3 kernel. I am cross compiling the kernel
>and modules on an i386 using egcs1.0.3a-2 and binutils2.8.1-1. It
>appears that the symbol table format in the ELF file created by
>mipsel-linux-gcc during a module build is incorrect.
>
>As I read the ELF 1.1 spec - all symbols with STB_LOCAL bindings should
>precede all other symbols (weak and global) in the symbol table.

modutils 2.3.11 includes a sanity check on the number of local symbols
precisely because of this MIPS problem.  I agree with you that mips gcc
is violating the ELF standard, 2.3.11 just detects this and issues an
error message instead of overwriting memory but gcc needs to be fixed.
BTW, you might want to upgrade to modutils >= 2.3.15, there are some
MIPS patches in modutils 2.3.15.
