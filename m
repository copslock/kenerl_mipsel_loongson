Received:  by oss.sgi.com id <S553836AbRAIMXz>;
	Tue, 9 Jan 2001 04:23:55 -0800
Received: from mail.sonytel.be ([193.74.243.200]:43952 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553806AbRAIMXn>;
	Tue, 9 Jan 2001 04:23:43 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA08971;
	Tue, 9 Jan 2001 13:15:50 +0100 (MET)
Date:   Tue, 9 Jan 2001 13:15:47 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Michael Shmulevich <michaels@jungo.com>
cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: User applications
In-Reply-To: <3A5AFAC8.CA682600@jungo.com>
Message-ID: <Pine.GSO.4.10.10101091315080.4646-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 9 Jan 2001, Michael Shmulevich wrote:
> As a side question, I would like to to know why exactly the CPU cache operations
> are
> promoted to the syscall status? What is the situation that a user in its program
> would like
> to call cacheflush() ? Unless, of course, he is doing DoS.
> 
> I can understand why we need this in kernel, for context switch, for example, but
> as a syscall?...

For trampolines. These are small pieces of code created on the stack, and
require flushing of the caches before they are excuted.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
