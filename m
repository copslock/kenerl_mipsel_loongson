Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0JJ0CT07944
	for linux-mips-outgoing; Sat, 19 Jan 2002 11:00:12 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0JJ07P07937
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 11:00:08 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0JHxtt28113;
	Sat, 19 Jan 2002 17:59:55 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.2/8.11.2) id g0JCE1p01203;
	Sat, 19 Jan 2002 12:14:01 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15433.25352.345698.244662@gladsmuir.algor.co.uk>
Date: Sat, 19 Jan 2002 12:14:00 +0000
To: drepper@redhat.com (Ulrich Drepper)
Cc: "H . J . Lu" <hjl@lucon.org>,
   GNU libc hacker <libc-hacker@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <m34rlj4gb2.fsf@myware.mynet>
References: <m3elkoa5dw.fsf@myware.mynet>
	<20020118101908.C23887@lucon.org>
	<m3elkn4ikq.fsf@myware.mynet>
	<20020118110844.A25165@lucon.org>
	<m34rlj4gb2.fsf@myware.mynet>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Well, just about k0/k1:

So far as the hardware and instruction set is concerned, 
k0/k1 are just two of the 32 general purpose registers.  There's
nothing special about them and a program in user mode can read/write
them.

By a mere software convention, they're reserved.  But this is an
important software convention, because MIPS hardware does so little to
help out on an exception or interrupt.  Couple that to the lack of any
absolute addressing mode, and any exception handler pretty much has to
have a GP register it can write without saving, in order to be able to
point to the register-save area.

[You could, maybe, do something tricky with a negative offset
from the (constant zero) $0 register and special mapping]

OK, so that's one of them.  The second is used to reduce the length
and run-time of the tiny exception handler which is used to refill the
TLB when a page translation is not loaded.

The OS doesn't rely on user programs not corrupting these registers,
of course: it typically uses them only in non-interruptible code
sequences.  But since the OS changes them under the feet of user
programs, the convention that you don't use them is pretty strongly
enforced.

Dominic Sweetman
Algorithmics Ltd
