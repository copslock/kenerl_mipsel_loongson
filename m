Received:  by oss.sgi.com id <S42255AbQIHEEq>;
	Thu, 7 Sep 2000 21:04:46 -0700
Received: from u-93.karlsruhe.ipdial.viaginterkom.de ([62.180.21.93]:19974
        "EHLO u-93.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42252AbQIHEE3>; Thu, 7 Sep 2000 21:04:29 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869074AbQIHEEM>;
        Fri, 8 Sep 2000 06:04:12 +0200
Date:   Fri, 8 Sep 2000 06:04:12 +0200
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Rabeeh Khoury <rabeeh@galileo.co.il>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: modules in kernel 2.2.14
Message-ID: <20000908060412.A9991@bacchus.dhis.org>
References: <39B7DD90.83B3B3D5@galileo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39B7DD90.83B3B3D5@galileo.co.il>; from rabeeh@galileo.co.il on Thu, Sep 07, 2000 at 02:25:20PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Sep 07, 2000 at 02:25:20PM -0400, Rabeeh Khoury wrote:

> I'm running kernel 2.2.14 and i'm trying inserting modules.
> 
> In the file kernel/module.c, function sys_create_module calles
> module_map which is defined as vmalloc.
> 
> calling vmalloc returns a pointer to a virtual memory address in the
> memory mapped area (in my case 0xc0000000) and the kernel had an
> exception for accessing this address.

Which means that your TLB exception handlers, cache handling or something
in that area is busted, I recommend to fix that first.

> my work around was defining the following in kernel/module.c
> 
> #define module_map      kmalloc
> #define module_unmap    kfree
> 
> and it worked fine.
> 
> Is this work around sufficient ?

It's ok but can be pretty wasteful on memory.  It also will only work
for modules upto 128kb size.  Also if choose this fix you should delete
-mlong-calls from MODFLAGS in arch/mips/Makefile as an additional
optimization.

  Ralf
