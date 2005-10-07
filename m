Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 22:48:01 +0100 (BST)
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:46697 "HELO
	smtp101.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133588AbVJGVrl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 22:47:41 +0100
Received: (qmail 90019 invoked from network); 7 Oct 2005 21:47:31 -0000
Received: from unknown (HELO ?192.168.1.110?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 7 Oct 2005 21:47:31 -0000
Subject: RE: Cross-compiling Linux problem
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Kyle Unice <unixe@comcast.net>
Cc:	'Brett Foster' <fosterb@uoguelph.ca>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <002c01c5cb85$d42c5050$0400a8c0@buzz>
References: <002c01c5cb85$d42c5050$0400a8c0@buzz>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 07 Oct 2005 14:47:15 -0700
Message-Id: <1128721636.9971.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

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
> compiler while invoking make and tried to compile a MIPS kernel on X86 gcc.
> 
> Brett
> 
> 
