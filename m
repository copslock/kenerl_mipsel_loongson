Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2008 12:58:03 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:41376 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20045778AbYGGL55 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jul 2008 12:57:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m67Busbf028148;
	Mon, 7 Jul 2008 12:57:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m67Burlc028147;
	Mon, 7 Jul 2008 12:56:53 +0100
Date:	Mon, 7 Jul 2008 12:56:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Declare some pci variables in header file
Message-ID: <20080707115653.GA28127@linux-mips.org>
References: <20080419.005346.85684007.anemo@mba.ocn.ne.jp> <20080704.005940.108121109.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080704.005940.108121109.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 04, 2008 at 12:59:40AM +0900, Atsushi Nemoto wrote:

> On Sat, 19 Apr 2008 00:53:46 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > Declare pci_probe_only, etc. in asm-mips/pci.h file.  This will fix
> > some sparse warnings.
> 
> Revesed against current linux-queue tree.

Thanks, queued for 2.6.27.

  Ralf
