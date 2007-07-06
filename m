Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 10:01:46 +0100 (BST)
Received: from europa.telenet-ops.be ([195.130.137.75]:64944 "EHLO
	europa.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022501AbXGFJBl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 10:01:41 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by europa.telenet-ops.be (Postfix) with SMTP id 2594B416E;
	Fri,  6 Jul 2007 11:01:41 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by europa.telenet-ops.be (Postfix) with ESMTP id F29364183;
	Fri,  6 Jul 2007 11:01:40 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-4) with ESMTP id l6691ehp002946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 6 Jul 2007 11:01:40 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l6691e7l002943;
	Fri, 6 Jul 2007 11:01:40 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 6 Jul 2007 11:01:40 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	TJ <tj.trevelyan@gmail.com>
Cc:	"sknauert@wesleyan.edu" <sknauert@wesleyan.edu>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Fwd: [RFC] SGI O2 MACE audio ALSA module
In-Reply-To: <6849c8890707060130q79a2890eq51001b18fd21519f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0707061058410.2286@anakin>
References: <6849c8890707020427q47704326od05ebb8241c3cf@mail.gmail.com>
 <6849c8890707040125x34cb2b0jf7acfabfa0bf351f@mail.gmail.com>
 <43914.129.133.92.31.1183709449.squirrel@webmail.wesleyan.edu>
 <6849c8890707060130q79a2890eq51001b18fd21519f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 Jul 2007, TJ wrote:
> I can see the case against other uses of typedef, but I really do not
> see why typedef struct is so bad. seeing 'struct mything_s *foo;'
> doesn't really tell you anything more about foo then 'mything_t *foo;'
> does. If a typedef was something other then a struct then I would want
> it to have an obvious name that said such, eg 'u64'. (I really don't
> like 'size_t')

You can have simple forward declarations for structs:

    struct mystruct;

    extern void myfunc(struct mystruct *p);

while you need the full struct definition for typedefs:

    typedef struct mystruct {
	int myfield;
    } mytype_t;

    extern void myfunc(mytype_t *p);

I.e. more (possibly circular) include dependencies.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
