Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2GIGoA11605
	for linux-mips-outgoing; Fri, 16 Mar 2001 10:16:50 -0800
Received: from dea.waldorf-gmbh.de (u-210-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.210])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2GIGlM11602
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 10:16:47 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2GIGXF14155;
	Fri, 16 Mar 2001 19:16:33 +0100
Date: Fri, 16 Mar 2001 19:16:33 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010316191633.C2857@bacchus.dhis.org>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org> <00fc01c0acd3$c881ca80$0deca8c0@Ulysses> <20010316150423.A3529@bacchus.dhis.org> <20010316130208.A6803@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010316130208.A6803@nevyn.them.org>; from dan@debian.org on Fri, Mar 16, 2001 at 01:02:08PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Mar 16, 2001 at 01:02:08PM -0500, Daniel Jacobowitz wrote:

> Are you saying that the -mcpu=r8000 options in linux/arch/mips/Makefile
> for the nevada should be -mcpu=r5000 instead?

Correct for egcs >= 1.1.2.

  Ralf
