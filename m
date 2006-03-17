Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 17:26:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53180 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133407AbWCQRZ5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 17:25:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2HHZL2n012988;
	Fri, 17 Mar 2006 17:35:21 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2HHZL6s012987;
	Fri, 17 Mar 2006 17:35:21 GMT
Date:	Fri, 17 Mar 2006 17:35:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 1480: "bad address" instead of "argument list too"
Message-ID: <20060317173521.GA12862@linux-mips.org>
References: <20060317165629.GX18750@deprecation.cyrius.com> <20060317170242.GA13850@linux-mips.org> <20060317172127.GZ18750@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317172127.GZ18750@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 17, 2006 at 05:21:27PM +0000, Martin Michlmayr wrote:

> * Ralf Baechle <ralf@linux-mips.org> [2006-03-17 17:02]:
> > Chances are this is caused by the return value of some syscall.  Can you
> > use strace on a shell to isolate it?
> 
> I tried, but I don't know how.  "strace echo *" immediately gives a
> "bad address" because the wildcard is evaluated before strace is
> invoked.  How can I call strace in this case?

Log into a second shell from another tty, find out the PID of the first
shell.  Then do an strace -ff -v -p <PID of first shell> in the second
shell, go back to the first shell and do your echo *.  You now should
have the interesting bits of the log in the second window.

> > Is this 32-bit software on a 64-bit kernel?

There remain corner cases to be fixed in that emulation layer even though
it's good enough for general use since a long time.

  Ralf
