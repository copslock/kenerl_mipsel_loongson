Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 19:06:12 +0200 (CEST)
Received: from gateway08.websitewelcome.com ([69.56.170.25]:41285 "HELO
	gateway08.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492055AbZFKRGG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2009 19:06:06 +0200
Received: (qmail 13903 invoked from network); 11 Jun 2009 03:44:46 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway08.websitewelcome.com with SMTP; 11 Jun 2009 03:44:46 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:38718 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1MEb8J-0006tn-OY; Wed, 10 Jun 2009 22:39:19 -0500
Message-ID: <4A307C68.5050004@paralogos.com>
Date:	Wed, 10 Jun 2009 20:39:20 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Glyn Astill <glynastill@yahoo.co.uk>
CC:	linux-mips@linux-mips.org
Subject: Re: Qube2 slowly dies
References: <137040.69938.qm@web23605.mail.ird.yahoo.com>
In-Reply-To: <137040.69938.qm@web23605.mail.ird.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-archive-position: 23376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Your description sounds an awful lot like failures I've seen when 
interrupts get lost or blocked for some reason (could be hardware, the 
kernel, or some interaction between them).  Have you looked at 
/proc/interrupts to see if "Spurious" interrupts are occurring, or if 
the rate of serviced timer and I/O interrupts decreases or increases as 
the system degrades?  When the system becomes unresponsive, by any 
chance does it "wake up" after 10-20 minutes (the time for the Count 
register to wrap)?

If other Qube2s don't exhibit this behavior with a given Linux kernel, 
but yours does, and yet yours runs NetBSD OK, it suggests that there's a 
difference in interrupt setup/handling between the two systems that just 
happens to work around a hardware problem on your board.

          Regards,

          Kevin K.

Glyn Astill wrote:
> Hi people,
>
> I've been directed here from the Debian lists by Martin Michlmayr. I'm running lenny on a qube2 128mb ram / 40gb disk.
>
> I've tried kernels 2.6.26 and 2.6.30~rc8 and the issue I'm about to describe is present in both, I haven't tried any other kernels - but I will try 2.6.22 when I can.
>
> Essentially the machine gets more and more sluggish until it finally dies. I've had a quick look in meminfo and I can't see that it's running out of memory, and I'm not sure what else to check?
>
> I find it hard to describe what's going off, but here's a scenario I hope illustrates the problem. The configure script is just an example of doing something - I could easily have extracted an archive with tar or something for the same results;
>
> - I start 2 ssh sessions and in one start configure for the postgres source, in the other I just started top.
>
> - And for a while all seems fine; configure ticks away and top refreshes every second.
>
> - Then top stops ticking over - but it'll refresh with a keypress. Anyway I exit top and try to run it again... nothing. I hit ctrl-c which brings me back to the prompt and I try again... nothing.
>
> - The configure script is still ticking over slowly.
>
> - I try "ps ax" - it works; so I try it again... nothing.
>
> - I try "ipcs" and "lsof" they both work and seem to keep working.
>
> - I try "ps ax" again... nothing. I hit ctrl-c and now it doesn't come back to the command prompt for a while.. say 5 minutes and eventually it's back.
>
> - It's still going. Some commands still work, some just do nothing. proc/meminfo shows it's not eaten all the memory.
>
> - If I try to start another ssh session I can log in, I get the motd, but I don't get to the shell.
>
> - Eventually the configure script ends, and all shells come back to the prompt. But it now seems totally braindamaged, I can run "ps ax" but "top" and other commands still do nothing. Heres strace attached to the top process:
>
> deb:~# strace -p 7228
> Process 7228 attached - interrupt to quit
> _newselect(0, NULL, NULL, NULL, {0, 500013}
>
> - Then after a little while the whole thing becomes unresponsive.
>
>
> Can anyone confirm they've seen the same behaviour or direct me what to look into?
>
> Thanks
> Glyn
>
>
>       
>
>   
