Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5QJJaS05976
	for linux-mips-outgoing; Tue, 26 Jun 2001 12:19:36 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5QJJVV05973
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 12:19:31 -0700
Received: from rose.sonytel.be (rose.sonytel.be [10.17.0.5])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id VAA29041;
	Tue, 26 Jun 2001 21:18:16 +0200 (MET DST)
Date: Tue, 26 Jun 2001 21:18:10 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Pete Popov <ppopov@pacbell.net>
cc: Scott A McConnell <samcconn@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: mmap problems ? in 2.4.5
In-Reply-To: <3B38BB9F.9050203@pacbell.net>
Message-ID: <Pine.GSO.4.10.10106262117320.9717-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 26 Jun 2001, Pete Popov wrote:
> Scott A McConnell wrote:
> >I have a simple program that maps a frame buffer into user space and
> >draws an image
> >onto the fb.
> >
> >This program worked fine under 2.4.3 however under 2.4.5 the program
> >runs but nothing appears on the FB. The memory I am writing to does not
> >appear to be the frame buffer.
> >
> >Nothing has changed in my fb driver so I am wondering if anything has
> >changed in how memory is mapped via the kernel?
> >
> I believe the frame buffer driver interface changed in 2.4.5. It 
> supposed to be much cleaner now and the fb driver has to do less than 
> before.  You'll probably need to port your driver to 2.4.5.  If you have 
> any problems, I think the fb maintainers can help you out.

No, those fundamental changes are scheduled for 2.5.x.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
