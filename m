Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3O8ILM03547
	for linux-mips-outgoing; Tue, 24 Apr 2001 01:18:21 -0700
Received: from colo.asti-usa.com (IDENT:root@colo.asti-usa.com [205.252.89.99])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3O8IKM03544
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 01:18:20 -0700
Received: from lineo.com (hal.uk.zentropix.com [212.74.13.151])
	by colo.asti-usa.com (8.9.3/8.9.3) with ESMTP id EAA26660;
	Tue, 24 Apr 2001 04:26:43 -0400
Message-ID: <3AE537BC.37523C6C@lineo.com>
Date: Tue, 24 Apr 2001 09:22:20 +0100
From: Ian Soanes <ians@lineo.com>
Organization: Lineo UK
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@melbourne.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Insmod messages and modules space
References: <12715.988066675@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith Owens wrote:
> 
> On Tue, 10 Apr 2001 09:55:16 +0100,
> Ian Soanes <ians@lineo.com> wrote:
> >> On Mon, Apr 09, 2001 at 08:10:16PM +0200, Shay Deloya wrote:
> >> > 2. I keep getting in insmod of busybox pkg , "relocation overflow" message
> >> > especially on printk symbols
> >
> >Compiling with -mlong-calls worked for me when I had the same problem
> >(modutils 2.4.5).
> 
> Compiling what with -mlong-calls, modutils or the kernel modules?  I
> guess it must be the modules, in which case adding
>   MODFLAGS += -mlong-calls
> in arch/$(ARCH)/Makefile is the best fix.

Yes... the modules.
