Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 16:44:11 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60861 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490984Ab0EYOoI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 May 2010 16:44:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4PEi15I007063;
        Tue, 25 May 2010 15:44:01 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4PEi1KL007061;
        Tue, 25 May 2010 15:44:01 +0100
Date:   Tue, 25 May 2010 15:44:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     octane indice <octane@alinto.com>
Cc:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
Message-ID: <20100525144400.GA30900@linux-mips.org>
References: <1274711094.4bfa8c3675983@www.inmano.com>
 <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
 <20100525131341.GA26500@linux-mips.org>
 <1274795905.4bfbd781a17fa@www.inmano.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1274795905.4bfbd781a17fa@www.inmano.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 25, 2010 at 03:58:25PM +0200, octane indice wrote:

> Ok. I'm following the info there:
> http://www.linux-mips.org/wiki/Toolchains
> but infos seems a bit old, so I followed the main idea
> with newer binutils and gcc-4.4.4

That page just documents available toolchains and is suffering from too
many details.  Somebody should do a bit weed killing on that page.

The build dependencies for the kernel are documented on

  http://www.linux-mips.org/wiki/Kernel_Build

which I've updated just before my previous posting.

> It is still compiling gcc. When it will finish, I will ping back
> and say if it compiles an octeon kernel 2.6.34

It will :-)

  Ralf
