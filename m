Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 16:50:53 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:16914 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038616AbXBHQus (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 16:50:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3E1AEE1CC8;
	Thu,  8 Feb 2007 17:50:03 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSWhRwFcOWXJ; Thu,  8 Feb 2007 17:50:02 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1632BE1CC1;
	Thu,  8 Feb 2007 17:50:02 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l18GoEQv031009;
	Thu, 8 Feb 2007 17:50:14 +0100
Date:	Thu, 8 Feb 2007 16:50:09 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix run_uncached warning about 32bit kernel
In-Reply-To: <20070208130744.GB10739@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0702081550360.18649@blysk.ds.pg.gda.pl>
References: <200702060159.l161xM59075711@mbox33.po.2iij.net>
 <20070206152817.GB5660@linux-mips.org> <Pine.LNX.4.64N.0702061818550.28283@blysk.ds.pg.gda.pl>
 <20070208130744.GB10739@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2538/Thu Feb  8 15:37:31 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 8 Feb 2007, Ralf Baechle wrote:

> Well, some of the warnings are also simply due to broken code.  This is
> the result of preprocessing the code without Yoichi's patch applied:
> 
> [...]
>  if (sp >= (long)0x80000000 && sp < (long)0xc0000000)
>   usp = ((((int)(int)(sp)) & 0x1fffffff) | 0xa0000000);
>  else if ((long long)sp >= (long long)(0x8000000000000000LL | ((0LL)<<59) | (0)) &&
>    (long long)sp < (long long)(0x8000000000000000LL | ((8LL)<<59) | (0)))
>   usp = (0x8000000000000000LL | (((long long)2)<<59) | ((((long long)sp) & -1)));
> 
> else {
>   do { __asm__ __volatile__("break %0" : : "i" (512)); } while (0);
>   usp = sp;
>  }
> [...]
> 
> So (0x8000000000000000LL | ((0LL)<<59) | (0)) is 0x8000000000000000LL which
> then is casted to _signed_ long long, so becomes -9223372036854775808, the
> most negative representable number so the two "comparison is always true
> due to limited range of data type" warnings are perfectly correct.

 They are neither correct nor expected.  And the problem is not 
0x8000000000000000LL being the most negative representable number, but 
"sp" being a variable of a 32-bit type and being compared against the 
constant.  In this case GCC seems to completely ignore the cast to "long 
long" and treats it as if the comparison was done between types of 
different widths.

 Try building this program:

$ cat range.c
int foo(sp_t sp)
{
	if (sp >= (long)0x80000000 && sp < (long)0xc0000000)
		return 0;
	else if ((long long)sp >= (long long)0x8000000000000000LL &&
		 (long long)sp < (long long)0xc000000000000000LL)
		return 1;
	else
		return 2;
}
$ mips64el-linux-gcc -O2 -Wall -Dsp_t=long -c range.c
$ mips64el-linux-gcc -O2 -Wall -Dsp_t=int -c range.c
range.c: In function 'foo':
range.c:3: warning: comparison is always false due to limited range of data type
range.c:3: warning: comparison is always true due to limited range of data type
range.c:5: warning: comparison is always true due to limited range of data type
range.c:6: warning: comparison is always false due to limited range of data type
$

Notice how GCC complains about both 0x8000000000000000LL and 
0xc000000000000000LL.

 I think there was a bug report associated with it -- let me see...  Yep: 
"http://gcc.gnu.org/bugzilla/show_bug.cgi?id=12963".

> Treating addresses as signed is a dangerous thing and we reallly only
> should do it where extending 32-bit addresses to 64-bit because that's
> what the architecture does.  So I would suggest as part of cleaning u the
> mess something like below totally untested patch.

 I have used signed types here on purpose not to cross to the user segment 
(positive range) accidentally.  But I do not insist on keeping them if 
they were to hurt somebody's eyes.  Your change is not going to fix the 
problem anyway -- if I change the condition in the program above to:

	else if ((unsigned long long)sp >= (unsigned long long)0x8000000000000000ULL &&
		 (unsigned long long)sp < (unsigned long long)0xc000000000000000ULL)

then unfortunately the warnings persist (I am pretty sure I did this kind 
of testing before committing these bits, to make sure the warning was 
unavoidable).

  Maciej
