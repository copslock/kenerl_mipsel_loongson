Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAGDqi028468
	for linux-mips-outgoing; Fri, 16 Nov 2001 05:52:44 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAGDqeg28465
	for <linux-mips@oss.sgi.com>; Fri, 16 Nov 2001 05:52:40 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 164jPW-000786-00; Fri, 16 Nov 2001 14:52:02 +0100
Date: Fri, 16 Nov 2001 14:52:01 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] indy_int clenaup
In-Reply-To: <20011116142143.A23733@galadriel.physik.uni-konstanz.de>
Message-ID: <Pine.LNX.4.21.0111161427220.26728-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 16 Nov 2001, Guido Guenther wrote:

> On Fri, Nov 16, 2001 at 01:49:22PM +0100, Ladislav Michl wrote:
> > note for those, who are waiting for VINO driver: at the beginning I was
> > unable to start DMA transfer. now i'm unable to stop it... so to bring my
> > ego from dust, i decided to write HAL2 driver, which needs HPC interupts.
> > this patch is HAL2 driver by-product...
> I've done some work on porting Ulf's old ALSA HAL2 codebase to a more recent
> (0.9) version of alsa, could that be of any use to you? 

wow, so many people working on HAL2 :-) Klaus?

this is not useful for me, moreover i reworked HPC buffers handling (so
maybye, it will be usefull for you :-)). OSS kernel driver is working now.
it need some testing and cleanup, but it is mostly finished. i want to
listen music, so i implemented pcm playback and mixer only.

my plan is:
1. convience Ralf to include indy_int patch to cvs :-)
2. write and send CONFIG_NEW_TIME_C patch for Indy
3. once these will be included, send HAL2 driver.

btw, if anyone wants to look at vino driver here it is:
ftp://ftp.psi.cz/pub/ladis/vino/

regards,
ladis
