Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2010 13:25:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60319 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491011Ab0HWLZd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Aug 2010 13:25:33 +0200
Date:   Mon, 23 Aug 2010 12:25:33 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: MIPS: Get rid of branches to .subsections.
In-Reply-To: <20100823101257.GA19171@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1008231224160.12012@eddie.linux-mips.org>
References: <20100818124310.GA23744@linux-mips.org> <alpine.LFD.2.00.1008230139480.900@eddie.linux-mips.org> <20100823101257.GA19171@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 23 Aug 2010, Ralf Baechle wrote:

> >  Are you sure it won't reorder anything there that actually relies on the 
> > atomic access to have succeeded?  I suggest adding barrier() after the 
> > loop.
> 
> None of the things that were touched by the code had any barrier
> functionality  Some of the functions such as atomic_add don't provide
> memory barriers but where needed a barrier was always provided by C code
> near the end of the function, for example in atomic_add_return.

 OK, if you are sure this is safe, then I see no problem here.

  Maciej
