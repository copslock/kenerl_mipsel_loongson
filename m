Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3GIhO200621
	for linux-mips-outgoing; Mon, 16 Apr 2001 11:43:24 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3GIhMM00616
	for <linux-mips@oss.sgi.com>; Mon, 16 Apr 2001 11:43:23 -0700
Received: from rose.sonytel.be (rose.sonytel.be [10.17.0.5])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id UAA14512;
	Mon, 16 Apr 2001 20:43:00 +0200 (MET DST)
Date: Mon, 16 Apr 2001 20:42:41 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Shay Deloya <shay@jungo.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Ioctl size mask
In-Reply-To: <01041612582600.25043@athena.home.krftech.com>
Message-ID: <Pine.GSO.4.10.10104162042230.10522-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 16 Apr 2001, Shay Deloya wrote:
> On asm-mips/ioctl.h , there is a mask on the size transfered to the ioctl , 
> e.g. : when implementing an ioctl that handles IO , the max size the 
> supported in mips is 0xff  as defined in the code below: 
> 
> 
> #define _IOWR(type,nr,size) 			
> 	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))                          
> 
> 
> and _IOC uses size in this way:
> 
> (((size) & _IOC_SLMASK) << _IOC_SIZESHIFT))           // (_IOC_SLMMASK = 0xff)
> 
> 
> The limited size causes problems on drivers that use size mask to their 
> needs, while officialy the allowed limit is 2^13 ( 8kB) by definition .

This was fixed in the CVS tree some weeks ago.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
