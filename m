Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2EFoMY07799
	for linux-mips-outgoing; Thu, 14 Mar 2002 07:50:22 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2EFoF907788
	for <linux-mips@oss.sgi.com>; Thu, 14 Mar 2002 07:50:15 -0800
Message-Id: <200203141550.g2EFoF907788@oss.sgi.com>
Received: (qmail 27112 invoked from network); 14 Mar 2002 15:58:28 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 14 Mar 2002 15:58:28 -0000
Date: Thu, 14 Mar 2002 23:52:54 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Kjeld Borch Egevang <kjelde@mips.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: FPU inexact flag always set for dynamic programs
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g2EFoF907789
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
>Is there something in /lib/ld.so.1 that invalidates the FP csr?
  maybe,
  I believe the root of problem is we don't clear used_math
for new execed processes so they inherit fpu contents from their
parent. 
  Several days ago i posted a little patch to correct it,so your problem
doesn't occurs here any more. but it seems Ralf doesn't accept it.Maybe
you can try it.
 

ÔÚ 2002-03-14 14:52:00 you wrote£º
>Hi all.
>
>I've discovered that the inexact bit is always set at startup for a 
>program. My test program fenvtest.c:
>
>#include <fenv.h>
>#include <stdio.h>
>
>int main()
>{
>        int retval;
>
>        retval = fetestexcept(FE_ALL_EXCEPT);
>        printf("%d\n", retval);
>        return 0;
>}
>
>And when I run:
>
>cc -o fenvtest fenvtest.c -lm
>../fenvtest 
>
>I get:
>
>4
>
>and:
>
>cc -o fenvtest fenvtest.c -lm -static
>../fenvtest
>
>I get:
>
>0
>
>Is there something in /lib/ld.so.1 that invalidates the FP csr?
>
>
>/Kjeld
>
>-- 
>_    _ ____  ___                       Mailto:kjelde@mips.com
>|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
>| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
>  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
>                    Denmark            http://www.mips.com/

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
