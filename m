Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3BI1d112798
	for linux-mips-outgoing; Wed, 11 Apr 2001 11:01:39 -0700
Received: from dea.waldorf-gmbh.de (u-220-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.220])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3BI1PM12780;
	Wed, 11 Apr 2001 11:01:26 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3B7ZuK01612;
	Wed, 11 Apr 2001 09:35:56 +0200
Date: Wed, 11 Apr 2001 09:35:56 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Kanoj Sarcar <kanoj@oss.sgi.com>
Cc: linux-origin@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20010411093556.B1337@bacchus.dhis.org>
References: <200104102242.f3AMgmc19116@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104102242.f3AMgmc19116@oss.sgi.com>; from kanoj@oss.sgi.com on Tue, Apr 10, 2001 at 03:42:48PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 10, 2001 at 03:42:48PM -0700, Kanoj Sarcar wrote:

> CVSROOT:	/home/pub/cvs
> Module name:	linux
> Changes by:	kanoj@oss.sgi.com	01/04/10 15:42:47
> 
> Modified files:
> 	drivers/char   : serial.c 
> 
> Log message:
> 	Fix the IP27 serial driver after the 2.4.3 merge. This is what you
> 	need in /etc/inittab: "7:2345:respawn:/sbin/getty ttyS0 DT9600".
> 	mingetty can also probably be made to work.

Mingetty starts ok but it's impossible to enter something.  This is caused
by CREAD being cleared on the tty.  I don't know why this happens; it
started in 2.4.3.

  Ralf
