Received:  by oss.sgi.com id <S554032AbRAQNVW>;
	Wed, 17 Jan 2001 05:21:22 -0800
Received: from [193.74.243.200] ([193.74.243.200]:63132 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S554029AbRAQNVK>;
	Wed, 17 Jan 2001 05:21:10 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA13151;
	Wed, 17 Jan 2001 14:17:33 +0100 (MET)
Date:   Wed, 17 Jan 2001 14:17:33 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Ian Chilton <ian@ichilton.co.uk>
cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, ralf@oss.sgi.com,
        linux-mips@oss.sgi.com
Subject: Re: Kernel Report - 010117 (2.4.0)
In-Reply-To: <20010117125603.A29302@woody.ichilton.co.uk>
Message-ID: <Pine.GSO.4.10.10101171415510.739-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 17 Jan 2001, Ian Chilton wrote:
> OK..this is the normal kernel straight from CVS (010117) on my I2 (not
> Indy as in yesturday..)
> 
> It seems a lot of things are repeated for some reason ?!?

That's because printk() now uses the prom print routine as well. So you see
  - all early messages (before console init)
  - repeat of all early messages when the console is initialized
  - two copies of each message (after console init)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
