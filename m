Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Aug 2004 03:18:28 +0100 (BST)
Received: from bak5.mail2000.com.tw ([IPv6:::ffff:210.200.181.242]:3859 "HELO
	bak5.mail2000.com.tw") by linux-mips.org with SMTP
	id <S8225242AbUHYCSX> convert rfc822-to-8bit; Wed, 25 Aug 2004 03:18:23 +0100
Received: from 210.200.181.211
	by bak5.mail2000.com.tw with Mail2000 ESMTP Server V2.71S(369:0:AUTH_RELAY)
	Wed, 25 Aug 2004 10:18:06 +0800 (CST);
	(envelope-from <macleod@mail2000.com.tw>)
Received: By OpenMail Mailer;Wed, 25 Aug 2004 10:18:04 +0800 (CST)
From: "Macleod" <macleod@mail2000.com.tw>
Reply-To: macleod@mail2000.com.tw
Subject: Re: System call select on R4600
Message-ID: <1093400284.64232.macleod@mail2000.com.tw>
To: linux-mips@linux-mips.org
Date: Wed, 25 Aug 2004 10:18:04 +0800 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Return-Path: <macleod@mail2000.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macleod@mail2000.com.tw
Precedence: bulk
X-list: linux-mips


 After trace system, found this problem is from scall_o32.S
 line 161 in 2.4.26 kernel.

 bltz t0, bad_stack   # -> sp is bad

 If stack address larger than 0x7fffffff, branch will take, 
 and that's why I got "-4142" errno on select system call
 even parameters in stack are correct. I tried to remove this
 line and seems "select" works fine.


-----Original message-----
From:Ralf Baechle <ralf@linux-mips.org>
To:Macleod <macleod@mail2000.com.tw>
Cc:linux-mips@linux-mips.org
Date:Sun, 22 Aug 2004 14:14:36 +0200
Subject:Re: System call select on R4600

On Sun, Aug 22, 2004 at 11:54:10AM +0800, Macleod wrote:

>  My problem is "select" system call always return -1
>  and errno is -4142, but sys_select has never been called.
>  Think, it has some problem on handling system call. 
>  Because if I change SYS(sys_select, 5) to 4 arguments,
>  sys_select will be executed. 
>  Thanks!

This is a bug which was fixed a while ago.  I assume your application
is picking up a bad definition from an old kernel header package or so.
Still doing syscalls directly is a fragily; better avoid and use your
libc's select(3).

  Ralf
