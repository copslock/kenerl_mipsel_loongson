Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 23:08:02 +0100 (BST)
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([IPv6:::ffff:63.197.226.105]:42655
	"EHLO cheetah.davemloft.net") by linux-mips.org with ESMTP
	id <S8225228AbUJTWHx>; Wed, 20 Oct 2004 23:07:53 +0100
Received: from localhost
	([127.0.0.1] helo=cheetah.davemloft.net ident=davem)
	by cheetah.davemloft.net with smtp (Exim 3.36 #1 (Debian))
	id 1CKOWk-0001Zp-00; Wed, 20 Oct 2004 15:01:50 -0700
Date: Wed, 20 Oct 2004 15:01:49 -0700
From: "David S. Miller" <davem@davemloft.net>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	discuss@x86-64.org, sparclinux@vger.kernel.org,
	linuxppc64-dev@ozlabs.org, linux-m68k@vger.kernel.org,
	linux-sh@m17n.org, linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
Message-Id: <20041020150149.7be06d6d.davem@davemloft.net>
In-Reply-To: <3506.1098283455@redhat.com>
References: <3506.1098283455@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips


David, I applaud your effort to take care of this.
However, this patch will conflict with what I've
sent into Linus already for Sparc.  I also had to
add the sys_altroot syscall entry as well.

I've mentioned several times that perhaps the best
way to deal with this problem is to purposefully
break the build of platforms when new system calls
are added.

Simply adding a:

#error new syscall entries for X and Y needed

to include/asm-*/unistd.h would handle this just
fine I think.

That way it won't be missed, and if the platform
maintainer wants to just ignore the new syscall
they can choose to do that as well.
