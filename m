Received:  by oss.sgi.com id <S553803AbRAOGdP>;
	Sun, 14 Jan 2001 22:33:15 -0800
Received: from [193.74.243.200] ([193.74.243.200]:26325 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553797AbRAOGc7>;
	Sun, 14 Jan 2001 22:32:59 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id HAA02498;
	Mon, 15 Jan 2001 07:31:56 +0100 (MET)
Date:   Mon, 15 Jan 2001 07:31:57 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Justin Carlson <carlson@sibyte.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS
In-Reply-To: <01011213554701.08038@plugh.sibyte.com>
Message-ID: <Pine.GSO.4.10.10101150730420.4392-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 12 Jan 2001, Justin Carlson wrote:
> I still would rather stick to the switch style of doing things in the future,
> though, because it's a bit more flexible; if you've got companies that fix
> errata without stepping PrID revisions or some such, then the table's going to
> have some strange special cases that don't quite fit.
> 
> But this is much more workable than what I *thought* you were proposing.  And
> not worth nearly as much trouble as I've been giving you over it.    

Then don't use a probe table, but a switch based CPU detection routine that
fills in a table of function pointers. So you need the switch only once.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
