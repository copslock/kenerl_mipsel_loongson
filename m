Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2003 14:09:10 +0000 (GMT)
Received: from p508B7812.dip.t-dialin.net ([IPv6:::ffff:80.139.120.18]:18824
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225206AbTCJOJJ>; Mon, 10 Mar 2003 14:09:09 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2AE93228176;
	Mon, 10 Mar 2003 15:09:03 +0100
Date: Mon, 10 Mar 2003 15:09:03 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jon Burgess <Jon_Burgess@eur.3com.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Struct sigaction cleanup
Message-ID: <20030310150903.A28104@linux-mips.org>
References: <80256CE5.00390ADA.00@notesmta.eur.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <80256CE5.00390ADA.00@notesmta.eur.3com.com>; from Jon_Burgess@eur.3com.com on Mon, Mar 10, 2003 at 10:22:56AM +0000
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 10, 2003 at 10:22:56AM +0000, Jon Burgess wrote:

> > Further no known libc implementation making use of sa_restorer.
> 
> I don't know if this is relevant, but Linus recently tried
> changing the sa_restorer behaviour in the linux-2.5 kernel and
> later had to back out the change. The following lines are from
> recent changelogs:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.1/0344.html
> Linux-2.5.55:
> Move x86 signal handler return stub to the vsyscall page, and stop
>     honoring the SA_RESTORER information.
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.1/1884.html
> Linux-2.5.57:
> Re-instate the SA_RESTORER functionality, since it seems that some
>     programs still depend on it and in fact do install a different
>     signal restorer than the standard kernel version.

Doesn't look relevant to us because installing requires custom assembler
code for each architecture or other non-portable constructs.  It seems
nothing on MIPS was ever actually using sa_restorer or SA_RESTORER.

  Ralf
