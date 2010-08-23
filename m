Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2010 12:13:05 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44035 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490947Ab0HWKNB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Aug 2010 12:13:01 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7NACwdx000871;
        Mon, 23 Aug 2010 11:12:58 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7NACv0X000869;
        Mon, 23 Aug 2010 11:12:57 +0100
Date:   Mon, 23 Aug 2010 11:12:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: MIPS: Get rid of branches to .subsections.
Message-ID: <20100823101257.GA19171@linux-mips.org>
References: <20100818124310.GA23744@linux-mips.org>
 <alpine.LFD.2.00.1008230139480.900@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1008230139480.900@eddie.linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2010 at 01:54:24AM +0100, Maciej W. Rozycki wrote:

> > By rewriting the loop around all simple LL/SC blocks to C we reduce reduce
> > the amount of inline assembler and at the same time allow GCC to often
> > fill the branch delay slots with something sensible or whever else clever
> > optimization it may have up in its sleeve.
> 
>  Are you sure it won't reorder anything there that actually relies on the 
> atomic access to have succeeded?  I suggest adding barrier() after the 
> loop.

None of the things that were touched by the code had any barrier
functionality  Some of the functions such as atomic_add don't provide
memory barriers but where needed a barrier was always provided by C code
near the end of the function, for example in atomic_add_return.

  Ralf
