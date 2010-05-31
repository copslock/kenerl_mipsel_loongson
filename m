Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 12:30:04 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45782 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491919Ab0EaKaA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 31 May 2010 12:30:00 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4VATuCB014004;
        Mon, 31 May 2010 11:29:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4VATt4d014002;
        Mon, 31 May 2010 11:29:55 +0100
Date:   Mon, 31 May 2010 11:29:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
Message-ID: <20100531102954.GA12669@linux-mips.org>
References: <20100530141939.GA22153@merkur.ravnborg.org>
 <20100530153939.GA22352@merkur.ravnborg.org>
 <20100530231954.GA318@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100530231954.GA318@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 31, 2010 at 12:19:54AM +0100, Ralf Baechle wrote:

> > > Note: I tried to test a little with bigsur_defconfig
> > > but get_user() is buggy. Or at least my gcc thinks that
> > > first argument may be used uninitialized.
> > > I think mips needs to fix the 64 bit variant of get_user().
> > > I took a quick look but ran away.
> > 
> > My gcc:
> > mips-linux-gcc (GCC) 4.1.2
> > Copyright (C) 2006 Free Software Foundation, Inc.

I played with it for a bit.  The warning is present in all gcc 4.1.0 to
4.1.2 and it is bogus.  When I first looked into this years ago I just
gave up on gcc 4.1 as a newer version was already available.

The variable returned by get_user is undefined in case of an error, so
what get_user() is doing is entirely legitimate.  This is different from
copy_from_user() which in case of an error will clear the remainder of
the destination area which couldn't not be copied from userspace.

A test compile of a bigsur_defconfig without and with your patch shows
a size increase of only 80 bytes with gcc 4.5.0.  So I'm considering
your patch for inclusion but I want to play with alternatives for a bit.
Outlining may the right thing with modern compilers.

  Ralf
