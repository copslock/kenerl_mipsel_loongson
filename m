Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 11:27:25 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:10005 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133357AbWA0L1H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 11:27:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0RBVh5A005050;
	Fri, 27 Jan 2006 11:31:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0RBVhnM005049;
	Fri, 27 Jan 2006 11:31:43 GMT
Date:	Fri, 27 Jan 2006 11:31:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Message-ID: <20060127113143.GB3497@linux-mips.org>
References: <cda58cb80601260702wf781e70l@mail.gmail.com> <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com> <cda58cb80601260831i61167787g@mail.gmail.com> <43D8FF16.40107@mips.com> <cda58cb80601261002w6eb02249k@mail.gmail.com> <43D93025.9040800@mips.com> <cda58cb80601270103t1419117cq@mail.gmail.com> <000b01c6232a$5ea81470$10eca8c0@grendel> <cda58cb80601270245g6273ce04k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80601270245g6273ce04k@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 27, 2006 at 11:45:34AM +0100, Franck wrote:

> no some are. As we said previously:
> 
>         1/ sizeof(vmlinux-mips32r2-Os) > sizeof(vmlinux-4ksd-Os)
>         2/ with -march=4ksd can do (slightly) better optimizations
> 
> > for every 4KSd embedded Linux platform there are several 4KEc platforms
> > that would benefit from a smaller kernel footprint.
> >
> 
> -Os can already be choosen by user in kernel configuration. Your
> CONFIG_CPU_MIPS_SMALL option brings nothing more except that the user
> is stuck with -Os option. BTW, I think it may be the default option in
> the near future for mainline...

Not before demonstrating that it is a clear win under all circumstances.

  Ralf
