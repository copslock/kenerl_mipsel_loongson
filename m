Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQCT0v21296
	for linux-mips-outgoing; Mon, 26 Nov 2001 04:29:00 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAQCSvo21293
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 04:28:57 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAQBSt605409;
	Mon, 26 Nov 2001 22:28:55 +1100
Date: Mon, 26 Nov 2001 22:28:55 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Cross Compiler again
Message-ID: <20011126222855.D30436@dea.linux-mips.net>
References: <86048F07C015D311864100902760F1DD01B5E3DA@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E3DA@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Thu, Nov 22, 2001 at 06:13:46PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 22, 2001 at 06:13:46PM +0100, Andre.Messerschmidt@infineon.com wrote:

> > I regularly use gcc 3.0.1 to build the latest oss cvs kernels without
> > obvious incident.
> > 
> I am using a 2.4.2 Kernel from Montavista, which is not working with gcc
> 3.0.1.

General rule for the kernel is don't use gcc 3.x.  It's not only buggier
than the older compilers, it also produces worse code.  In particular it's
know to misscompile certain drivers on other architectures.  I'm still
using egcs 1.1.2 which is known to be a very solid compiler.  That may seem
to be a bit overly conservative to some; for those I recommend a compiler
derived from 2.95.3.

> Maybe it would be wise to upgrade. Does anybody know if there are any
> problems using a MIPS 5Kc with the current kernel?

Nothing that's known.

  Ralf
