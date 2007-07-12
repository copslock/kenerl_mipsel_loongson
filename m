Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 00:50:08 +0100 (BST)
Received: from mail1.pearl-online.net ([62.159.194.147]:46689 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20023078AbXGLXuG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jul 2007 00:50:06 +0100
Received: from SNaIlmail.Peter (85.233.43.43.static.cablesurf.de [85.233.43.43])
	by mail1.pearl-online.net (Postfix) with ESMTP id 0438FC988;
	Fri, 13 Jul 2007 01:49:58 +0200 (CEST)
Received: from Opal.Peter (Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id G17DZ71u000820;
	Thu, 7 Feb 2036 14:35:08 +0100
Received: from Opal.Peter (localhost [127.0.0.1])
	by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Sendmail/Linux 2.4.24-1-386) with ESMTP id l6CNo73U001559;
	Fri, 13 Jul 2007 01:50:07 +0200
Received: from localhost (pf@localhost)
	by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Debian-1) with ESMTP id l6CNo7Mq001555;
	Fri, 13 Jul 2007 01:50:07 +0200
X-Authentication-Warning: Opal.Peter: pf owned process doing -bs
Date:	Fri, 13 Jul 2007 01:50:07 +0200 (CEST)
From:	post@pfrst.de
X-Sender: pf@Opal.Peter
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use NULL for pointer
In-Reply-To: <20070713.014949.55147875.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.21.0707130135090.1523-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Please excuse me, i couldn't restrain myself from commenting on this.
It's a pity, that a weird warning (which gcc version with what settings
did produce it ?) urges one to (re-)introduce this obsolescent macro.

"6.3.2.3 Pointers
 ...
 3 An integer constant expression with the value 0, or such an
   expression cast to type void*, is called a null pointer constant.
   If a null pointer constant is assigned to or compared for equality
   to a pointer, the constant is converted to a pointer of that type..."

"7.17 Common definitions <stddef.h>
 ...
  NULL
 which expands to an implementation-defined null pointer constant..." 

And pre-ISO-Standard C compilers de-facto behaved the same way.

So, NULL simply isn't a "better" null pointer constant than plain 0. It
is a relic from the (good old ?) times, when no prototypes were available,
and one needed another way to ensure the proper type (width) of function
arguments.  (C++ could do without it from the very beginning)
In other words, the code seems to be more correct than the warning.


In the hope of neither having been too much off-topic nor having offended
anyone...

peter


On Fri, 13 Jul 2007, Atsushi Nemoto wrote:

> Date: Fri, 13 Jul 2007 01:49:49 +0900 (JST)
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> To: linux-mips@linux-mips.org
> Cc: ralf@linux-mips.org
> Subject: [PATCH] Use NULL for pointer
> 
> This fixes a sparse warning:
> 
> arch/mips/kernel/traps.c:376:44: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 80ea4fa..5e9fa83 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -373,7 +373,7 @@ asmlinkage void do_be(struct pt_regs *regs)
>  		action = MIPS_BE_FIXUP;
>  
>  	if (board_be_handler)
> -		action = board_be_handler(regs, fixup != 0);
> +		action = board_be_handler(regs, fixup != NULL);
>  
>  	switch (action) {
>  	case MIPS_BE_DISCARD:
> 
> 
> 
