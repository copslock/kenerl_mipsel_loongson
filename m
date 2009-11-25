Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 16:41:53 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39532 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492977AbZKYPlu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 16:41:50 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAPFg3Wi010337;
        Wed, 25 Nov 2009 15:42:03 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAPFg2ch010335;
        Wed, 25 Nov 2009 15:42:02 GMT
Date:   Wed, 25 Nov 2009 15:42:02 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Is it possible to reset non-zero cpus in kernel?
Message-ID: <20091125154202.GC7977@linux-mips.org>
References: <e997b7420911250712n3380225racdaad413c5b0b53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e997b7420911250712n3380225racdaad413c5b0b53@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 11:12:07PM +0800, wilbur.chan wrote:

> Does anyone here has ever used a mips XLR machine?
> 
> 
> Though xlr arch is not supported by kernel source tree, I hope there
> might be someone using xlr on this maillst ,plz help.

And I hope RMI / Netlogic will change their mind on this ...

> In a mips64 arch, is it possible to reset all the cores ,except for
> NO.0 core , into the 'msgwait' state?

The MIPS64 architecture specification doesn't cover how to trigger a reset
signal to a processor.  Iow this is system specific; check the XLR
documentation.

  Ralf
