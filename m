Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2004 20:56:19 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:53418 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225462AbULJU4O>;
	Fri, 10 Dec 2004 20:56:14 +0000
Received: from drow by nevyn.them.org with local (Exim 4.34 #1 (Debian))
	id 1Ccrnt-00053J-UI; Fri, 10 Dec 2004 15:55:54 -0500
Date: Fri, 10 Dec 2004 15:55:53 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Deepak V <vdeepak79@gmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: SIGTRAP Trace/Breakpoint Trap
Message-ID: <20041210205553.GA19358@nevyn.them.org>
References: <842f1e5f04121012074f6ddff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842f1e5f04121012074f6ddff0@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 11, 2004 at 01:37:40AM +0530, Deepak V wrote:
> Hi,
> 
>   I am using insure++ to build a multi-threaded application on RED HAT
> Linux 3.2.3-37. (Linux insurertx 2.4.21-15.0.3.ELsmp #1 SMP Tue Jun 29
> 18:04:47 EDT 2004 i686 i686 i386 GNU/Linux)
> 
>   When I am running the application in GDB I am getting a SIGTRAP signal.

Insure, whatever it is, uses SIGTRAP itself:

> #0  0xb68d4f01 in kill () from /lib/tls/libc.so.6
> #1  0xb6bd1ab8 in Insure::Debug::nativeTrap () from
> /home/kodiak/ins++/lib.linux2/libinsure.so
> #2  0xb6b518d6 in Insure::Debug::trap () from
> /home/kodiak/ins++/lib.linux2/libinsure.so
> #3  0xb6b94f3a in Insure::Object::assertionFailed () from
> /home/kodiak/ins++/lib.linux2/libinsure.so

You will have to manually pass these unexpected SIGTRAPs back to your
application.

-- 
Daniel Jacobowitz
