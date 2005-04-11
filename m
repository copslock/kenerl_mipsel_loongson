Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 17:10:11 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:59148 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226119AbVDKQJ4>; Mon, 11 Apr 2005 17:09:56 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3BG9lcc027870;
	Mon, 11 Apr 2005 17:09:47 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3BG9lKZ027869;
	Mon, 11 Apr 2005 17:09:47 +0100
Date:	Mon, 11 Apr 2005 17:09:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergio Ruiz <quekio@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linking assembled PIC code with Linux libc library
Message-ID: <20050411160947.GH7038@linux-mips.org>
References: <e02bc66105040905091efb3dc6@mail.gmail.com> <20050409134919.GA4738@nevyn.them.org> <e02bc661050409113820cceae3@mail.gmail.com> <20050409215140.GA15253@nevyn.them.org> <e02bc66105041012091afdf306@mail.gmail.com> <e02bc661050410122733e21927@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e02bc661050410122733e21927@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 10, 2005 at 09:27:58PM +0200, Sergio Ruiz wrote:

> But if I use GCC with my assembler code, and I use a simple 'printf'
> function, the assembler code I get is totally different than the
> original one, so I cant debug it.

Sounds like you're being surprised by the gcc 3.4 optimization where gcc
may replace certain functions such as printf with a whole sequence of
calls to more basic stdio functions?

  Ralf
