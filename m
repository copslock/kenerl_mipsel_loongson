Received:  by oss.sgi.com id <S305195AbQDRVy2>;
	Tue, 18 Apr 2000 14:54:28 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25199 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305188AbQDRVyM>; Tue, 18 Apr 2000 14:54:12 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA03686; Tue, 18 Apr 2000 14:58:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA85866
	for linux-list;
	Tue, 18 Apr 2000 14:43:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dhcp-163-154-5-221.engr.sgi.com (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA02464
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Apr 2000 14:43:43 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1406016AbQDRVkl>;
	Tue, 18 Apr 2000 14:40:41 -0700
Date:   Tue, 18 Apr 2000 14:40:41 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mike Klar <mfklar@ponymail.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Unaligned address handling, and the cause of that login problem
Message-ID: <20000418144041.D6271@uni-koblenz.de>
References: <20000417164333.B3123@uni-koblenz.de> <Pine.LNX.4.10.10004181713250.562-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10004181713250.562-100000@cassiopeia.home>; from geert@linux-m68k.org on Tue, Apr 18, 2000 at 05:13:48PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 18, 2000 at 05:13:48PM +0200, Geert Uytterhoeven wrote:

> On Mon, 17 Apr 2000, Ralf Baechle wrote:
> > I'll put __attribute__ ((aligned(64))) to the structure which will fix this.
>                                    ^^
> 8, I suppose?

Of course.

  Ralf
