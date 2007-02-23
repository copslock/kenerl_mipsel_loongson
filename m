Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 03:07:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:35979 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038841AbXBWDHr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 03:07:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1N36lC3008196;
	Fri, 23 Feb 2007 03:06:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1N36jse008195;
	Fri, 23 Feb 2007 03:06:45 GMT
Date:	Fri, 23 Feb 2007 03:06:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	sathesh babu <sathesh_edara2003@yahoo.co.in>,
	Rajat Jain <rajat.noida.india@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: unaligned access
Message-ID: <20070223030645.GA1349@linux-mips.org>
References: <80178.32924.qm@web7903.mail.in.yahoo.com> <01fc01c75693$195858b0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fc01c75693$195858b0$10eca8c0@grendel>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 22, 2007 at 04:06:57PM +0100, Kevin D. Kissell wrote:

> Default behavior in MIPS is to silently fix up and emulate.  A MIPS-specific
> system call (sys_sysmips with the command argument of MIPS_FIXADE
> and a parameter agument of zero) allows for this to be overridden, so that 
> such accesses will be fatal.  It looks as if there was once support to log the events 
> to syslog, independently of whether or not they were fixed up, but it doesn't look to me 
> as if that still works in 2.6.x kernels.

There used to be a configuration option to allow logging which was a
leftover from the times when I implemented the unaligned emulation.  I
did never find it useful later on, so I removed that in almost 9 years
ago and nobody missed it since :-)

But I don't mind putting it back, controllable by sysctl if there is any
demand for it.

  Ralf
