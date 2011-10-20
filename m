Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2011 19:49:35 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43157 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491184Ab1JTRt2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2011 19:49:28 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9KHnNfr021323;
        Thu, 20 Oct 2011 18:49:23 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9KHnMx3021320;
        Thu, 20 Oct 2011 18:49:22 +0100
Date:   Thu, 20 Oct 2011 18:49:22 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] GIO bus support for SGI IP22/28
Message-ID: <20111020174922.GC885@linux-mips.org>
References: <20111020150859.6072A1DA26@solo.franken.de>
 <20111020161908.GA13220@linux-mips.org>
 <CAMuHMdXuOAgwPKTUjBCp3t1_kWoJsiwGf=uQfmYP_o+t7JYxUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXuOAgwPKTUjBCp3t1_kWoJsiwGf=uQfmYP_o+t7JYxUA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15206

On Thu, Oct 20, 2011 at 07:14:36PM +0200, Geert Uytterhoeven wrote:

> On Thu, Oct 20, 2011 at 18:19, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Thu, Oct 20, 2011 at 05:08:59PM +0200, Thomas Bogendoerfer wrote:
> >
> >> SGI IP22/IP28 machines have GIO busses for adding graphics and other
> >> extension cards. This patch adds support for GIO driver/device
> >> handling and converts the newport console driver to a GIO driver.
> >
> > I like it - finally proper driver structure in the year 15 of Indy
> > support :D
> 
> Did GIO ever appeared on non-MIPS platforms?

There may have been obscure prototypes at SGI but I doubt any non-MIPS
GIO systems ever reached production status.

> If yes, you want to move it to drivers/gio/.

Good point - it probably should go there anyway.

  Ralf
