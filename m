Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g43NMXwJ032754
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 3 May 2002 16:22:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g43NMXjV032753
	for linux-mips-outgoing; Fri, 3 May 2002 16:22:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g43NMVwJ032750
	for <linux-mips@oss.sgi.com>; Fri, 3 May 2002 16:22:31 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g43NNbJ27414;
	Fri, 3 May 2002 16:23:37 -0700
Date: Fri, 3 May 2002 16:23:37 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: what is the right behavior of copy_to_user(0x0, ..., ...)?
Message-ID: <20020503162337.A27366@dea.linux-mips.net>
References: <3CD3052B.1050400@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3CD3052B.1050400@mvista.com>; from jsun@mvista.com on Fri, May 03, 2002 at 02:46:19PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 03, 2002 at 02:46:19PM -0700, Jun Sun wrote:

> When running LTP, I notice that recent kernel has a kernel access fault:
> 
> <1>Unable to handle kernel paging request at virtual address 00000000, epc
> == 80273860, ra == 80205aa4

Well, decode the oops message.  The question is what is at 0x80273860?

  Ralf
