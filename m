Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 17:06:10 +0100 (BST)
Received: from p508B7CAD.dip.t-dialin.net ([IPv6:::ffff:80.139.124.173]:23211
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225548AbTJHQGE>; Wed, 8 Oct 2003 17:06:04 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h98G61NK019738;
	Wed, 8 Oct 2003 18:06:01 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h98G60gm019737;
	Wed, 8 Oct 2003 18:06:00 +0200
Date: Wed, 8 Oct 2003 18:06:00 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Proposed NMI handling interface...
Message-ID: <20031008160600.GA19102@linux-mips.org>
References: <3F832040.7070606@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F832040.7070606@realitydiluted.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 07, 2003 at 04:21:20PM -0400, Steven J. Hill wrote:

> I wanted to propose an NMI handling interface. I have attached
> the header file and patches to 'arch/mips/kernel/traps.c'. The
> user need only specify the offset address for the NMI vector
> code and then they can also specify their own desired NMI
> function. Comments?

That hook you're proposing isn't even necessary in generic code.  NMI
on MIPS hardware is a fairly odd type of exception - it goes straight to
0xbfc00000 which usually is a a firmware address - and lots of firmware
doesn't even offer an NMI hook.  So for those cases where it's possible,
you need to do something firmware anyway before jumping to Linux's NMI
handler.  An additional problem with the NMI design of MIPS is it's using
ErrorEPC, just like cache errors so you better pray - or simply design
systems only to rely on NMI for debugging and catastrophic failures.

  Ralf
