Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 00:25:20 +0100 (BST)
Received: from cantor.suse.de ([IPv6:::ffff:195.135.220.2]:43181 "EHLO
	Cantor.suse.de") by linux-mips.org with ESMTP id <S8225230AbUJTXZP>;
	Thu, 21 Oct 2004 00:25:15 +0100
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 7AE5BDF2150;
	Thu, 21 Oct 2004 01:25:14 +0200 (CEST)
Date: Thu, 21 Oct 2004 01:25:09 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, dhowells@redhat.com, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
	sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, linux-sh@m17n.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
Subject: Re: [discuss] Re: [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041020232509.GF995@wotan.suse.de>
References: <3506.1098283455@redhat.com> <20041020150149.7be06d6d.davem@davemloft.net> <20041020225625.GD995@wotan.suse.de> <20041020160450.0914270b.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020160450.0914270b.davem@davemloft.net>
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 04:04:50PM -0700, David S. Miller wrote:
> On Thu, 21 Oct 2004 00:56:25 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > I don't think that's a good idea.  Normally new system calls 
> > are relatively obscure and the system works fine without them,
> > so urgent action is not needed.
> > 
> > And I think we can trust architecture maintainers to regularly
> > sync the system calls with i386.
> 
> I disagree quite strongly.  One major frustration for users of
> non-x86 platforms is that functionality is often missing for some
> time that we can make trivial to keep in sync.

I'm not sure really if the users of some embedded platform
are all sheering for key management system calls...

I guess they will prefer just something that compiles.

> 
> I religiously watch what goes into Linus's tree for this purpose,
> but that is kind of a rediculious burdon to expect every platform
> maintainer to do.  It's not just system calls, we have signal handling
> bug fixes, trap handling infrastructure, and now the nice generic
> IRQ handling subsystem as other examples.

Most of that is optional. When the arch maintainer choses not to
use it you have just unnecessarily  broken the build.

IMHO breaking the build unnecessarily is extremly bad because
it will prevent all testing. And would you really want to hold
up the whole linux testing machinery just for some obscure 
system call? IMHO not a good tradeoff.

> 
> Simply put, if you're not watching the tree in painstaking detail
> every day, you miss all of these enhancements.

I would assume the other maintainers go at least from time to 
time through the i386 diffs and check if they miss anything
(that is what I do). For system calls they do definitely, although
it may take some time.

> 
> The knowledge should come from the person putting the changes into
> the tree, therefore it gets done once and this makes it so that
> the other platform maintainers will find out about it automatically
> next time they update their tree.

And causing merging headaches and all kind of other problems.

-Andi
