Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36BMQr24245
	for linux-mips-outgoing; Fri, 6 Apr 2001 04:22:26 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36BMPM24242
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 04:22:25 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 179B27F8; Fri,  6 Apr 2001 13:22:24 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E6864EE92; Fri,  6 Apr 2001 13:22:14 +0200 (CEST)
Date: Fri, 6 Apr 2001 13:22:14 +0200
From: Florian Lohoff <flo@rfc822.org>
To: debian-mips@lists.debian.org
Cc: linux-mips@oss.sgi.com
Subject: Re: first packages for mipsel
Message-ID: <20010406132214.D14083@paradigm.rfc822.org>
References: <20010406130958.A14083@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010406130958.A14083@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Apr 06, 2001 at 01:09:58PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 06, 2001 at 01:09:58PM +0200, Florian Lohoff wrote:
> Hi,
> i just uploaded glibc 2.2.2 and db2 for debian-mipsel to incoming ...

BTW: This glibc uses "sysmips" for locking purposes - This means
that this lib would only work on "fixed" 2.4 kernels on ll/sc capable
machines. Its the same as for mips.

There are multiple solutions to this problem:

- ll/sc emulation in the kernel 
  Implementing an ll/sc emulation into the fast path of the illegal instruction
  handler and compile the glibc with ll/sc support.

- repair sysmips
  Sysmips is essentially broken - My fix i have sent to the linux-mips list
  is only a workaround but not a fix. Also there is currentl NO ISA I support
  in the sysmips implementation. I hope to get around to build a proper
  fix this weekend in assembly.

Probably we will do both - An even better solution would be to let the glibc
detect the ISA level or the existance of ll/sc in userspace and replace _test_and_set
with one or the other primitiv - Using sysmips on R3000 or ll/sc less systems.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
