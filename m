Received:  by oss.sgi.com id <S554098AbRBEFHm>;
	Sun, 4 Feb 2001 21:07:42 -0800
Received: from c824216-a.stcla1.sfba.home.com ([24.176.212.15]:18420 "EHLO
        dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP id <S554093AbRBEFHW>;
	Sun, 4 Feb 2001 21:07:22 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1551Xc27528;
	Sun, 4 Feb 2001 21:01:33 -0800
Date:   Sun, 4 Feb 2001 21:01:33 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Calvine Chew <calvine@sgi.com>
Cc:     "'linux-mips'" <linux-mips@oss.sgi.com>
Subject: Re: Where can I find precompiled binaries for XFree86 4.0.2?
Message-ID: <20010204210132.A27490@bacchus.dhis.org>
References: <43FECA7CDC4CD411A4A3009027999112267E4A@sgp-apsa001e--n.singapore.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <43FECA7CDC4CD411A4A3009027999112267E4A@sgp-apsa001e--n.singapore.sgi.com>; from calvine@sgi.com on Fri, Feb 02, 2001 at 09:51:29AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Feb 02, 2001 at 09:51:29AM +0800, Calvine Chew wrote:
> From: Calvine Chew <calvine@sgi.com>
> To: "'linux-mips'" <linux-mips@oss.sgi.com>
> Subject: Where can I find precompiled binaries for XFree86 4.0.2?
> Date:   Fri, 2 Feb 2001 09:51:29 +0800 
> 
> Hello all.
> 
> Anyone know where I can grab the above? I am encountering problems with
> building my own on Hardhat 5.1. make world looked okay but make install died
> trying to make the shared library X11lib.so.6.2~ (ld terminated with signal
> 6).

Hardhat is extremly rotten and buggy code by today's standard.  You really
want to replace it with a more current distribution before you even
attempt to compile a current X.

  Ralf
