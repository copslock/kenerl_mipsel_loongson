Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 14:54:20 +0000 (GMT)
Received: from p508B619B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.155]:64311
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225322AbUBMOyU>; Fri, 13 Feb 2004 14:54:20 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1DErJex023880;
	Fri, 13 Feb 2004 15:53:19 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1DErGeV023879;
	Fri, 13 Feb 2004 15:53:16 +0100
Date: Fri, 13 Feb 2004 15:53:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040213145316.GA23810@linux-mips.org>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 13, 2004 at 03:20:27PM +0100, Maciej W. Rozycki wrote:

> 2. It changes inline-assembly function prologues to be embedded within the
> functions, which makes them a bit safer as they can now explicitly refer
> to the "regs" struct and assures the code won't be removed or reordered.

It is possible that gcc changes one of the registers before save_static
and I can't imagine there's a reliable way to fix this in the inline
version.

  Ralf
