Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 07:22:44 +0100 (BST)
Received: from ftp.linux-mips.org ([IPv6:::ffff:62.254.210.162]:10715 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225406AbTIXGWm>; Wed, 24 Sep 2003 07:22:42 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8O6MBXP025207;
	Tue, 23 Sep 2003 23:22:11 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8O6MAA9025206;
	Tue, 23 Sep 2003 23:22:10 -0700
Date: Tue, 23 Sep 2003 23:22:09 -0700
From: Ralf Baechle <ralf@linux-mips.org>
To: ?$B9uDE ?$B4pLo <mips4700@yahoo.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: mips inline asm question
Message-ID: <20030924062209.GA24923@linux-mips.org>
References: <20030924060456.11903.qmail@web2307.mail.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924060456.11903.qmail@web2307.mail.yahoo.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 24, 2003 at 03:04:56PM +0900, ?$B9uDE ?$B4pLo wrote:

> The following code is from
> linux-2.4.20/include/asm-mips/mipsregs.h.
> Could anyone tell how the difference between %z0 ("Jr")
> and %0 ("r") is?
> I compiled this code and deassemble the object, but I
> can't find any 
> difference with my toolchains(gcc-2.95.3, binutils-2.11).
> 
> static inline void set_context(unsigned long val)
> {
>         __asm__ __volatile__(
>                 ".set push\n\t"
>                 ".set reorder\n\t"
>                 "mtc0 %z0, $4\n\t"
>                 ".set pop"
>                 : : "Jr" (val));
> }

%z0 is just like %0 except if %0 has the value of 0 the compiler will insert
register $0.  "Jr" mean the compiler can either use a register or the
constant zero.  Both combined mean the compiler will not waste a real
register but use $zero.

  Ralf
