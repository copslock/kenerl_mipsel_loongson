Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 12:37:50 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:63774 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226023AbVDDLhP>; Mon, 4 Apr 2005 12:37:15 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j34Bb4bc009362;
	Mon, 4 Apr 2005 12:37:04 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j34Bb3VP009360;
	Mon, 4 Apr 2005 12:37:03 +0100
Date:	Mon, 4 Apr 2005 12:37:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Ulrich Eckhardt <eckhardt@satorlaser.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: conflicting declaration of prom_getcmdline()
Message-ID: <20050404113703.GA8538@linux-mips.org>
References: <200504011028.04244.eckhardt@satorlaser.com> <20050404062105.GA4975@linux-mips.org> <Pine.LNX.4.62.0504041318590.14107@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504041318590.14107@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 04, 2005 at 01:20:15PM +0200, Geert Uytterhoeven wrote:

> IIRC, there are architectures (alpha?) where __init does matter for prototypes
> because a different jump type is used depending on the sections of the caller
> and callee.

MIPS gcc doesn't do such optimizations - and we'd expect no advantage from
it either because the range of R_MIPS_26 relocations used for jump
instructions is 256MB - unless somebody hits the special case where this
256MB boundary is going straight through the kernel in which case
-mlong-jump would be required anyway, __init or not.

  Ralf
