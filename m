Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 15:34:51 +0000 (GMT)
Received: from p3EE2BD6B.dip.t-dialin.net ([IPv6:::ffff:62.226.189.107]:64336
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224934AbVBNPeh>; Mon, 14 Feb 2005 15:34:37 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1EFYZSA001709
	for <linux-mips@linux-mips.org>; Mon, 14 Feb 2005 16:34:35 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j1EFYZ1k001708
	for linux-mips@linux-mips.org; Mon, 14 Feb 2005 16:34:35 +0100
Date:	Mon, 14 Feb 2005 16:34:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050214153435.GD806@linux-mips.org>
References: <20050214035304Z8225242-1340+3175@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214035304Z8225242-1340+3175@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 14, 2005 at 03:53:03AM +0000, macro@linux-mips.org wrote:

> Modified files:
> 	arch/mips64/kernel: Tag: linux_2_4 scall_o32.S 
> 
> Log message:
> 	Gas no longer supports redefining macros.

Bulletproofing 2.4 against newer tools is something that only makes limited
sense, especially wrt. to gcc 3.4 and newer.  Chances for any such changes
to be accepted upstream are slim - and the kernel has traditionally been
easily affected by overoptimization, so I recommend against gcc 3.4.  The
recommended compiler for 2.4 is still gcc 2.95.3 but except gcc 3.0 upto
gcc 3.3 is reasonable and can be considered well tested.

  Ralf
