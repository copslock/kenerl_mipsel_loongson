Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 14:38:01 +0000 (GMT)
Received: from www1.mail.lycos.com ([IPv6:::ffff:209.202.220.140]:33273 "HELO
	mailcity.com") by linux-mips.org with SMTP id <S8225214AbTA0OiB>;
	Mon, 27 Jan 2003 14:38:01 +0000
Received: from Unknown/Local ([?.?.?.?]) by mailcity.com; Mon, 27 Jan 2003 14:37:32 -0000
To: linux-mips@linux-mips.org, ZhouY.external@infineon.com
Date: Mon, 27 Jan 2003 09:37:32 -0500
From: "Bill Calaway" <billcalaway@lycos.com>
Message-ID: <LIEEFDLGCJJLDBAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: billcalaway@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: A problem about gprof
X-Sender-Ip: 198.45.18.20
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Return-Path: <billcalaway@mailcity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: billcalaway@lycos.com
Precedence: bulk
X-list: linux-mips

Often there are seperate precompiled versions of libraries that where compiled with profiling on.  For example, if you have glibc-profile installed you should change your -l into a -l_p.   Just a hunch, but check to see if you have a profiled version of the "e" library.

Bill Calaway
 
--

On Mon, 27 Jan 2003 15:27:16  
 ZhouY.external wrote:
>Hi dear experts,
>  In order to use the gprof in the SDE 5.02 toolchain, I compiled a program
>with '-p' option but the compiler responsed with a error. I have checked the
>startup assembly code crt0.sx. There is an address operation which need the
>address of '_ecode'. Which library has the symbol '_ecode'?  Could you give
>me a clue?
>  Thanks in advance!
>
>  Best regards,
>
>  Yidan
>
>
>PS. The following is the error messge:
>sde-gcc -O -g -mcpu=4kc -mips32 -EB -mno-float  -DGNUSIM -D__SIM
>'-Afloat(no)'
>  -I../../kit/GSIM32B/../gnusim   -c    -DMCRT0 ../../kit/share/crt0.sx -o
>mcrt0
>.o
>sde-gcc -g -p -mcpu=4kc -mips32 -EB -mno-float  -DGNUSIM -D__SIM
>'-Afloat(no)'
>  -I../../kit/GSIM32B/../gnusim   -c hello.c -o hello.o
>sde-make[1]: Entering directory `/cygdrive/c/sde/sde/kit/GSIM32B'
>sde-make[1]: Nothing to be done for `kit'.
>sde-make[1]: Leaving directory `/cygdrive/c/sde/sde/kit/GSIM32B'
>sde-gcc -mcpu=4kc -mips32 -EB -mno-float   -Ttext 80000400
>-L../../kit/GSIM32B
>../../kit/GSIM32B/ramstart.o mcrt0.o hello.o   -lc  -lram -lgcc -lc -le
>-lram -l
>c -lgcc ../../kit/GSIM32B/crtn.o -o ex1ram
>mcrt0.o: In function `__fini':
>/cygdrive/c/sde/sde/examples/helloworld/../../kit/share/crt0.sx(.text+0x60):
>und
>efined reference to `_ecode'
>/cygdrive/c/sde/sde/examples/helloworld/../../kit/share/crt0.sx(.text+0x64):
>und
>efined reference to `_ecode'
>collect2: ld returned 1 exit status
>sde-make: *** [ex1ram] Error 1
>
>
>


_____________________________________________________________
Get 25MB, POP3, Spam Filtering with LYCOS MAIL PLUS for $19.95/year.
http://login.mail.lycos.com/brandPage.shtml?pageId=plus&ref=lmtplus
