Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Dec 2003 17:17:23 +0000 (GMT)
Received: from mail.jlokier.co.uk ([IPv6:::ffff:81.29.64.88]:21124 "EHLO
	mail.shareable.org") by linux-mips.org with ESMTP
	id <S8225451AbTLNRRO>; Sun, 14 Dec 2003 17:17:14 +0000
Received: from mail.shareable.org (localhost [127.0.0.1])
	by mail.shareable.org (8.12.8/8.12.8) with ESMTP id hBEHGccT028987;
	Sun, 14 Dec 2003 17:16:38 GMT
Received: (from jamie@localhost)
	by mail.shareable.org (8.12.8/8.12.8/Submit) id hBEHGbjB028985;
	Sun, 14 Dec 2003 17:16:37 GMT
Date: Sun, 14 Dec 2003 17:16:37 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Peter Horton <pdh@colonel-panic.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031214171637.GA28923@mail.shareable.org>
References: <20031213114134.GA9896@skeleton-jack> <20031213222626.GA20153@mail.shareable.org> <Pine.LNX.4.58.0312131740120.14336@home.osdl.org> <20031214103803.GA916@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031214103803.GA916@skeleton-jack>
User-Agent: Mutt/1.4.1i
Return-Path: <jamie@shareable.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@shareable.org
Precedence: bulk
X-list: linux-mips

Peter Horton wrote:
> I've seen code written for X86 use MAP_FIXED to create self wrapping
> ring buffers. Surely it's better to fail the mmap() on other archs
> rather than for the code to fail in unexpected ways?

Such code should test the buffers or just not create ring buffers on
architectures it doesn't know about.  (You can usually simulate them
by copying data).  On some architectures there is _no_ alignment which
works, and even on x86 aligning aliases to 32k results in faster
memory accesses on some chips (AMD ones).

Also, sometimes a self wrapping ring buffer can work even when the
separation isn't coherent, provided the code using it forces cache
line flushes at the appropriate points.

-- Jamie
