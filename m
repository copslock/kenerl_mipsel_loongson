Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 11:32:44 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:21194 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8224924AbUJKKcj>;
	Mon, 11 Oct 2004 11:32:39 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i9BAWWla020030
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Oct 2004 12:32:32 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i9BAWWEd020028;
	Mon, 11 Oct 2004 12:32:32 +0200
Date: Mon, 11 Oct 2004 12:32:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
Message-ID: <20041011103231.GA19949@lst.de>
References: <1097452888.4627.25.camel@localhost.localdomain> <Pine.LNX.4.58L.0410110126120.4217@blysk.ds.pg.gda.pl> <1097481328.27818.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097481328.27818.10.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

> ===================================================================
> RCS file: arch/mips/mm/remap.c
> diff -N arch/mips/mm/remap.c
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ arch/mips/mm/remap.c	19 Sep 2004 22:51:21 -0000
> @@ -0,0 +1,115 @@
> +/*
> + *  arch/mips/mm/remap.c
> + *
> + *  A copy of mm/memory.c, with mods for 64 bit physical I/O addresses on
> + *  32 bit native word platforms.

This is horrible.  Please submit any modifications you'll need over
remap_page_pfn (as in -mm) that you still need and ensure they're
portable.
