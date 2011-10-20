Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2011 18:19:15 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42803 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491157Ab1JTQTL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2011 18:19:11 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9KGJ9pR023171;
        Thu, 20 Oct 2011 17:19:09 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9KGJ8Yi023153;
        Thu, 20 Oct 2011 17:19:08 +0100
Date:   Thu, 20 Oct 2011 17:19:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] GIO bus support for SGI IP22/28
Message-ID: <20111020161908.GA13220@linux-mips.org>
References: <20111020150859.6072A1DA26@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111020150859.6072A1DA26@solo.franken.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15135

On Thu, Oct 20, 2011 at 05:08:59PM +0200, Thomas Bogendoerfer wrote:

> SGI IP22/IP28 machines have GIO busses for adding graphics and other
> extension cards. This patch adds support for GIO driver/device
> handling and converts the newport console driver to a GIO driver.

I like it - finally proper driver structure in the year 15 of Indy
support :D

I usually ask submitters to consider if they want to change their newly
exported kernel symbols from EXPORT_SYMBOL to EXPORT_SYMBOL_GPL.  This
may not be relevant for this platform - I'm just asking all submitters
equally.

Also please cc the drivers/video/ maintainer.

Thanks!

  Ralf
