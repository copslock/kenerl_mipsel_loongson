Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 12:51:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62100 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027228AbXJELvx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 12:51:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l95Bppeg019142;
	Fri, 5 Oct 2007 12:51:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l95Bppds019131;
	Fri, 5 Oct 2007 12:51:51 +0100
Date:	Fri, 5 Oct 2007 12:51:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071005115151.GA16145@linux-mips.org>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4705004C.5000705@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 05:01:32PM +0200, Franck Bui-Huu wrote:

(Hitting the send key now so nobody notices I wrote this email at 3am ;-)

> It's just a bit sad to see my TLB handler generated at each boot and
> to embed the whole tlbex generator inside the kernel which is quite
> big:
> 
>    $ mipsel-linux-size arch/mips/mm/tlbex.o
>       text    data     bss     dec     hex filename
>      10116    3904    1568   15588    3ce4 arch/mips/mm/tlbex.o
> 
> specially if my cpu doesn't have any bugs.

So I did a few experiments.  This is the size of tlbex for a malta_defconfig
build with gcc 4.2.1:

   text    data     bss     dec     hex filename
  10468    3904    1568   15940    3e44 arch/mips/mm/tlbex.o

After replacing current_cpu_data.cputype with a new macro current_cpu_type
that expands to the constant CPU type value, I picked CPU_4KC:

   text    data     bss     dec     hex filename
   6088    3904    1568   11560    2d28 arch/mips/mm/tlbex.o

And after also changing r45k_bvahwbug, r4k_250MHZhwbug, bcm1250_m3_war,
r10000_llsc_war and m4kc_tlbp_war into inline functions:

   text    data     bss     dec     hex filename
   5608    3904    1568   11080    2b48 arch/mips/mm/tlbex.o

So I applied the inlining change to the queue tree and came up with a
generalized version of the current_cpu_type.   This are the sizes I get
for a malta kernel without and with hardwiring the CPU type to 4Kc:

     text    data     bss     dec     hex filename
  3273876  142324  140944 3557144  364718 vmlinux
  3267048  142324  140944 3550316  362c6c vmlinux

6828 bytes isn't totally amazing but since the optimization is reasonable
clean I'm going to queue this one also.

  Ralf
