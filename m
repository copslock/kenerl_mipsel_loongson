Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 17:28:47 +0100 (BST)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:3971
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226834AbVGRQ23>; Mon, 18 Jul 2005 17:28:29 +0100
Received: (qmail 20472 invoked from network); 18 Jul 2005 16:30:07 -0000
Received: from unknown (HELO ?192.168.1.107?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 18 Jul 2005 16:30:06 -0000
Subject: Re: Support for (au1100) 64-bit physical address space broken on
	2.6.12?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20050718161949.GB28995@enneenne.com>
References: <20050716124205.GA26127@enneenne.com>
	 <1121528575.27121.3.camel@localhost.localdomain>
	 <20050718161949.GB28995@enneenne.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Mon, 18 Jul 2005 09:30:05 -0700
Message-Id: <1121704205.4903.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Mon, 2005-07-18 at 18:19 +0200, Rodolfo Giometti wrote:
> On Sat, Jul 16, 2005 at 08:42:55AM -0700, Pete Popov wrote:
> > I fixed this is the latest tree a couple of days ago.
> 
> Something is still wrong... I just downloaded the whole linux-mips
> tree from the CVS (to avoid conflics with my local reporitory) and
> after the commands:
> 
>    # make pb1100_defconfig
>    # make
> 
> I get:
> 
>    arch/mips/mm/ioremap.c: In function `__ioremap':
>    include/asm-mips/mach-au1x00/ioremap.h:15: sorry, unimplemented: inlining failed in call to '__fixup_bigphys_addr': function body not available
>    arch/mips/mm/ioremap.c:28: sorry, unimplemented: called from here
>    make[1]: *** [arch/mips/mm/ioremap.o] Error 1
>    make: *** [arch/mips/mm] Error 2

Oh, pb boards ... I haven't done any maintenance on the Pb boards in
2.6. AMD wasn't interested in moving them forward and I don't have time
to build and test kernels for so many boards, so I'm not sure what to do
with them. The db1500/1550 should build just fine. Take a look at the
kernel support for those boards, and it shouldn't be too hard to update
the pb1100.

Thanks,

Pete
