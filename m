Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACD3hK19391
	for linux-mips-outgoing; Mon, 12 Nov 2001 05:03:43 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACD3a019385
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 05:03:37 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA29614;
	Mon, 12 Nov 2001 13:59:12 +0100 (MET)
Date: Mon, 12 Nov 2001 13:59:11 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jun Sun <jsun@mvista.com>, Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <Pine.GSO.4.21.0111111107170.10838-100000@mullein.sonytel.be>
Message-ID: <Pine.GSO.3.96.1011112135012.24771I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 11 Nov 2001, Geert Uytterhoeven wrote:

> > In other words, with such a driver, once you implemented rtc_get_time()
> > and rtc_set_time(), which is required by the kernel anyway, you will
> > automatically get a free /dev/rtc/ driver.
> >
> > This is the idea behind the generic MIPS rtc driver.  See the patch below.
> 
> Oh no, don't tell me we now have (at least) _three_ of these floating around
> :-)
> 
>   - On m68k, we have drivers/char/genrtc.c (not yet merged, check out CVS, see
>     http://linux-m68k-cvs.apia.dhs.org/).
>   - On PPC, we have drivers/macintosh/rtc.c.
>   - On MIPS, we now have your drivers/char/mips_rtc.c.

 Agreed, what's wrong with drivers/char/rtc.c?  It even works for the
DECstation which maps its RTC in an unusual (but nice) way -- it's just a
matter of initializing rtc_ops appropriately.  See arch/mips/dec/rtc-dec.c
for an example.

 Unless you use a non-MC146818 RTC, which you need to write a separate
driver for anyway. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
