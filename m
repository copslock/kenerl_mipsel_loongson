Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f396jKT28762
	for linux-mips-outgoing; Sun, 8 Apr 2001 23:45:20 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f396jJM28759
	for <linux-mips@oss.sgi.com>; Sun, 8 Apr 2001 23:45:19 -0700
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA02732;
	Mon, 9 Apr 2001 08:40:59 +0200 (MET DST)
Date: Mon, 9 Apr 2001 08:40:46 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Keith M Wesolowski <wesolows@foobazco.org>
cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: RFC: Cleanup/detection patch
In-Reply-To: <20010405004618.A30899@foobazco.org>
Message-ID: <Pine.GSO.4.10.10104090839440.2828-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 5 Apr 2001, Keith M Wesolowski wrote:
> (or, it must be overwritten by bootup code with nop if it's not
> supported *shudder*).

FYI, this approach is currently being implemented on PPC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
