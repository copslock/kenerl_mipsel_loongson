Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5ODKenC028256
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 06:20:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5ODKeSt028255
	for linux-mips-outgoing; Mon, 24 Jun 2002 06:20:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5ODKYnC028251
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 06:20:35 -0700
Message-Id: <200206241320.g5ODKYnC028251@oss.sgi.com>
Received: (qmail 12679 invoked from network); 24 Jun 2002 13:09:27 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 24 Jun 2002 13:09:27 -0000
Date: Mon, 24 Jun 2002 21:22:15 +0800
From: "Zhang Fuxin" <fxzhang@ict.ac.cn>
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: sys_syscall patch.
X-mailer: Foxmail 4.1 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g5ODKZnC028252
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

======= 2002-06-24 12:24:00 you wrote��=======

>On Mon, Jun 24, 2002 at 12:06:52PM +0200, Carsten Langgaard wrote:
>
>> 
>> At least it makes my system work as well as for the 32-bit kernel.
>
>What programs btw are using syscall()?  To be honest I don't recall one ...
I used it in a userland checkpoint program to intercept syscalls.
>
>Looking more into it I found a nice showstopper - a few functions like
>_sys_sigsuspend() expect a struct pt_regs on the stack.  That's only
>working if we call those functions directly from the exception handler.
>It won't work if we have another function's stackframe - in this case
>sys_syscall()'s there also ...
>
>  Ralf

= = = = = = = = = = = = = = = = = = = =
			

Best Regards
---------------------------------------
Zhang Fuxin
System Architecture Lab
Institute of Computing Technology
Chinese Academy of Sciences,China
http://www.ict.ac.cn
 
			　　　　　　　　　2002-06-24
