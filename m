Received:  by oss.sgi.com id <S553818AbRAOIi1>;
	Mon, 15 Jan 2001 00:38:27 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:38390 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553806AbRAOIiE>; Mon, 15 Jan 2001 00:38:04 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867058AbRAOIhZ>; Mon, 15 Jan 2001 06:37:25 -0200
Date:	Mon, 15 Jan 2001 06:37:25 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	jsun@mvista.com (Jun Sun), carlson@sibyte.com,
        linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS ...
Message-ID: <20010115063725.C8866@bacchus.dhis.org>
References: <3A5F68CB.78D693B3@mvista.com> <E14HDwC-0005GH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14HDwC-0005GH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 12, 2001 at 11:48:50PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 12, 2001 at 11:48:50PM +0000, Alan Cox wrote:

> > My understanding is that we don't have a standard way to probe for external
> > cache (L2 or L3).  So this problem is not only for MIPS32 cpus.
> 
> Cache is very arch specific. You don't want to know how you find L2 cache
> on a MacII for example 8)

Actually the Indy's R4600 / R5000 second level caches also call for the use
of LARTs in a while (1) loop ;-)  Read the generic code had to be changed
in order to support in a sane way.

  Ralf
