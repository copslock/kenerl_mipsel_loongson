Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jan 2004 19:44:05 +0000 (GMT)
Received: from p508B6B8A.dip.t-dialin.net ([IPv6:::ffff:80.139.107.138]:10377
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225317AbUABToE>; Fri, 2 Jan 2004 19:44:04 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i02Ji3a5031863;
	Fri, 2 Jan 2004 20:44:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id i02Ji3j6031862;
	Fri, 2 Jan 2004 20:44:03 +0100
Date: Fri, 2 Jan 2004 20:44:03 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: access_ok and CONFIG_MIPS32 for 2.6
Message-ID: <20040102194403.GB31092@linux-mips.org>
References: <20040102145941.GA13426@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102145941.GA13426@sonycom.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 02, 2004 at 03:59:41PM +0100, Dimitri Torfs wrote:

>   the mask used in access_ok to check the validity of an address range
>   evaluates to -TASK_SIZE for user processes. In case of
>   CONFIG_MIPS32, TASK_SIZE is defined as 0x7fff8000UL, so -TASK_SIZE
>   evaluates to 0x80008000, making access_ok return false for all
>   addresses with bit 15 and 31 set. Surely the mask should be 0x80000000. 
> 
>   Does anybody know why TASK_SIZE is set to 0x7fff8000 and not
>   0x80000000 ?

There is a weird special case were 32-bit code running on a 64-bit kernel
with c0_status.ux set will behave differently than on a 32-bit processor
or with c0_status.ux clear.  The workaround for 64-bit kernels is to
leave the top 32kB of the 2GB user virtual address space unused.  For
sake of symmetry we do this on both 32-bit and 64-bit kernels.

  Ralf
