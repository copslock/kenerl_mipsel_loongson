Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 14:07:53 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:61200 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226106AbVDKNHj>; Mon, 11 Apr 2005 14:07:39 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3BD7XrH020606;
	Mon, 11 Apr 2005 14:07:33 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3BD7Xx5020605;
	Mon, 11 Apr 2005 14:07:33 +0100
Date:	Mon, 11 Apr 2005 14:07:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/3] fix hang on Qube2700 boot
Message-ID: <20050411130733.GC19115@linux-mips.org>
References: <20050410130635.GA20589@skeleton-jack> <20050411122724.GU7038@linux-mips.org> <425A75C2.80802@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425A75C2.80802@colonel-panic.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 11, 2005 at 02:04:02PM +0100, Peter Horton wrote:

> >Ok, applied - but that leaves the unused arch/mips/cobalt/promcon.c around.
> >Guess it should die as well?
> >
> Yep, probably. It was handy for debugging very early boot, but it's not 
> worth cluttering the tree with it.

Theese days it'd probably be a matter of days until one self-proclaimed
code police man's scripts would notice and send a patch ;-)

  Ralf
