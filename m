Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2004 02:50:52 +0100 (BST)
Received: from pD956226F.dip.t-dialin.net ([IPv6:::ffff:217.86.34.111]:91 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225285AbUJZBur>; Tue, 26 Oct 2004 02:50:47 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9Q1okpf026850;
	Tue, 26 Oct 2004 03:50:46 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9Q1oaGP026849;
	Tue, 26 Oct 2004 03:50:36 +0200
Date: Tue, 26 Oct 2004 03:50:36 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: socket.h patch (SOCK_XXX break glibc build)
Message-ID: <20041026015036.GA26841@linux-mips.org>
References: <20041026.101226.70226592.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026.101226.70226592.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2004 at 10:12:26AM +0900, Atsushi Nemoto wrote:

> On 2.6.9, SOCK_DGRAM, etc. in asm-mips/socket.h are visible from
> userland.  It will break glibc build.  For other archs,
> include/linux/net.h uses "#ifdef __KERNEL__" for SOCK_XXX definitions,
> so asm-mips/socket.h should use "#ifdef __KERNEL__" too?

Ok ...

   Ralf
