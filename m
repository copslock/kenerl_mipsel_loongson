Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f72Clne15565
	for linux-mips-outgoing; Thu, 2 Aug 2001 05:47:49 -0700
Received: from dea.waldorf-gmbh.de (u-206-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.206])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f72ClkV15554
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 05:47:47 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f72Bffs24638;
	Thu, 2 Aug 2001 13:41:41 +0200
Date: Thu, 2 Aug 2001 13:41:41 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Lars Munch Christensen <c948114@student.dtu.dk>
Cc: linux-mips@oss.sgi.com
Subject: Re: Remote debug Malta
Message-ID: <20010802134141.D24305@bacchus.dhis.org>
References: <20010801132233.A12343@tuxedo.skovlyporten.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010801132233.A12343@tuxedo.skovlyporten.dk>; from c948114@student.dtu.dk on Wed, Aug 01, 2001 at 01:22:33PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 01, 2001 at 01:22:33PM +0200, Lars Munch Christensen wrote:

> As I have mentioned previously on this list, I'm writing
> a small mips64 microkernel for the malta board. The malta
> has a remote gdb interface in YAMON, but I have not succeeded
> in remote debugging my kernel yet. Is there a recommended
> gdb version that I should use to debug mips64 code?
> 
> I have got it as far as downloading the kernel and jumping to the
> kernel entry, but from there I'm only able to execute the
> program, but not single step or anything else. 

Checkout arch/mips/kernel/gdb-* in the Linux kerne; it's all you need in
your OS.  Assuming your code is also GPL transplanting should be doable
very quickly.

  Ralf

PS: I assume you're microkernel is Linux otherwise we'd be off-topic here :-)
