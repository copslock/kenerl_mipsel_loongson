Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B6N1Rw015018
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 23:23:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B6N15w015017
	for linux-mips-outgoing; Wed, 10 Jul 2002 23:23:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail2.sonytel.be [195.0.45.172])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B6MrRw015008;
	Wed, 10 Jul 2002 23:22:54 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id IAA07996;
	Thu, 11 Jul 2002 08:26:18 +0200 (MET DST)
Date: Thu, 11 Jul 2002 08:26:18 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter De Schrijver <p2@ace.ulyssis.org>
cc: Wim Peeters <wim@sonycom.com>, lionel@sonycom.com, thomasv@sonycom.com,
   Nico De Ranter <Nico.DeRanter@sonycom.com>, tea@sonycom.com,
   joel@sonycom.com, Tom Michiels <michiels@CoWare.com>,
   Gorik De Samblanx <gds@denayer.wenk.be>, Peter De Schrijver <p2@mind.be>,
   Ralf Baechle <ralf@oss.sgi.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: Patch for DDB5074 support
In-Reply-To: <20020710234935.A31932@ace.ulyssis.org>
Message-ID: <Pine.GSO.4.21.0207110825370.8371-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 10 Jul 2002, Peter De Schrijver wrote:
> This patch should be the right one for ddb-5074. 

I think you need a few more s/547./5074/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
