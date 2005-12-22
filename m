Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 02:30:37 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:31886 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S3466999AbVLVCaT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Dec 2005 02:30:19 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1EpGEt-00027s-00; Thu, 22 Dec 2005 03:31:31 +0100
Subject: Re: Kernel freezes in r4k_flush_icache_range() with
	CONFIG_CPU_MIPS32_R2
From:	Maxime Bizon <mbizon@freebox.fr>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.64N.0512201120010.25567@blysk.ds.pg.gda.pl>
References: <1135047438.9874.74.camel@sakura.staff.proxad.net>
	 <Pine.LNX.4.64N.0512201120010.25567@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Thu, 22 Dec 2005 03:31:31 +0100
Message-Id: <1135218691.9874.186.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Tue, 2005-12-20 at 11:47 +0000, Maciej W. Rozycki wrote:

>  FYI, GCC 3.4.4 produces the following code which is clearly wrong:

> Please file a bug report at: "http://gcc.gnu.org/bugzilla/".

Same with 3.3 and 3.2...

I'm really not familiar with inline assembly so I would appreciate that
any gcc guru here confirm instruction_hazard() code is correct before I
(or he) submit the bug report.

As the bug seems to be in all gcc versions, I guess we should find a
workaround... I changed the code to use an asm label instead of the C
label and the bug disappeared. But I'm not sure my changes are correct
for any platform other than mine...

Could anyone with the right skills help me to write a valid workaround
please ?

Here is what I have:

__asm__ __volatile__(
        "lui $2,1f\n"
        "addiu $2,1f\n"
        "jr.hb $2\n1:":: );


Thanks,

-- 
Maxime
