Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f41FWxl26943
	for linux-mips-outgoing; Tue, 1 May 2001 08:32:59 -0700
Received: from mail5.svr.pol.co.uk (mail5.svr.pol.co.uk [195.92.193.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f41FWtM26940
	for <linux-mips@oss.sgi.com>; Tue, 1 May 2001 08:32:56 -0700
Received: from modem-9.uranium.dialup.pol.co.uk ([62.136.65.137] helo=derfel)
	by mail5.svr.pol.co.uk with smtp (Exim 3.13 #0)
	id 14uc8w-00016Q-00; Tue, 01 May 2001 16:32:52 +0100
From: "Andrew Linfoot" <alinfoot@escafeldcomputing.co.uk>
To: "'Guido Guenther'" <guido.guenther@gmx.net>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: Passing kernel args
Date: Tue, 1 May 2001 16:31:47 +0100
Message-ID: <000001c0d253$f36e3b20$0101a8c0@derfel>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010424230923.A5906@bilbo.physik.uni-konstanz.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

My fault i'm afraid! I had used an old kernel without the neccessary
patches.
I am now using 2.4.3 and everthing works fine.

Sorry for any hassle this has caused.

Andy

-----Original Message-----
From: owner-linux-mips@oss.sgi.com
[mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Guido Guenther
Sent: 24 April 2001 22:09
To: Andrew Linfoot
Cc: linux-mips@oss.sgi.com
Subject: Re: Passing kernel args


On Tue, Apr 24, 2001 at 08:09:13PM +0100, Andrew Linfoot wrote:
> Just thought i would let you know of my experience with autobooting.
>
> I'm having the same problems as Dave in that i must specify a space in
> the OSLoadOptions " root=/dev/sda1 ro". However every time i shutdown or
> reboot it is truncated to OSLoadOptions= root=/dev/s meaning i have to
reset
> it after every reboot.
Could you please send me the kernel command line with and without using
the space (e.g.  dmesg | grep "command line") - i still don't see what
this should be good for.  BTW no need to give root= in OSLoadOptions,
you can use OSLoadPartition instead.
>
> any ideas as to what may be causing this?
> I am runnning on an Indy R5K
It seems the space in the PROM for OSLoadOptions is quiet limited. The
space available seems to differ between different PROM versions
though(see the HOWTO, it's in there).
>
> Also i am using an ELF kernel and not ECOFF as specified in Guido's howto.
Doesn't make a difference. ECOFF is just a save bet.
 -- Guido
