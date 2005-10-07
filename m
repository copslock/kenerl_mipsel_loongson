Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 22:54:48 +0100 (BST)
Received: from sccrmhc13.comcast.net ([204.127.202.64]:48627 "EHLO
	sccrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133591AbVJGVyQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2005 22:54:16 +0100
Received: from buzz (c-67-171-115-157.hsd1.ut.comcast.net[67.171.115.157])
          by comcast.net (sccrmhc13) with SMTP
          id <2005100721540901300bc1r8e>; Fri, 7 Oct 2005 21:54:10 +0000
From:	"Kyle Unice" <unixe@comcast.net>
To:	<ppopov@embeddedalley.com>
Cc:	"'Brett Foster'" <fosterb@uoguelph.ca>, <linux-mips@linux-mips.org>
Subject: RE: Cross-compiling Linux problem
Date:	Fri, 7 Oct 2005 15:54:08 -0600
Message-ID: <002d01c5cb89$a4f1b830$0400a8c0@buzz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1128721636.9971.166.camel@localhost.localdomain>
Return-Path: <unixe@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: unixe@comcast.net
Precedence: bulk
X-list: linux-mips

I am using gcc-3.4.4 and the cvs checkout of linux-mips.org tree.
Kyle

-----Original Message-----
From: Pete Popov [mailto:ppopov@embeddedalley.com] 
Sent: Friday, October 07, 2005 3:47 PM
To: Kyle Unice
Cc: 'Brett Foster'; 'linux-mips@linux-mips.org'
Subject: RE: Cross-compiling Linux problem

On Fri, 2005-10-07 at 15:26 -0600, Kyle Unice wrote:
> I am compiling the db1550_defconfig which does define
> CONFIG_64BIT_PHYS_ADDR.
> The cross compiler is mipsel generated from crosstool.sh

Which gcc version? And I assume you are using the linux-mips.org tree,
not kernel.org?

Pete

> Kyle
> 
> -----Original Message-----
> From: Brett Foster [mailto:fosterb@uoguelph.ca] 
> Sent: Friday, October 07, 2005 2:42 PM
> To: Kyle Unice
> Cc: linux-mips@linux-mips.org
> Subject: Re: Cross-compiling Linux problem
> 
> Kyle Unice wrote:
> 
> >arch/mips/mm/tlbex.c:516:5: warning: "CONFIG_64BIT" is not defined
> >  AS      arch/mips/mm/tlbex-fault.o
> >  CC      arch/mips/mm/ioremap.o
> >arch/mips/mm/ioremap.c: In function `__ioremap':
> >include/asm-mips/mach-au1x00/ioremap.h:15: sorry, unimplemented: inlining
> >failed
> > in call to '__fixup_bigphys_addr': function body not available
> >arch/mips/mm/ioremap.c:28: sorry, unimplemented: called from here
> >make[1]: *** [arch/mips/mm/ioremap.o] Error 1
> >make: *** [arch/mips/mm] Error 2
> >  
> >
> I once had this sort of problem when I forgot to specify the cross 
> compiler while invoking make and tried to compile a MIPS kernel on X86
gcc.
> 
> Brett
> 
> 
