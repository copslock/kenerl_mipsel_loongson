Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2003 13:37:52 +0100 (BST)
Received: from p508B5A26.dip.t-dialin.net ([IPv6:::ffff:80.139.90.38]:18354
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225210AbTGIMhu>; Wed, 9 Jul 2003 13:37:50 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h69Cb2DB030382;
	Wed, 9 Jul 2003 14:37:02 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h69CavDZ030381;
	Wed, 9 Jul 2003 14:36:57 +0200
Date: Wed, 9 Jul 2003 14:36:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: renwei <renwei@huawei.com>
Cc: linux-mips@linux-mips.org
Subject: Re: gdb/insight 5.3 buggy   in kernel module debug
Message-ID: <20030709123657.GA30305@linux-mips.org>
References: <003501c34526$f5adfcc0$6efc0b0a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003501c34526$f5adfcc0$6efc0b0a@huawei.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 08, 2003 at 04:00:08PM +0800, renwei wrote:

> new thead xxxxxx
>    0xffffffff83f28040 in ??()
> something like that.
> and the backtrace command can't work, also.
> but my gdb5.0 for mipsel is ok.
> 
> 
> I think that's the gdb get the pc as 64bit, but my 
> board's cpu is 32bit, so it can't get the correct pc ...
> The kernel addr is up to 0x80000000, so it's negative.

On 64-bit processors running 32-bit code the actual values in the
registers are sign-extended to 64-bit, so that behaviour of your gdb
seems right.  Fix whatever places do return a zero-extended values.

  Ralf
