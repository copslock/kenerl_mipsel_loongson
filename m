Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Aug 2004 17:03:14 +0100 (BST)
Received: from p508B6A77.dip.t-dialin.net ([IPv6:::ffff:80.139.106.119]:55881
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225238AbUHXQDK>; Tue, 24 Aug 2004 17:03:10 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7OG39vX024553;
	Tue, 24 Aug 2004 18:03:09 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7OG34sV024449;
	Tue, 24 Aug 2004 18:03:04 +0200
Date: Tue, 24 Aug 2004 18:03:04 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Valdis.Kletnieks@vt.edu
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] 2.6.9-rc1 - #ifdef cleanip for MIPS
Message-ID: <20040824160304.GA23826@linux-mips.org>
References: <200408241352.i7ODqf73026463@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408241352.i7ODqf73026463@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 24, 2004 at 09:52:41AM -0400, Valdis.Kletnieks@vt.edu wrote:

> Cleaning up some #if to use #ifdef instead, to make life safer for compiling
> with -Wundef.

Thanks, applied.

  Ralf
