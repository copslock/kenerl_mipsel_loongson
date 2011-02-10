Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 00:23:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47599 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491172Ab1BJXXC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 00:23:02 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p1ANNgM4017865;
        Fri, 11 Feb 2011 00:23:42 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1ANNfOJ017861;
        Fri, 11 Feb 2011 00:23:41 +0100
Date:   Fri, 11 Feb 2011 00:23:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mikael Starvik <mikael.starvik@axis.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Highmem in architechtures with cache alias
Message-ID: <20110210232340.GA13731@linux-mips.org>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D055C60823A4F@xmail3.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D055C60823A4F@xmail3.se.axis.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@duck.linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2011 at 10:02:34AM +0100, Mikael Starvik wrote:

> It is clearly stated in http://www.linux-mips.org/wiki/Highmem that the
> MIPS kernel can´t user highmem on machines with cache aliasing and I
> understand the reason. So, what is the solution here? Switch to 16k
> pages? Or are there other ways to get more memory on a machine with cache
> aliases?

This is an implementation restriction.  I did the original MIPS highmem
work in early 2002 for a company which didn't want to be the first through
the 64-bit minefield; I was using a Sibyte Swarm evaluation board back then
and its SB1 cores happen not to have aliases so I was able to take a few
short cuts.

For many years after this virtually everybody was wise enough to go for
64-bit hardware and kernel for large memory systems so interest in
removing this restriction only came up like last year.

16k pages are probably a good idea anyway; in most cases they provide a
significant performance boost.  Details depend on the exact workload.

However I should mention that the combination of page sizes other than 4k
with highmem also is untested afaics.

The solution for the alias problem is the right mix of cacheflushes at
the right places and a strategy to avoid aliases where possible - business
as usual.  ARM already supports highmem with aliases.

  Ralf
