Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 01:11:02 +0100 (BST)
Received: from cantor.suse.de ([IPv6:::ffff:195.135.220.2]:206 "EHLO
	Cantor.suse.de") by linux-mips.org with ESMTP id <S8225240AbUJUAK6>;
	Thu, 21 Oct 2004 01:10:58 +0100
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 0C464DF4C10;
	Thu, 21 Oct 2004 02:10:54 +0200 (CEST)
Date: Thu, 21 Oct 2004 02:10:42 +0200
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
Message-ID: <20041021001041.GI995@wotan.suse.de>
References: <3506.1098283455@redhat.com> <20041020150149.7be06d6d.davem@davemloft.net> <20041020225625.GD995@wotan.suse.de> <20041020160450.0914270b.davem@davemloft.net> <20041020232509.GF995@wotan.suse.de> <20041020164144.3457eafe.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020164144.3457eafe.davem@davemloft.net>
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 04:41:44PM -0700, David S. Miller wrote:
> On Thu, 21 Oct 2004 01:25:09 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > IMHO breaking the build unnecessarily is extremly bad because
> > it will prevent all testing. And would you really want to hold
> > up the whole linux testing machinery just for some obscure 
> > system call? IMHO not a good tradeoff.
> 
> Then change the unistd.h cookie from "#error" to a "#warning".  It
> accomplishes both of our goals.

#warnings would be fine for me.

-Andi
