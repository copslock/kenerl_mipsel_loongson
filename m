Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2005 19:00:04 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:24332 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225312AbVFUR7n>; Tue, 21 Jun 2005 18:59:43 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5LHxbST024133;
	Tue, 21 Jun 2005 18:59:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5LHxaTe024132;
	Tue, 21 Jun 2005 18:59:36 +0100
Date:	Tue, 21 Jun 2005 18:59:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	maxim@mox.ru
Cc:	linux-mips@linux-mips.org
Subject: Re: strace n64 support
Message-ID: <20050621175936.GN6461@linux-mips.org>
References: <6097c4905062110482288b0a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6097c4905062110482288b0a8@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 21, 2005 at 09:48:55PM +0400, Maxim Osipov wrote:

> I was looking at strace-4.5.12 and noticed, that
> linux/mips/syscallent.h has syscall numbers only for o32. Are n32 and
> n64 supported? Google doesn't help ;(

Strace is currently somewhat broken anyway.  I'm looking into getting it
going, so thanks for letting me know.

  Ralf
