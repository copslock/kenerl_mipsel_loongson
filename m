Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 21:16:42 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:52498 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S28578682AbYCUVQk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 21:16:40 +0000
Received: from SNaIlmail.Peter (85.233.32.210.static.cablesurf.de [85.233.32.210])
	by mail1.pearl-online.net (Postfix) with ESMTP id D408EC0D9;
	Fri, 21 Mar 2008 22:16:34 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id m2L0gGfM001336;
	Fri, 21 Mar 2008 01:42:16 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id m2LL7cFS000532;
	Fri, 21 Mar 2008 22:07:38 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id m2LL7cQb000529;
	Fri, 21 Mar 2008 22:07:38 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Fri, 21 Mar 2008 22:07:38 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] IP28: fix MC GIOPAR setting
In-Reply-To: <20080321194737.GA8398@alpha.franken.de>
Message-ID: <Pine.LNX.4.58.0803212125050.523@Indigo2.Peter>
References: <Pine.LNX.4.58.0803211535570.423@Indigo2.Peter>
 <20080321194737.GA8398@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



On Fri, 21 Mar 2008, Thomas Bogendoerfer wrote:

> Date: Fri, 21 Mar 2008 20:47:37 +0100
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: peter fuerst <post@pfrst.de>
> Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
> Subject: Re: [PATCH] IP28: fix MC GIOPAR setting
>
> On Fri, Mar 21, 2008 at 04:03:16PM +0100, peter fuerst wrote:
> > We must not omit the MASTERGFX setting, unless we want Impact DMA to hang ;-)
>
> is there a reason to restrict this to IP28 only ?

Would indeed be most surprising, if this isn't appropriate for any Indigo2-
Impact, but don't know for sure.  And can't check, whether it at least doesn't
hurt Non-Impact Indigo2.  Of course, being able to avoid '#ifdef' at all would
be the prettiest alternative.

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessary a
> good idea.                                                [ RFC1925, 2.3 ]
>
>
