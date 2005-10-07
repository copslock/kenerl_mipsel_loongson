Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 22:27:18 +0100 (BST)
Received: from sccrmhc12.comcast.net ([63.240.76.22]:2452 "EHLO
	sccrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133588AbVJGV06 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 22:26:58 +0100
Received: from buzz (c-67-171-115-157.hsd1.ut.comcast.net[67.171.115.157])
          by comcast.net (sccrmhc12) with SMTP
          id <2005100721265101200p4g7pe>; Fri, 7 Oct 2005 21:26:51 +0000
From:	"Kyle Unice" <unixe@comcast.net>
To:	"'Brett Foster'" <fosterb@uoguelph.ca>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: Cross-compiling Linux problem
Date:	Fri, 7 Oct 2005 15:26:49 -0600
Message-ID: <002c01c5cb85$d42c5050$0400a8c0@buzz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <4346DD97.40106@uoguelph.ca>
Return-Path: <unixe@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: unixe@comcast.net
Precedence: bulk
X-list: linux-mips

I am compiling the db1550_defconfig which does define
CONFIG_64BIT_PHYS_ADDR.
The cross compiler is mipsel generated from crosstool.sh
Kyle

-----Original Message-----
From: Brett Foster [mailto:fosterb@uoguelph.ca] 
Sent: Friday, October 07, 2005 2:42 PM
To: Kyle Unice
Cc: linux-mips@linux-mips.org
Subject: Re: Cross-compiling Linux problem

Kyle Unice wrote:

>arch/mips/mm/tlbex.c:516:5: warning: "CONFIG_64BIT" is not defined
>  AS      arch/mips/mm/tlbex-fault.o
>  CC      arch/mips/mm/ioremap.o
>arch/mips/mm/ioremap.c: In function `__ioremap':
>include/asm-mips/mach-au1x00/ioremap.h:15: sorry, unimplemented: inlining
>failed
> in call to '__fixup_bigphys_addr': function body not available
>arch/mips/mm/ioremap.c:28: sorry, unimplemented: called from here
>make[1]: *** [arch/mips/mm/ioremap.o] Error 1
>make: *** [arch/mips/mm] Error 2
>  
>
I once had this sort of problem when I forgot to specify the cross 
compiler while invoking make and tried to compile a MIPS kernel on X86 gcc.

Brett
