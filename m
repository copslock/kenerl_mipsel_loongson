Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2005 18:15:00 +0000 (GMT)
Received: from p3EE07C4A.dip.t-dialin.net ([IPv6:::ffff:62.224.124.74]:5149
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbVBISOq>; Wed, 9 Feb 2005 18:14:46 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j19IEjFu005962;
	Wed, 9 Feb 2005 19:14:45 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j19IEib7005961;
	Wed, 9 Feb 2005 19:14:44 +0100
Date:	Wed, 9 Feb 2005 19:14:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
Message-ID: <20050209181444.GB5740@linux-mips.org>
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org> <42072264.6000001@schenk.isar.de> <20050208001742.GA15336@linux-mips.org> <42088CFA.6090605@schenk.isar.de> <420A2F2D.8050404@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420A2F2D.8050404@schenk.isar.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 09, 2005 at 04:41:33PM +0100, Rojhalat Ibrahim wrote:

> Those messages actually go away when I do not
> define cpu_has_64bit_gp_regs, which is strange
> because the RM9000 definitely has 64bit gp regs.
> Any ideas?

cpu_has_64bit_gp_regs is meant to indicate "CPU has 64-bit registers and
it's actually safe to use them".  This is why it's defined as 0 for all
32-bit kernels where an interrupt would corrupt the upper 32-bits which
we don't save during any kind of exception.

  Ralf
