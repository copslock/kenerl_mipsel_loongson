Received:  by oss.sgi.com id <S553792AbRCFM7y>;
	Tue, 6 Mar 2001 04:59:54 -0800
Received: from u-91-10.karlsruhe.ipdial.viaginterkom.de ([62.180.10.91]:26884
        "EHLO u-91-10.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553651AbRCFM7b>; Tue, 6 Mar 2001 04:59:31 -0800
Received: from dea ([193.98.169.28]:7552 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867055AbRCFM7U>;
	Tue, 6 Mar 2001 13:59:20 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f26CwuB05839;
	Tue, 6 Mar 2001 13:58:56 +0100
Date:	Tue, 6 Mar 2001 13:58:56 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	ldavies@oz.agile.tv
Cc:	linux-mips@oss.sgi.com
Subject: Re: Troubles with TLB refills
Message-ID: <20010306135856.E1184@bacchus.dhis.org>
References: <3AA30A91.B5842678@agile.tv> <20010305114926.A26862@bacchus.dhis.org> <3AA45523.CDF351CB@agile.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA45523.CDF351CB@agile.tv>; from ldavies@agile.tv on Tue, Mar 06, 2001 at 01:10:27PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Mar 06, 2001 at 01:10:27PM +1000, Liam Davies wrote:

> in terms of instruction encodings. I would have thought the cpu would have
> crapped out when it hit bad instructions. So it would seem the
> exceptions were occurring but the code that it was executing wasn't even code.
> Hence my assumption that we never got a TLB refill., even though the fault
> handler was being called.

Probably somewhere in the garbage there was another memory reference
which resulted in a second TLB exception, at that time a store to 0x10004f4c
which then got handled via the general exception handler and resulted in
do_page_fault being called.

  Ralf
