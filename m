Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2005 11:02:16 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:6161 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226167AbVCNLCB>; Mon, 14 Mar 2005 11:02:01 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2EB11Im017065;
	Mon, 14 Mar 2005 11:01:01 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2EB11RB017064;
	Mon, 14 Mar 2005 11:01:01 GMT
Date:	Mon, 14 Mar 2005 11:01:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ed Martini <martini@c2micro.com>
Cc:	linux-mips@linux-mips.org, Steve Stone <stone@c2micro.com>
Subject: Re: initrd problem
Message-ID: <20050314110101.GF7759@linux-mips.org>
References: <4230DB4C.7090103@c2micro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4230DB4C.7090103@c2micro.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 10, 2005 at 03:42:04PM -0800, Ed Martini wrote:

> I'm trying to get 2.6.11 to run on a MIPS Malta board with Yamon.  The 
> kernel that comes with the board is 2.4.18 with an embedded ramdisk that 
> runs some scripts to install RPMS via NFS or CD-ROM.  The kernel is 
> converted to s-records via objcopy(1), and loaded into memory via tftp.  
> I want to do something similar with 2.6.latest.
> 
> Problem:
> 
> On or about Nov 21 of last year, the CONFIG_EMBEDDED_RAMDISK disappeared.
> 
> http://www.linux-mips.org/archives/linux-mips/2004-11/msg00135.html
> 
> In it's place it is suggested to use the tools in arch/mips/boot, so I 
> tried it.  I can cross-compile the kernel, and I get an ELF vmlinux.  I 
> can convert it to ecoff with elf2ecoff, and attach an initrd image with 
> addinitrd.  The problem begins here.  I end up with an ecoff format 
> kernel which is not recognized by objcopy(1), and therefore no s-records.

I guess that was an act of desperation - YAMON needs SRECs to be happy
but doesn't know anything about SRECs.

> It seems there is a program called gensrec that would do the job, but 
> google doesn't want to tell me where to get it.  Some IRIX binary perhaps?

make vmlinux.srec; the resulting file will be in arch/mips/boot/vmlinux.srec.

> Should I put CONFIG_EMBEDDED_RAMDISK and its ilk back into my kernel, or 
> write an ELF version of addinitrd?  Other ideas?

Things vanish for a reason ...  Try CONFIG_INITRAMFS_SOURCE instead.

  Ralf
