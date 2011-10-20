Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2011 21:07:16 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:35000 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491184Ab1JTTHJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2011 21:07:09 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1RGxxM-0006gz-00; Thu, 20 Oct 2011 21:07:08 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 0EBD51DA27; Thu, 20 Oct 2011 21:07:02 +0200 (CEST)
Date:   Thu, 20 Oct 2011 21:07:02 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] GIO bus support for SGI IP22/28
Message-ID: <20111020190701.GA30021@alpha.franken.de>
References: <20111020150859.6072A1DA26@solo.franken.de>
 <20111020161908.GA13220@linux-mips.org>
 <CAMuHMdXuOAgwPKTUjBCp3t1_kWoJsiwGf=uQfmYP_o+t7JYxUA@mail.gmail.com>
 <20111020174922.GC885@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111020174922.GC885@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15225

On Thu, Oct 20, 2011 at 06:49:22PM +0100, Ralf Baechle wrote:
> There may have been obscure prototypes at SGI but I doubt any non-MIPS
> GIO systems ever reached production status.

wikipedia only mentions MIPS based stuff from SGI with GIO.

> > If yes, you want to move it to drivers/gio/.
> 
> Good point - it probably should go there anyway.

does a single file really need it's own directoy ? GIO is pretty simple
and most of the magic lies inside the board specific parts. My idea is
to factor out the common code as soon as IP12/IP20 support comes up
(which is probably never).

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
