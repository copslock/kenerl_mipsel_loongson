Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2004 15:11:56 +0000 (GMT)
Received: from web9502.mail.yahoo.com ([IPv6:::ffff:216.136.129.132]:38821
	"HELO web9502.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225384AbUBNPLz>; Sat, 14 Feb 2004 15:11:55 +0000
Message-ID: <20040214151152.80368.qmail@web9502.mail.yahoo.com>
Received: from [128.107.253.38] by web9502.mail.yahoo.com via HTTP; Sat, 14 Feb 2004 07:11:52 PST
Date: Sat, 14 Feb 2004 07:11:52 -0800 (PST)
From: Indigodfw <indigodfw@yahoo.com>
Subject: question about memory constraint in atomic_add
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <indigodfw@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: indigodfw@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello Gurus

Question from a mips new-bie

127 extern __inline__ void atomic_add(int i, atomic_t
* v)
128 {
129         unsigned long temp;
130 
131         __asm__ __volatile__(
132                 "1:   ll      %0, %1      #
atomic_add\n"
133                 "     addu    %0, %2              
   \n"
134                 "     sc      %0, %1              
   \n"
135                 "     beqz    %0, 1b              
   \n"
136                 : "=&r" (temp), "=m" (v->counter)
137                 : "Ir" (i), "m" (v->counter));
138 }

Now I look at the input operand  v->counter
We want two things :

1. Hint the compiler that memory at (v->counter) is
modified.

2. Result of (C expression) should go into %xyz
register 
So v->counter goes into %1, IOW ll from an int!

Does not make sense to me.
Why does it work, What am I missing?

I mean in general what is the expression for a m
constraint ptr (because I want ptr to be in regiser)
or *ptr (because I wanna tell compiler that *ptr is
what gets changed) 

I hope you include me in reply as I am not subscribed
to this list. Is there anyway to check this mailing
list online

Thanks and regards



__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
