Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 18:24:40 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:52084 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20044914AbWHKRYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 18:24:36 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH 2/6] setup.c: move initrd code inside dedicated functions
Date:	Fri, 11 Aug 2006 10:24:27 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D33AF4A@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/6] setup.c: move initrd code inside dedicated functions
Thread-Index: Aca9WNdqUWhur2ahRHanse+Kx+d32AADm0Xg
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Atsushi Nemoto wrote:
> >> +	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
> >> +	       (void *)initrd_start, initrd_size);
> > 
> > You can use "0x%lx" for initrd_start and remove the cast.  
> I know this
> > fragment are copied from corrent code as is, but it would be a good
> > chance to clean it up.
> > 
> 
> You're right.

Actually the cast that is there is only pedantic. ANSI C says that
%p must be met with a void *, which might be important on some
exotic machine where pointers have a different representation
based on their type. Elsewhere, it would be very surprising
if omitting the (void *) caused a problem with %p.

You definitely do need a cast if you are printing a pointer
as an integer though.

And you have to cast to an integer that is wide enough for the
pointer.  If you are compiling for 64 bit, that means
"unsigned long long", unless you are sure that the upper
32 bits are all zero. 

Ideally, you should just be able to use %p to print pointers,
and I'd love to recommend that. It should be smart enough to
know that they are 64 bits wide. I'm looking at the vsprintf
in 2.6.17 and see that, sadly, it converts the void * pulled
from the va_arg to "unsigned long".

Oopsies!

One last note: if you are printing hex, and want that
0x prefix, you can use the # flag, e.g.

  printk(KERN_INFO "%#lx\n", 0xdeadbeefUL);

Cheers ...
