Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2005 08:40:23 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:14328 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8226140AbVGDHkG>;
	Mon, 4 Jul 2005 08:40:06 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j647eEpr002104;
	Mon, 4 Jul 2005 09:40:14 +0200 (MEST)
Date:	Mon, 4 Jul 2005 09:40:04 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Fabrizio Fazzino <fabrizio@fazzino.it>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Assembly macro with parameters
In-Reply-To: <42C7BE64.7020102@fazzino.it>
Message-ID: <Pine.LNX.4.62.0507040934360.11978@numbat.sonytel.be>
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org>
 <4256B5BE.8070708@fazzino.it> <20050408165717.GA8157@nevyn.them.org>
 <42C429C3.2090905@fazzino.it> <Pine.LNX.4.61L.0507010927130.30138@blysk.ds.pg.gda.pl>
 <42C7BE64.7020102@fazzino.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 3 Jul 2005, Fabrizio Fazzino wrote:
> In any case I didn't have to use this feature... I was just missing the
> fact that the opcode evaluation didn't have to happen by declaring an
> int variable (in this case the value is computed at runtime) but by the
> preprocessor, so I solved my problem this way:
> 
> #define NEWOPCODE(base,rd,rs,rt) (base|(rs<<21)|(rt<<16)|(rd<<11))
> #define myopcode(rd,rs,rt) asm(".long %0" : : "i"
> (NEWOPCODE(0xC4000000,rd,rs,rt)))
> 
> and then I call it simply as myopcode(10,8,9).
> 
> By the way, is there any quick way of writing a setreg(reg_num,reg_val)
> C macro to set the value of a register?
> And another one to read the value like a reg2var(reg_num,&result) to put
> the value of a register inside my own C variable?
> I have written my own versions for both but they have a 32-case switch
> statement inside so they are not so efficient...

As long as all arguments are constant and thus known at compile time. the
compiler will optimize away the switch completely (cfr. all those
{put,get}_user() routines).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
