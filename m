Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3HGmRO15732
	for linux-mips-outgoing; Tue, 17 Apr 2001 09:48:27 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3HGmLM15723
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 09:48:22 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3HGdvS07535;
	Tue, 17 Apr 2001 13:39:57 -0300
Date: Tue, 17 Apr 2001 13:39:57 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Shay Deloya <shay@jungo.com>, linux-mips@oss.sgi.com
Subject: Re: Ioctl size mask
Message-ID: <20010417133957.C7177@bacchus.dhis.org>
References: <01041612582600.25043@athena.home.krftech.com> <Pine.GSO.4.10.10104162042230.10522-100000@rose.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10104162042230.10522-100000@rose.sonytel.be>; from Geert.Uytterhoeven@sonycom.com on Mon, Apr 16, 2001 at 08:42:41PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 16, 2001 at 08:42:41PM +0200, Geert Uytterhoeven wrote:

> > #define _IOWR(type,nr,size) 			
> > 	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))                          
> > 
> > 
> > and _IOC uses size in this way:
> > 
> > (((size) & _IOC_SLMASK) << _IOC_SIZESHIFT))           // (_IOC_SLMMASK = 0xff)
> > 
> > 
> > The limited size causes problems on drivers that use size mask to their 
> > needs, while officialy the allowed limit is 2^13 ( 8kB) by definition .
> 
> This was fixed in the CVS tree some weeks ago.

Small addendum to the fix - while it made some ioctls usable it also did
result in the affected ioctl number changing which may have broken some
software that _appeared_ to be working before.  One example is autofs.
Just recompile against the updated kernel headers and everything will be
ok.

The effect gets more visible on the 64-bit kernel which will spit kernel
messages for unknown ioctls.

  Ralf
