Received:  by oss.sgi.com id <S42416AbQI2X7e>;
	Fri, 29 Sep 2000 16:59:34 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.19.53]:13575
        "EHLO u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42392AbQI2X7R>; Fri, 29 Sep 2000 16:59:17 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868992AbQI2X7E>;
        Sat, 30 Sep 2000 01:59:04 +0200
Date:   Sat, 30 Sep 2000 01:59:04 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     =?iso-8859-1?Q?=C0=AF=B1=A4=C7=F6?= <khyoo@swc.sec.samsung.co.kr>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Help!! My Indy do not want to boot.
Message-ID: <20000930015904.B29860@bacchus.dhis.org>
References: <F805AE5A9759D41198BA00A0C985B8FA36D175@swc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <F805AE5A9759D41198BA00A0C985B8FA36D175@swc>; from khyoo@swc.sec.samsung.co.kr on Fri, Sep 29, 2000 at 05:54:47PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 29, 2000 at 05:54:47PM +0900, À¯±¤Çö wrote:

> Target kernel is fresh one, downloaded from CVS server (oss.sgi.com), 2.4.0-
> test8-pre1.
> The building process was very easy, calm.
> But during the boot process my Indy displays following messages ...
> 
> 	Exception: <vector=UTLB miss>
> 	Status register: 0x10004803 <CU0, IM7, IM4, IPL=???, MODE=KERNEL,
> EXL, IE>
> 	Cause register: 0x8 <CE=0, EXC=RMISS>
> 	Exception PC: 0x8817d730, Exception RA: 0x8817ddfc
> 	[....... ]
> 	
> 	PANIC: Unexpected Exception
> 	[Press Reset or ENTER to restart]
> 
> Is there anyone who can help me and let me know why this happens?
> 
> PS: I do not use -N flag at file (arch/mips/Makefile LINKFLAGS).

Boot the kernel using boot -f from the ARC command line.  That avoid the
use of sash which some versions seem to be buggy and not able to load
Linux.

I'm still trying to gather more information about this sash probem - which
version of IRIX is there installed on your machine?  Thanks,

  Ralf
