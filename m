Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3A8pN131270
	for linux-mips-outgoing; Tue, 10 Apr 2001 01:51:23 -0700
Received: from colo.asti-usa.com (IDENT:root@colo.asti-usa.com [205.252.89.99])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3A8pJM31262;
	Tue, 10 Apr 2001 01:51:19 -0700
Received: from lineo.com (hal.uk.zentropix.com [212.74.13.151])
	by colo.asti-usa.com (8.9.3/8.9.3) with ESMTP id EAA30599;
	Tue, 10 Apr 2001 04:59:23 -0400
Message-ID: <3AD2CA74.DCC850EF@lineo.com>
Date: Tue, 10 Apr 2001 09:55:16 +0100
From: Ian Soanes <ians@lineo.com>
Organization: Lineo UK
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Shay Deloya <shay@jungo.com>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Insmod messages and modules space
References: <01040921101605.01025@athena.home.krftech.com> <20010409211447.A18894@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Mon, Apr 09, 2001 at 08:10:16PM +0200, Shay Deloya wrote:
> 
> > 1.Should text segment of module after insmod be in KSEG2 or KUSEG ?
> > I've notices that the module address after insmod are c0... instead of 80...
> > Is it insmod Bug  ?
> 
> It's a sign of insmod working properly :)
> 
> > 2. I keep getting in insmod of busybox pkg , "relocation overflow" message
> > especially on printk symbols , when I debug the code, changing some function
> > declaration from static int func () to int func()  , makes the module to
> > insert correctly , anyone ?
> 
> Two possibilities, either you're using a too old and broken version of
> modutils or you used inapropriate options to compile your module.
> 

Compiling with -mlong-calls worked for me when I had the same problem
(modutils 2.4.5). Relinking the module with 'ld -r -o new_mod.o
orig_mod.o' was useful too ...it worked around some 'exceeds
local_symtab_size' messages.

Ian
