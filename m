Received:  by oss.sgi.com id <S553948AbQKANgu>;
	Wed, 1 Nov 2000 05:36:50 -0800
Received: from u-199.karlsruhe.ipdial.viaginterkom.de ([62.180.18.199]:39183
        "EHLO u-199.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553945AbQKANgf>; Wed, 1 Nov 2000 05:36:35 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869089AbQKANgL>;
        Wed, 1 Nov 2000 14:36:11 +0100
Date:   Wed, 1 Nov 2000 14:36:11 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Mike Klar <mfklar@ponymail.com>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: userspace spinlocks
Message-ID: <20001101143611.B7375@bacchus.dhis.org>
References: <39FF414D.6B0A553C@mvista.com> <NDBBIDGAOKMNJNDAHDDMIECFCNAA.mfklar@ponymail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <NDBBIDGAOKMNJNDAHDDMIECFCNAA.mfklar@ponymail.com>; from mfklar@ponymail.com on Tue, Oct 31, 2000 at 10:50:39PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 31, 2000 at 10:50:39PM -0800, Mike Klar wrote:

> > BTW, I didn't know the kernel already has ll/sc emulation.  That seems
> > to be necessary, even just for the binary compability sake.
> 
> It's not complete in the Linux-MIPS tree, it is at least more so in the
> Linux VR tree, but still only supports locking between user contexts.  Patch
> is below, sorry if it doesn't apply cleanly, there were a few bits that I
> cut out that weren't pertinent to LL/SC.
> 
> The bits that have to do with ll_task in the below patch look wrong, though,
> and I only just noticed when preparing this patch that it had gotten added.
> I'm not sure what the motivation for adding it was, maybe clearing ll_bit
> only on context switches was not sufficient to cover all cases (like thread
> creation, maybe?), but I thought I had looked into that already.

Ok, I'll take this and try to hack it into shape.  I especially don't
like putting anything into the scheduler - another 5 ns for a 200MHz box
per cotext switch go down the drain.  For sanity reasons I also think we
don't want to support SMP for the ll/sc emulation.

  Ralf
