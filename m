Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Aug 2004 20:35:32 +0100 (BST)
Received: from web40001.mail.yahoo.com ([IPv6:::ffff:66.218.78.19]:63911 "HELO
	web40001.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225243AbUHYTfY>; Wed, 25 Aug 2004 20:35:24 +0100
Message-ID: <20040825193458.55841.qmail@web40001.mail.yahoo.com>
Received: from [63.87.1.243] by web40001.mail.yahoo.com via HTTP; Wed, 25 Aug 2004 12:34:58 PDT
Date: Wed, 25 Aug 2004 12:34:58 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: Re: Should #ifdef __KERNEL__ be added before #include <spaces.h> in asm-mips/addrspace.h ?
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040820120526.GA27130@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wsonguci@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsonguci@yahoo.com
Precedence: bulk
X-list: linux-mips

Ralf,

The problem in asm-mips/addrspace.h when including
<spaces.h> is different. The problem is the path.

spaces.h lives in asm-mips/mach-generic,

Only when compiling kernel, asm-mips/mach-generic
is in the include path, because arch/mips/Makefile
defines it.

However, when compiling the user-space apps, they
don't know how to find spaces.h when they indirectly
include <asm/addrspace.h>


-Song


--- Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Jul 20, 2004 at 05:03:56PM -0700, Song Wang
> wrote:
> 
> > Should #ifdef _KERNEL__ be added before #include
> > <spaces.h> in asm-mips/addrspace.h?
> > 
> > I think the reason is the same as when you added
> > the #ifdef __KERNEL__ before #include <spaces.h>
> > for asm-mips/page.h.
> 
> Some userspace software is expecting to get
> PAGE_SHIFT, PAGE_SIZE and
> PAGE_MASK to be available in userspace via
> <asm/page.h>, so I
> protected the inclusion of <asm/spaces.h> with
> __KERNEL__ but left
> the definitions of these symbols unprotected.
> 
>   Ralf
> 



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
