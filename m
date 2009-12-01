Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 01:49:36 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51555 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493219AbZLAAtd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 01:49:33 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB10nsj1004827;
        Tue, 1 Dec 2009 00:49:55 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB10ns5m004825;
        Tue, 1 Dec 2009 00:49:54 GMT
Date:   Tue, 1 Dec 2009 00:49:54 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Adam Nielsen <a.nielsen@shikadi.net>
Cc:     linux-mips@linux-mips.org
Subject: Re: Setting the physical RAM map
Message-ID: <20091201004954.GB31892@linux-mips.org>
References: <4B1135FF.9050908@shikadi.net>
 <20091130214118.GB27721@linux-mips.org>
 <4B14496F.1060108@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B14496F.1060108@shikadi.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 08:38:39AM +1000, Adam Nielsen wrote:

> >It's like a decade that I last read up on these but afair they have a
> >fixed mapping starting at 0x40000000.  It would make perfect sense to
> >use such a CPU in an X terminal.
> 
> Hmm, I'm not sure.  I'd have to peel off the heatsink to be sure I
> guess.  The very first kernel messages print this:
> 
>   CPU revision is: 00002020 (R4600)
>   FPU revision is: 00002020
> 
> So I guess these values would be more specific if the CPU was indeed
> one of those revisions.

No need to scratch off things.  The numbers above clearly identify an
R4600 v2.0.  R4640 and R4650 would return 0x000022xx where xx would be
the processor revision number.  Both are special embedded versions of the
R4600 without MMU.

  Ralf
