Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA15054 for <linux-archive@neteng.engr.sgi.com>; Mon, 19 Oct 1998 21:22:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA25244
	for linux-list;
	Mon, 19 Oct 1998 21:21:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA60683
	for <linux@engr.sgi.com>;
	Mon, 19 Oct 1998 21:21:29 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id VAA17379 for linux@engr.sgi.com; Mon, 19 Oct 1998 21:21:29 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199810200421.VAA17379@oz.engr.sgi.com>
Subject: Re: get_mmu_context()
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Mon, 19 Oct 1998 21:21:28 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Forwarding message from David, his email probably changed
so it bounced...

----- Forwarded message from owner-linux@cthulhu -----

From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: imp@village.org
CC: ralf@uni-koblenz.de, linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
In-reply-to: <199810200407.WAA03233@harmony.village.org> (message from Warner
	Losh on Mon, 19 Oct 1998 22:07:26 -0600)
Subject: Re: get_mmu_context()
References: <19981019121804.F387@uni-koblenz.de>  <Pine.SV4.3.91.981016185136.876A-100000@mech.math.msu.su> <XFMail.981018215318.harald.koerfgen@netcologne.de> <199810200407.WAA03233@harmony.village.org>

   Date: Mon, 19 Oct 1998 22:07:26 -0600
   From: Warner Losh <imp@village.org>

   Wouldn't it be easier to have ld to have variant fixup records?
   That way you could patch all instances at run time, much like we do
   when we load stuff now...

See sparc32's btfixup in the kernel sources for the best
implementation I've ever seen.

Later,
David S. Miller
davem@dm.cobaltmicro.com

----- End of forwarded message from owner-linux@cthulhu -----

-- 
Peace, Ariel
