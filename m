Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 09:03:35 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:48067 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225073AbUJUIDa>;
	Thu, 21 Oct 2004 09:03:30 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i9L83QMp025787;
	Thu, 21 Oct 2004 10:03:26 +0200 (MEST)
Date: Thu, 21 Oct 2004 10:03:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@davemloft.net>
cc: Andi Kleen <ak@suse.de>, dhowells@redhat.com,
	Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	discuss@x86-64.org, sparclinux@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, linux-m68k@vger.kernel.org,
	linux-sh@m17n.org, linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [discuss] Re: [PATCH] Add key management syscalls to non-i386
 archs
In-Reply-To: <20041020164144.3457eafe.davem@davemloft.net>
Message-ID: <Pine.GSO.4.61.0410211002020.614@waterleaf.sonytel.be>
References: <3506.1098283455@redhat.com> <20041020150149.7be06d6d.davem@davemloft.net>
 <20041020225625.GD995@wotan.suse.de> <20041020160450.0914270b.davem@davemloft.net>
 <20041020232509.GF995@wotan.suse.de> <20041020164144.3457eafe.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Oct 2004, David S. Miller wrote:
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

Please do so! And not only for syscalls, but also for other things.

That way we can procmail all mails sent to lkml or bk-commits-head that
add #warnings to arch/<arch>/ or include/asm-<arch>/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
