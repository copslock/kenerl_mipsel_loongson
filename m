Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2008 22:12:18 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:34713 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28576151AbYFNVMP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 14 Jun 2008 22:12:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5ELBr7C012824;
	Sat, 14 Jun 2008 22:11:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5ELBr8Z012823;
	Sat, 14 Jun 2008 22:11:53 +0100
Date:	Sat, 14 Jun 2008 22:11:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Horsten <thomas@horsten.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [BUG] R5000 failure in kmap_coherent on Lasat board, bug that
	has been there for a while?
Message-ID: <20080614211153.GC4897@linux-mips.org>
References: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk> <20080614125903.GA483@linux-mips.org> <5d932cdc0806141408y5d5407e8oab329686ecb25566@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d932cdc0806141408y5d5407e8oab329686ecb25566@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 14, 2008 at 10:08:27PM +0100, Thomas Horsten wrote:

> 2008/6/14 Ralf Baechle <ralf@linux-mips.org>:
> 
> > Only compile tested - can you try this one?
> 
> Looks like it did the trick! Well done, Jedi Master!

Cool, will commit then.

The change I made was done to every other caller of kmap_coherent before.
I wrongly thought in case of local_r4k_flush_cache_page it wasn't needed.

  Ralf
