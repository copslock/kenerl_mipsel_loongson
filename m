Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 03:03:37 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:37773 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225483AbUBWDDe>; Mon, 23 Feb 2004 03:03:34 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Av6NM-0003ew-00; Sun, 22 Feb 2004 21:03:20 -0600
Message-ID: <40396D75.7090405@realitydiluted.com>
Date:	Sun, 22 Feb 2004 22:03:17 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>
CC:	Eric Christopher <echristo@redhat.com>,
	Mark and Janice Juszczec <juszczec@hotmail.com>,
	linux-mips@linux-mips.org
Subject: Re: r3000 instruction set
References: <Law10-F39hgbi1Kigvf000046ac@hotmail.com> <1077477186.3636.34.camel@dzur.sfbay.redhat.com> <001001c3f98e$2270dcc0$10eca8c0@grendel>
In-Reply-To: <001001c3f98e$2270dcc0$10eca8c0@grendel>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> 
> The 3900 family should run MIPS I code compiled for the R3000.
>
Yep.

> The 3912 has no FPU, but if you're running on any contemporary
> MIPS/Linux kernel and library system, you neither need nor want
> soft-float.  The kernel does FP instruction emulation.  Running soft-float
> would make for faster, if larger, code, but requires that the whole
> system, particularly glibc, be built for soft-float, which is rarely done
> (and the last time I tried it, didin't quite work with the standard
> glibc sources out-of-the-box). 
> 
Correct. I use the FP emulator in Linux for my TX3917/PR31700 stuff. I
have had no problems. Current glibc has assembly code that assumes hardware
floating point which is why building for soft-float does not work out of
the box. There are probably some patches out there to rectify that. My
personal choice, use uClibc (http://uclibc.org/) for your C runtime. I wrote
the dynamic linker loader for MIPS and would highly recommend you try it out.
I would really like to see more testing of it.

Also, I have some documents for the 3912 on my FTP site:

    ftp://ftp.realitydiluted.com/docs/Toshiba
    ftp://ftp.realitydiluted.com/docs/Philips

It should be noted that the Toshiba TX3912 and the Philips PR31700 are
identical cores. There was definitely some cross-licensing going on there.
Perhaps Kevin or Dominic would know this in more detail, but it is not
really that important.

-Steve
