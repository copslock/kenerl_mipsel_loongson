Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id UAA31762
	for <pstadt@stud.fh-heilbronn.de>; Thu, 8 Jul 1999 20:09:02 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02010; Thu, 8 Jul 1999 11:04:44 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA40186
	for linux-list;
	Thu, 8 Jul 1999 11:00:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id KAA92486;
	Thu, 8 Jul 1999 10:59:57 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA05663; Thu, 8 Jul 1999 10:56:41 -0700
From: "William J. Earl" <wje@fir.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14212.58969.26507.519213@fir.engr.sgi.com>
Date: Thu, 8 Jul 1999 10:56:41 -0700 (PDT)
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: "William J. Earl" <wje@fir.engr.sgi.com>, Warner Losh <imp@village.org>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        Ulf Carlsson <ulfc@thepuffingroup.com>
Subject: Re: Memory corruption
In-Reply-To: <37846EE7.EADD9E32@niisi.msk.ru>
References: <XFMail.990707230857.Harald.Koerfgen@home.ivm.de>
	<199907080151.TAA05482@harmony.village.org>
	<14212.5891.237364.112104@fir.engr.sgi.com>
	<37846EE7.EADD9E32@niisi.msk.ru>
X-Mailer: VM 6.72 under Emacs 19.34.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Gleb O. Raiko writes:
 > "William J. Earl" wrote:
...
 > >       The R3000 has a write-through cache, so there cannot be dirty cache
 > > lines, although you do have to flush the write buffers to be completely
 > > correct (in the case of a DMA device writing to memory VERY quickly after
 > > the register write which starts it up, on some hardware).
 > 
 > You must flush d-cache after dma. While some cache controllers are able
 > to watch the bus and flush the data that are invalidated due to DMA
 > transfers, I think, most r3k boxes doesn't have such beasts. Flushing
 > d-cache wasn't implemented at the same time as the cache stuff because
 > we hadn't boxes with DMA devices.

     Most R3000 (and many R4000/R4600/R5000) boxes do not have
cache-coherent I/O, and Linux/MIPS does do cache flushing.  If
everything is well-organized, one can flush the d-cache only before an
I/O.  On an R3000, it does not much matter which approach you take,
since the caches are write-through (aside from the need to flush the
write-buffer before initiating a DMA).  For later processors, you must
flush the d-cache BEFORE a DMA, since victim writebacks of dirty lines
after a DMA into memory has updated memory will lead to I/O data
corruption, and failure to flush dirty lines before a DMA from memory
will lead to stale data being written to disk.  If it is possible for
the CPU to access the buffer during the DMA, then you must invalidate
the cache for the buffer after a DMA into memory as well, but a
well-constructed system should never do that.  

    If you have a buffer which is not cache-line-aligned (which is
possible with the general case of raw or direct I/O, although not in
unmodified Linux at the moment), then, for DMA into memory, you must
use temporary buffers for any portion of the buffer which occupies
just part of a cache line, and copy the data from the temporary buffer
to the real buffer after the DMA completes, to account for the
possibility of a separate thread modifying data outside the buffer in
the shared cache line, leading to a victim writeback (or a
writethrough on the R3000).  This could apply even to the R3000, depending
on how the compiler generates code for a partial-word update, although
it is unlikely.
