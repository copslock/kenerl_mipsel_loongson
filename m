Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 16:01:53 +0000 (GMT)
Received: from p508B7E65.dip.t-dialin.net ([IPv6:::ffff:80.139.126.101]:34653
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225383AbUA1QBw>; Wed, 28 Jan 2004 16:01:52 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0SG1dex016043;
	Wed, 28 Jan 2004 17:01:39 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0SG1blY016042;
	Wed, 28 Jan 2004 17:01:37 +0100
Date: Wed, 28 Jan 2004 17:01:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jes Sorensen <jes@wildopensource.com>,
	Kevin Paul Herbert <kph@cisco.com>, linux-mips@linux-mips.org
Subject: Re: Removal of ____raw_readq() and ____raw_writeq() from asm-mips/io.h
Message-ID: <20040128160137.GA15977@linux-mips.org>
References: <1075255111.8744.4.camel@shakedown> <20040128094032.GB900@kopretinka> <yq07jzcz6sp.fsf@wildopensource.com> <20040128150828.A19525@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128150828.A19525@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 28, 2004 at 03:08:28PM +0000, Ladislav Michl wrote:

> eh? I said nothing about PCI device. These ____raw_writeq are
> used in board specific code. Anyway, defining struct sb_registers
> and ioremaping it would be nice solution (I didn't read code too
> carefully, so maybye not in this particular case where registers
> are 64bit width, but I definitely prefer it in board specific code
> over read[bwl]/write[bwl]). Also readq/writeq seems mips specific,
> so rants about portability doesn't apply.

They're not MIPS specific; they're just not so common because some people
still believe 64-bit is something esotheric they don't need ;-)

Try grep -lw readq include/asm-*/io.h - 6 architectures implement it.

  Ralf
