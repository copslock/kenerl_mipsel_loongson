Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2GHrMY10408
	for linux-mips-outgoing; Fri, 16 Mar 2001 09:53:22 -0800
Received: from dea.waldorf-gmbh.de (u-210-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.210])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2GHrJM10405
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 09:53:19 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2GFYeK06531;
	Fri, 16 Mar 2001 16:34:40 +0100
Date: Fri, 16 Mar 2001 16:34:40 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: <linux-mips@oss.sgi.com>
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010316163439.A6514@bacchus.dhis.org>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org> <00fc01c0acd3$c881ca80$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00fc01c0acd3$c881ca80$0deca8c0@Ulysses>; from kevink@mips.com on Wed, Mar 14, 2001 at 11:11:47PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I looked over the MIPS backend and was depressed how little it still knows
about various newer MIPS CPUs.  So I tought gcc a bit about the R10000
and R12000.  Less than perfect but this patch against cvs-gcc should
deliver some improvments.

GCC still knows shit about the R7000 and that's definately a CPU worth some
effort ...

If you want the R10k patch, drop me a mail.

  Ralf
