Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3I6sUD15016
	for linux-mips-outgoing; Tue, 17 Apr 2001 23:54:30 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3I6sSM15013
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 23:54:29 -0700
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA19919;
	Wed, 18 Apr 2001 08:54:09 +0200 (MET DST)
Date: Wed, 18 Apr 2001 08:53:49 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Scott A McConnell <samcconn@cotw.com>
cc: linux-mips@oss.sgi.com
Subject: Re: kernel/printk.c problem
In-Reply-To: <3ADCBFAE.92957163@cotw.com>
Message-ID: <Pine.GSO.4.10.10104180852450.17832-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 17 Apr 2001, Scott A McConnell wrote:
> struct console *console_drivers = NULL;                          <----
> Need the NULL.
> 
> Otherwise, bad things can happen on the following statement in printk
> 
> ~line 311
> 
>        if ((c->flags & CON_ENABLED) && c->write){

Current policy is not explicitly initializing variables to zero. If this causes
problems, there's a bug in the routine that clears the BSS on kernel entry.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
