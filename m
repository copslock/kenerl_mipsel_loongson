Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 22:29:21 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:16349 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225197AbTBRW3U>;
	Tue, 18 Feb 2003 22:29:20 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h1IMT9Ue024074;
	Tue, 18 Feb 2003 14:29:09 -0800 (PST)
Received: from xchange.mips.com (xchange [192.168.20.31])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id OAA13576;
	Tue, 18 Feb 2003 14:29:09 -0800 (PST)
Received: by xchange.mips.com with Internet Mail Service (5.5.2653.19)
	id <S30VXS8R>; Tue, 18 Feb 2003 14:26:20 -0800
Message-ID: <0C5F4C7A1E3ED51194E200508B2CE32A01B033F5@xchange.mips.com>
From: "Mitchell, Earl" <earlm@mips.com>
To: turcotte@broadcom.com
Cc: linux-mips@linux-mips.org
Subject: RE: Exec from Memory
Date: Tue, 18 Feb 2003 14:26:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips

You don't have to have disk to use filesystem.
Lot of people using CompactFlash to hold filesystem.
There is also the NFS option. 

-earlm

> -----Original Message-----
> From: Justin Carlson [mailto:justinca@cs.cmu.edu]
> Sent: Tuesday, February 18, 2003 2:22 PM
> To: turcotte@broadcom.com
> Cc: linux-mips@linux-mips.org
> Subject: Re: Exec from Memory
> 
> On Tue, 2003-02-18 at 17:08, Maurice Turcotte wrote:
> > Greetings:
> >
> > I have a hypothetical linux-mips question posed by a colleage.
> >
> > Suppose there is no file system available, since there is no disk. And
> > suppose that I had the capability to place an elf file in a known
> location
> > in memory. How would I execute it? It seems like exec really wants a
> file
> > name. BTW, this needs to run in use space, not kernel.
> >
> 
> There's no easy way (that know of) around the filesystem abstraction.
> You're going to have to deal with it in some manner.  Really basic
> stuff, like the elf loader, depends on vfs abstractions.  While it's
> possible to bypass all that, it would be a *lot* of work, and a lot of
> nearly-duplicated code.
> 
> I can see a couple of options.  Other people might have better
> suggestions.  :)
> 
> 1) Use the embedded root ramdisk functionality in the kernel.  Make your
> elf file /sbin/init, and run with it.
> 
> 2) Hack a quick filesystem that uses a contiguous chunk of memory that
> you either hardcode or pass in on the kernel command line.
> 
> -Justin
> 
