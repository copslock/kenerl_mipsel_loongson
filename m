Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Dec 2009 11:42:03 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48426 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492230AbZLEKl7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Dec 2009 11:41:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB5AfwmJ011844;
        Sat, 5 Dec 2009 10:41:58 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB5Afw3Y011842;
        Sat, 5 Dec 2009 10:41:58 GMT
Date:   Sat, 5 Dec 2009 10:41:58 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] [MIPS] mipssim: remove unused code
Message-ID: <20091205104158.GA11800@linux-mips.org>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
 <1255546939-3302-2-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255546939-3302-2-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 14, 2009 at 10:02:17PM +0300, Dmitri Vorobiev wrote:

> The function prom_init_cmdline() doesn't do anything, and nobody calls
> the prom_getcmdline() function. Since these two are the only functions
> in the file arch/mips/mipssim/sim_cmdline.c, the whole file can be
> removed now along with the call to the no-op prom_init_cmdline()
> routine.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>

And obviously not compile tested:

  CC      arch/mips/mipssim/sim_int.o
make[3]: *** No rule to make target `arch/mips/mipssim/sim_cmdline.o', needed by `arch/mips/mipssim/built-in.o'.  Stop.
make[2]: *** [arch/mips/mipssim] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

  Ralf
