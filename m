Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 00:48:02 +0200 (CEST)
Received: from gateway03.websitewelcome.com ([69.93.139.30]:56247 "HELO
	gateway03.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492438AbZFWWr4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2009 00:47:56 +0200
Received: (qmail 8797 invoked from network); 23 Jun 2009 22:49:43 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway03.websitewelcome.com with SMTP; 23 Jun 2009 22:49:43 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:45894 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1MJEjB-00041u-Ft; Tue, 23 Jun 2009 17:44:33 -0500
Message-ID: <4A415ACD.8010102@paralogos.com>
Date:	Tue, 23 Jun 2009 15:44:29 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Kaz Kylheku <KKylheku@zeugmasystems.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Silly 100% CPU behavior on a SIG_IGN-ored SIGBUS.
References: <DDFD17CC94A9BD49A82147DDF7D545C501C35128@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C501C35128@exchange.ZeugmaSystems.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Kaz Kylheku wrote:
> Hi all,
>
> On kernel 2.6.26, glibc 2.5 (n32), SiByte SB-1 core, the following
> program goes into 100% CPU, chewing up about 80% kernel time and
> 20% user.
>
> #include <stdio.h>
> #include <signal.h>
>
> int main(void)
> {
>   int *deadbeef = (int *) 0xdeadbeef;
>   signal(SIGBUS, SIG_IGN);
>   printf("*deadbeef == %d\n", *deadbeef);
>   return 0;
> }
>
> If any fatal exception is ignored, the program should be killed
> if that exception happens. 100% CPU is not a useful response.
>   
It's not a useful program, so what did you expect?   One might argue 
that it would be more useful or correct to have the kernel advance the 
PC to not endlessly repeat the doomed load, but ignoring SIG_IGN and 
silently killing the thread violates the signal API as I've always 
understood it.

          Regards,

          Kevin K.
