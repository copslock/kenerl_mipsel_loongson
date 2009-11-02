Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 13:59:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57608 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493874AbZKBM7x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 13:59:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2D1EFx021328;
	Mon, 2 Nov 2009 14:01:14 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2D1DCt021327;
	Mon, 2 Nov 2009 14:01:13 +0100
Date:	Mon, 2 Nov 2009 14:01:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] alchemy: fix warnings in db1x00/pb1000/pb1550
	board setup code
Message-ID: <20091102130113.GA7292@linux-mips.org>
References: <200910181604.11732.florian@openwrt.org> <f861ec6f0910190412i3910246dgcdf6b8b56a8ed5b3@mail.gmail.com> <20091102112955.GA2821@linux-mips.org> <f861ec6f0911020343v69c8d82q16ad1af7691471af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0911020343v69c8d82q16ad1af7691471af@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 02, 2009 at 12:43:20PM +0100, Manuel Lauss wrote:

> On Mon, Nov 2, 2009 at 12:29 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Mon, Oct 19, 2009 at 01:12:15PM +0200, Manuel Lauss wrote:
> >
> >> I like it, thank you!
> >
> > Except that it a) does things the comments don't mention and b) doesn't
> 
> It does eliminate all the "variable may be unused"-type warnings...
> 
> 
> > apply on top of master or -queue ...
> 
> It did apply against -queue when Floarian initally sent it.  If he doesn't
> resurface in the next few days I'll send an update version.

My bad.  Applied now.

  Ralf
