Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 17:51:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2968 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133494AbWFHQvg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2006 17:51:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k58GpahI017159;
	Thu, 8 Jun 2006 17:51:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k58GpaAT017158;
	Thu, 8 Jun 2006 17:51:36 +0100
Date:	Thu, 8 Jun 2006 17:51:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Joseph S. Myers" <joseph@codesourcery.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: N32 sigset and __COMPAT_ENDIAN_SWAP__
Message-ID: <20060608165136.GA17152@linux-mips.org>
References: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 08, 2006 at 01:36:29AM +0000, Joseph S. Myers wrote:

Interesting that a bug of this sort manages to survive for that long.
I guess it is proof that barely anybody is using 64-bit little endian,
yet we're cursed to support it.

  Ralf
