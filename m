Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBQLhWJ26353
	for linux-mips-outgoing; Wed, 26 Dec 2001 13:43:32 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBQLhSX26342
	for <linux-mips@oss.sgi.com>; Wed, 26 Dec 2001 13:43:28 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBP6fPR16989;
	Tue, 25 Dec 2001 04:41:25 -0200
Date: Tue, 25 Dec 2001 04:41:25 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: an old FPU context corruption problem when signal happens
Message-ID: <20011225044125.A16759@dea.linux-mips.net>
References: <3C21390A.FA23978D@mvista.com> <3C219A3B.6DA93A75@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C219A3B.6DA93A75@mips.com>; from carstenl@mips.com on Thu, Dec 20, 2001 at 08:58:51AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 20, 2001 at 08:58:51AM +0100, Carsten Langgaard wrote:

> Are you sure this hasn't been fix in the latest sources (2.4.16) ?
> I have send a patch to Ralf, which I believe solves a similar problem as
> you describe below.
> 
> Ralf have you applied the patch ?

Well, I applied it but it's really broken as something can be.  Just an
example:

+       /* 
+        * FPU emulator may have it's own trampoline active just
+        * above the user stack, 16-bytes before the next lowest
+        * 16 byte boundary.  Try to avoid trashing it.
+        */
+       sp -= 32;

So the whole thing needs some overhaul.

  Ralf
