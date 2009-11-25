Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 16:01:38 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43694 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492901AbZKYPBc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 16:01:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAPF1f90009562;
        Wed, 25 Nov 2009 15:01:41 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAPF1fVs009561;
        Wed, 25 Nov 2009 15:01:41 GMT
Date:   Wed, 25 Nov 2009 15:01:41 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaud Patard <arnaud.patard@rtp-net.org>
Cc:     Florian Lohoff <flo@rfc822.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org
Subject: Re: Syncing CPU caches from userland on MIPS
Message-ID: <20091125150141.GB7977@linux-mips.org>
References: <20091124182841.GE17477@hall.aurel32.net> <20091125140105.GB13938@paradigm.rfc822.org> <87pr76acu2.fsf@lechat.rtp-net.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pr76acu2.fsf@lechat.rtp-net.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 03:39:01PM +0100, Arnaud Patard wrote:

> > Would this only evict stuff from the ICACHE? When trying to execute
> > a just written buffer and with a writeback DCACHE you would need to 
> > explicitly writeback the DCACHE to memory and invalidate the ICACHE.
> 
> we already though about using BCACHE instead of ICACHE only but it
> didn't make any difference. the bug is still there.

That argument is ignored; the kernel will always do whatever it takes to
get the I-cache consistent.

  Ralf
