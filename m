Received:  by oss.sgi.com id <S553967AbRAHIGo>;
	Mon, 8 Jan 2001 00:06:44 -0800
Received: from [194.90.113.98] ([194.90.113.98]:54276 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S553964AbRAHIG1>;
	Mon, 8 Jan 2001 00:06:27 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id LAA21266;
	Mon, 8 Jan 2001 11:09:41 +0200
Message-ID: <3A59748C.BB3D5A2F@jungo.com>
Date:   Mon, 08 Jan 2001 10:04:28 +0200
From:   Michael Shmulevich <michaels@jungo.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Compiling MILO on big-emdian
References: <Pine.GSO.3.96.1010105214251.9384G-100000@delta.ds2.pg.gda.pl> <3A588C36.771FFC16@jungo.com> <20010107170528.A870@bacchus.dhis.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf,

Thank you for reply.
I wonder if I can take the initialization routines from it to use in my
custom flash bootloader?
I do not mean "cut & paste" bu rather ideas. I need a loader that will copy
the kernel with a
ramdisk from flash to ram and start the kernel. I saw that there is
something similar in milo.

By the way, how do supported machines boot nowadays? Lilo?

Thanks,
michael.

Ralf Baechle wrote:

> On Sun, Jan 07, 2001 at 05:33:10PM +0200, Michael Shmulevich wrote:
>
> > I was compiling a milo-0.27 lately on i586 machine for mips32 platform.
>
> The answer is easy - don't use Milo; it's not used since a loooong time
> for any of the supported systems anymore.
>
>   Ralf
