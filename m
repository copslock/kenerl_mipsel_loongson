Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBVGgKC05808
	for linux-mips-outgoing; Mon, 31 Dec 2001 08:42:20 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBVGgFg05801
	for <linux-mips@oss.sgi.com>; Mon, 31 Dec 2001 08:42:16 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBVDTrn25939;
	Mon, 31 Dec 2001 11:29:53 -0200
Date: Mon, 31 Dec 2001 11:29:53 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Lennert Buytenhek <buytenh@gnu.org>, rth@dot.cygnus.com,
   linux-arm-kernel@lists.arm.linux.org.uk, dev-etrax@axis.com,
   linux-ia64@linuxia64.org, linux-m68k@lists.linux-m68k.org,
   linux-mips@oss.sgi.com, grundler@cup.hp.com, cort@fsmlabs.com,
   linux-390@vm.marist.edu, gniibe@mri.co.jp, sparclinux@vger.kernel.org,
   ultralinux@vger.kernel.org, jdike@karaya.com
Subject: Re: [Linux-ia64] [PATCH][RFC][CFT] remove global errno from the kernel, make _syscallX kernel-only
Message-ID: <20011231112953.A25924@dea.linux-mips.net>
References: <20011230220500.A10224@gnu.org> <je3d1ra60s.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <je3d1ra60s.fsf@sykes.suse.de>; from schwab@suse.de on Mon, Dec 31, 2001 at 02:11:31PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 31, 2001 at 02:11:31PM +0100, Andreas Schwab wrote:

> |> Please CC me on replies as I'm not on any of the lists posted to.
> |> 
> |> My intention is to push these to Linus for 2.5 if everyone agrees.
> |> They're probably too intrusive for 2.4 (although I'd love people
> |> to convince me otherwise).
> 
> I wouldn't mind putting it into 2.4.

While it may break things in userspace it will hopefully ensure correctness
for userspace, so better kill 'em now than later.  _syscallX() has a too
long history of causing problems.

  Ralf
