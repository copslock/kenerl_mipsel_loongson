Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 13:27:45 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:52487 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226098AbVDKM1a>; Mon, 11 Apr 2005 13:27:30 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3BCROOb018903;
	Mon, 11 Apr 2005 13:27:24 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3BCROWU018902;
	Mon, 11 Apr 2005 13:27:24 +0100
Date:	Mon, 11 Apr 2005 13:27:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 1/3] fix hang on Qube2700 boot
Message-ID: <20050411122724.GU7038@linux-mips.org>
References: <20050410130635.GA20589@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410130635.GA20589@skeleton-jack>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 10, 2005 at 02:06:35PM +0100, Peter Horton wrote:

> The Qube2700 boot hangs because the old "prom" style console is
> unconditionally enabled. Drop the "prom" console code from the build. It
> would only be used if no "console=" line was supplied and in that case
> the current 8250 code defaults to using ttyS0 at 9600 anyway (assuming a
> port exists).

Ok, applied - but that leaves the unused arch/mips/cobalt/promcon.c around.
Guess it should die as well?

  Ralf
