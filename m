Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 00:00:19 +0100 (BST)
Received: from cantor.suse.de ([IPv6:::ffff:195.135.220.2]:50073 "EHLO
	Cantor.suse.de") by linux-mips.org with ESMTP id <S8225240AbUJTXAO>;
	Thu, 21 Oct 2004 00:00:14 +0100
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id D4883DF284C;
	Thu, 21 Oct 2004 00:56:34 +0200 (CEST)
Date: Thu, 21 Oct 2004 00:56:25 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
	sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, linux-sh@m17n.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
Subject: Re: [discuss] Re: [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041020225625.GD995@wotan.suse.de>
References: <3506.1098283455@redhat.com> <20041020150149.7be06d6d.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020150149.7be06d6d.davem@davemloft.net>
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 03:01:49PM -0700, David S. Miller wrote:
> 
> David, I applaud your effort to take care of this.
> However, this patch will conflict with what I've
> sent into Linus already for Sparc.  I also had to
> add the sys_altroot syscall entry as well.
> 
> I've mentioned several times that perhaps the best
> way to deal with this problem is to purposefully
> break the build of platforms when new system calls
> are added.
> 
> Simply adding a:
> 
> #error new syscall entries for X and Y needed
> 
> to include/asm-*/unistd.h would handle this just
> fine I think.

I don't think that's a good idea.  Normally new system calls 
are relatively obscure and the system works fine without them,
so urgent action is not needed.

And I think we can trust architecture maintainers to regularly
sync the system calls with i386.

-Andi
