Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 21:45:07 +0100 (BST)
Received: from p508B7A8B.dip.t-dialin.net ([IPv6:::ffff:80.139.122.139]:46974
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbUHTUpC>; Fri, 20 Aug 2004 21:45:02 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7KKingX014406;
	Fri, 20 Aug 2004 22:44:49 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7KKillb014405;
	Fri, 20 Aug 2004 22:44:47 +0200
Date: Fri, 20 Aug 2004 22:44:47 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Tim Lai <tinglai@gmail.com>, Eric DeVolder <eric.devolder@amd.com>,
	linux-mips@linux-mips.org
Subject: Re: problem with prefetch in user space
Message-ID: <20040820204447.GA14260@linux-mips.org>
References: <e2eac65704081716345c78b7c6@mail.gmail.com> <41235841.6090105@amd.com> <e2eac65704081808061f27cb5a@mail.gmail.com> <20040818153148.GI23756@rembrandt.csv.ica.uni-stuttgart.de> <e2eac657040818094264dc6a3b@mail.gmail.com> <20040818171342.GN23756@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818171342.GN23756@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 18, 2004 at 07:13:42PM +0200, Thiemo Seufer wrote:

> Something like:
> 
>         __asm__ __volatile__(
> 		".set push\n"
> 		".set mips4\n"
> 		"pref " PREF_OP ", 0(%0)\n"
> 		".set pop\n"
> 		: "=r" (addr));
> 
> For more information: "info gcc" and the kernel sources.

A few years ago somebody wrote a nice howto on inline assembler that also
contains all the architecture specifics.  Should be possible to track it
down via your favorite search engine.

  Ralf
