Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OC3inC026885
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 05:03:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OC3i4h026884
	for linux-mips-outgoing; Mon, 24 Jun 2002 05:03:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-145.ka.dial.de.ignite.net [62.180.196.145])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OC3dnC026881
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 05:03:41 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5OC43J28193;
	Mon, 24 Jun 2002 14:04:03 +0200
Date: Mon, 24 Jun 2002 14:04:03 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: sys_syscall patch.
Message-ID: <20020624140403.B28145@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020624133501.22509K-100000@delta.ds2.pg.gda.pl> <00ee01c21b77$18522510$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00ee01c21b77$18522510$10eca8c0@grendel>; from kevink@mips.com on Mon, Jun 24, 2002 at 02:02:49PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 02:02:49PM +0200, Kevin D. Kissell wrote:

> While I agree that rpc.lockd should directly invoke the desired
> system call if possible, having an indirect system call mechanism
> is something that has proved useful to me in the past on other
> Unices, and I would rather see it fixed than discarded.

The question is not wheather to drop this mechnism - we can't anyway for
compatibility reasons - but if a kernel or userspace implementation is
preferable for the future.

  Ralf
