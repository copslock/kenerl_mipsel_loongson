Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2004 13:22:48 +0100 (BST)
Received: from p508B68D7.dip.t-dialin.net ([IPv6:::ffff:80.139.104.215]:1572
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225428AbUFAMP1>; Tue, 1 Jun 2004 13:15:27 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i51CFPSZ026555;
	Tue, 1 Jun 2004 14:15:25 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i51CFKY8026554;
	Tue, 1 Jun 2004 14:15:20 +0200
Date: Tue, 1 Jun 2004 14:15:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org,
	debian-toolchain@lists.debian.org
Subject: Re: TLS register
Message-ID: <20040601121520.GB25718@linux-mips.org>
References: <20040531230524.GB2785@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531230524.GB2785@bogon.ms20.nix>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5231
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 31, 2004 at 08:05:24PM -0300, Guido Guenther wrote:

> Hi,
> Now that gcc 3.4 has incompatible ABI changes (on o32 mostly affecting
> mipsel) I've been discussing with Thiemo if I'd be the right point to
> take this ABI change as a possibility to additionally reserve a TLS
> register. 
> He suggested $24 (t8) another discussed possibility would be $27 (k1)
> which is already abused by the PS/2 folks for ll/sc emulation.
> Another possibility would be to reserve such a register only in the
> n32/n64 ABIs and let o32 stay without __thread and TLS forever.

Sigh, we'e been through this really often enough.  Reserving a register
comes at a price so my approach was to implement a fast path in the
exception code.  I've benchmarked that long time ago; it had less than
half the overhead than normal syscall and such a function would be subject
to normal code optimizations so calls should be few only.  Alpha already
does something similar using their PAL code.

  Ralf
