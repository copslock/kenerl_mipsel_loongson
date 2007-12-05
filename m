Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 19:14:13 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:36331 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20031581AbXLETOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 19:14:11 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB5JCAcV012671;
	Wed, 5 Dec 2007 19:12:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB5JC8fR012670;
	Wed, 5 Dec 2007 19:12:08 GMT
Date:	Wed, 5 Dec 2007 19:12:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Manuel Lauss <manuel.lauss@fh-hagenberg.at>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Alchemy: fix interrupt routing
Message-ID: <20071205191208.GA12547@linux-mips.org>
References: <200712051908.18780.sshtylyov@ru.mvista.com> <4756D42E.9040609@fh-hagenberg.at> <20071205182353.GC10697@linux-mips.org> <4756F494.8090207@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4756F494.8090207@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 05, 2007 at 09:57:24PM +0300, Sergei Shtylyov wrote:

>    It works:

> 41 total events, 5.109 events/sec

That's the expected behaviour, good.

One of the remaining problems on some platforms with tickless kernels is
that not all clocksource / clockevent driver combinations are playing
nicely with each other.  You can switch the clocksource driver manually
at runtime.  First let's see what clocksource we have:

  # cd /sys/devices/system/clocksource/clocksource0/
  # cat available_clocksource 
  MIPS pit jiffies 
  # cat current_clocksource 
  MIPS 

MIPS is the CP0 count register.  pit is the i8259 and jiffies simply counts
interrupts like in the old days so has problems with lost timer interrupts
and generally not such a great idea for tickless.  You should be able to
switch between all these drivers by something like:

  # echo jiffies > current_clocksource
  Time: jiffies clocksource has been installed.
  #

Try switching between all the available clocksources a few times to see if
that's working right also.

   Ralf
