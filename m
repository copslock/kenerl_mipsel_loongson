Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2002 14:20:08 +0200 (CEST)
Received: from p508B750A.dip.t-dialin.net ([80.139.117.10]:8105 "EHLO
	p508B750A.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1123396AbSJIMUH>; Wed, 9 Oct 2002 14:20:07 +0200
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S867025AbSJIMTx>; Wed, 9 Oct 2002 14:19:53 +0200
Date: Wed, 9 Oct 2002 14:19:53 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Rob Lembree <lembree@metrolink.com>
Cc: linux-mips@linux-mips.org
Subject: Re: hints on wait queue bug?
Message-ID: <20021009141953.B3611@bacchus.dhis.org>
References: <1030652956.1536.21.camel@ripple.nh.metrolink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030652956.1536.21.camel@ripple.nh.metrolink.com>; from lembree@metrolink.com on Thu, Aug 29, 2002 at 04:29:16PM -0400
X-Accept-Language: de,en,fr
Return-Path: <ralf@uni-koblenz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@uni-koblenz.de
Precedence: bulk
X-list: linux-mips

On Thu, Aug 29, 2002 at 04:29:16PM -0400, Rob Lembree wrote:

> I've got a problem where lots of io to the console seems
> to break something in the kernel, resulting in a segfault,
> along with a kernel error.
> 
> I dove into it, and found that it's related to wait queue
> stuff.  I turned on the wait queue debugging, and got the
> following, just prior to things going off the deep end.
> 
> bad magic 802ccb24 (should be 802ccb2c), kernel BUG at sched.c:729!
> 
> Is there some tutorial on this stuff somewhere (besides
> reading the code -- I'm doing that now!)  
> 
> Has this stuff changed a great deal since 2.4.5 (when this
> code last worked correctly)?

No.  Typicall such bugs are caused by memory corruption but as in your
case the magic number which is an address is only off by eight bytes
you might also consider a tool bug, so I suggest disassembling the
kernel binary and checking if it's getting initialized correctly.

  Ralf
