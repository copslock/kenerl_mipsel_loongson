Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2010 17:00:48 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48661 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492005Ab0HQPAl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Aug 2010 17:00:41 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7HF0auq008370;
        Tue, 17 Aug 2010 16:00:36 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7HF0ZBg008361;
        Tue, 17 Aug 2010 16:00:35 +0100
Date:   Tue, 17 Aug 2010 16:00:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     David Daney <david.s.daney@gmail.com>,
        linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: remove RELOC_HIDE on __pa_symbol
Message-ID: <20100817150035.GC17861@linux-mips.org>
References: <1281297456-2711-1-git-send-email-namhyung@gmail.com>
 <4C5F8ED8.90301@gmail.com>
 <20100809122147.GA23053@linux-mips.org>
 <1281409628.1670.11.camel@leonhard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1281409628.1670.11.camel@leonhard>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 10, 2010 at 12:07:08PM +0900, Namhyung Kim wrote:

> I've sent basically same patch to x86 folks [1] and they said there is a
> possiblility of miscompilation on gcc 3. I am not sure the same goes
> here on mips but it might be safer to keep it. Sorry for the noise ;-(
> 
> [1] http://lkml.org/lkml/2010/8/8/138

So in a distant future when GCC 3.x will finally be retired we will be
able to apply this patch, sigh.  I'll drop your patch for the time being
and add a comment to the code.

Thanks!

  Ralf
