Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 19:36:34 +0000 (GMT)
Received: from mail.onstor.com ([66.201.51.107]:42411 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20030212AbXLCTg0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Dec 2007 19:36:26 +0000
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Dec 2007 11:36:19 -0800
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Dec 2007 11:36:18 -0800
Date:	Mon, 3 Dec 2007 11:36:18 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add code to determine the L2 cache size on Sibyte
 1250/112x processors.
Message-ID: <20071203113618.0a37c718@ripper.onstor.net>
In-Reply-To: <20071203192010.GA14818@linux-mips.org>
References: <20071203175601.GA26533@onstor.com>
	<20071203192010.GA14818@linux-mips.org>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2007 19:36:18.0371 (UTC) FILETIME=[C678C130:01C835E3]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Mon, 3 Dec 2007 19:20:10 +0000 Ralf Baechle <ralf@linux-mips.org>
wrote:

> On Mon, Dec 03, 2007 at 09:56:11AM -0800, Andrew Sharp wrote:
> 
> >  arch/mips/mm/c-sb1.c                 |   70
> > ++++++++++++++++++++++++++++++++++
> 
> c-sb1.c does no longer exist.  The functionality was folded into
> c-r4k.c and at the same time alot of insanity aka pass 1 workarounds
> dropped.

Doh.  I knew that, too.  Mindlessly trying to clear my patch backlog...
