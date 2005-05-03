Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 May 2005 20:11:28 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:30476 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225539AbVECTLM>; Tue, 3 May 2005 20:11:12 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j43JB6Bn028121;
	Tue, 3 May 2005 20:11:06 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j43JB5Ls028120;
	Tue, 3 May 2005 20:11:05 +0100
Date:	Tue, 3 May 2005 20:11:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aaron Campbell <aaron@monkey.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: BCM91250E (Sentosa) boot problem
Message-ID: <20050503191105.GC24693@linux-mips.org>
References: <Pine.BSO.4.58.0505021414300.29936@naughty.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.58.0505021414300.29936@naughty.monkey.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 02, 2005 at 02:43:24PM -0400, Aaron Campbell wrote:

> I've checked out HEAD of the linux-mips CVS linux/ module (2.6.12-rc3) and
> my resulting kernel will not boot on my BCM91250E (Sentosa) board.  Here
> is what I get when I attempt to boot it from CFE:

Sentosa is one of the rarely exercised platforms.  After a bit of digging
the last user report about it is from past November ...

  Ralf
