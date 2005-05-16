Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2005 18:49:59 +0100 (BST)
Received: from p549F5CD4.dip.t-dialin.net ([IPv6:::ffff:84.159.92.212]:50662
	"EHLO bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225730AbVEPRto>; Mon, 16 May 2005 18:49:44 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j4GHng53015780;
	Mon, 16 May 2005 18:49:42 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j4GHnf1T015779;
	Mon, 16 May 2005 18:49:41 +0100
Date:	Mon, 16 May 2005 18:49:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mile Davidovic <mile.davidovic@micronasnit.com>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Mips 4lkecr2
Message-ID: <20050516174940.GA31527@linux-mips.org>
References: <200505161001.j4GA1V1p028192@krt.neobee.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505161001.j4GA1V1p028192@krt.neobee.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 16, 2005 at 11:57:02AM +0200, Mile Davidovic wrote:

> I have embedded processor with MIPS 4KECr2 processor and tried to port
> linux-2.6.11-mipscvs-20050313.
> I follow tutorial from linux-mips and add custom code for int handler, time
> ...
> But I have some problem with detecting of cpu. In cpu-probe.c I added:
> cpu_probe_mips with:
>        case PRID_IMP_4KEC:
>        case PRID_IMP_4KECR2:   /* this line is added */
>         c->cputype = CPU_4KEC;
> 		c->isa_level = MIPS_CPU_ISA_M32;
> 
> Is it ok ? Did I forgot something?

To get Linux to work on a 4KEc R2 Malta I only had to to do this change
so you have an additional problem.

  Ralf
