Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54LHMe12069
	for linux-mips-outgoing; Mon, 4 Jun 2001 14:17:22 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54LHLh12065
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 14:17:21 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA26172;
	Mon, 4 Jun 2001 14:17:14 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA07844;
	Mon, 4 Jun 2001 14:17:11 -0700 (PDT)
Message-ID: <033701c0ed3c$59ccf980$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ian Thompson" <iant@palmchip.com>
Cc: <linux-mips@oss.sgi.com>
References: <3B1BC6B8.C58758FA@palmchip.com> <02a901c0ed2b$2eac6300$0deca8c0@Ulysses> <3B1BEF48.AB0E568C@palmchip.com>
Subject: Re: dcache_blast() bug?
Date: Mon, 4 Jun 2001 23:21:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Interesting, in that the 4Kc has write-through caches,
which make it a good deal more difficult to get into
the kind of trouble you describe.  Are you running one
of the 4Kc "lead vehicle" chips, or some other part?
Which version of the kernel are you running, and are
the CPU type and cache organization being reported
correctly during boot-up?

The output you report from dumping the command line
sounds is interesting.  The corruption seems to be in
8-byte chunks - the first 8 have disappeared, as has
the third 8.  Lord knows where the "0" in "ra0" comes
from.  Can you confirm that (a) the command line string
is stored at an 8-byte aligned boundary, and (b) whether
the data is actually being moved, or if the missing
characters are simply being replaced with nulls or other
non-printable characters?  I know it's not pretty, but
can you dump the same memory addresses as seen
through non-cacheable kseg1 (0xa0000000-0xbfffffff),
and are the cache and memory consistent?

If the failure is happening on 8-byte, doubleword aligned
chunks, I suspect a hardware problem more than a
kernel bug.  If it were my system, I'd re-seat the RAM
and CPU modules to make sure I'm not simply getting
screwed by a bad connection when the memory interface
suddenly gets hit with a lot of traffic following the flush.

            Kevin K.

----- Original Message -----
From: "Ian Thompson" <iant@palmchip.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Monday, June 04, 2001 10:27 PM
Subject: Re: dcache_blast() bug?


> oops sorry i meant to mention that.  running a mips 4kc.
>
>
>
> "Kevin D. Kissell" wrote:
> >
> > What processor are you running?
> >
> >             Kevin K.
> >
> > ----- Original Message -----
> > From: "Ian Thompson" <iant@palmchip.com>
> > To: <linux-mips@oss.sgi.com>
> > Sent: Monday, June 04, 2001 7:34 PM
> > Subject: dcache_blast() bug?
> >
> > >
> > > Hi all,
> > >
> > > I'm seeing some odd memory behavior around the time when
blast_dcache()
> > > is called, leading me to think that the method may be a little buggy.
> > > It appears that memory is being corrupted (consistently so) over the
> > > course of flushing the dcache.  This happens to my command line
argument
> > > string - arcs_cmdline.  Before the blast_dcache() call, it is
> > > "console=ttyS0 ramdisk_start=0x9fcf0000 load_ramdisk=1", and after the
> > > call, the corrupted data is "ttyS0 ra0".  I take it this isn't
supposed
> > > to happen?  any ideas of why the writeback_invalidate_d cache
operation
> > > may be losing data?
> > >
> > > thanks,
> > > -ian
> > >
> > >
> > > --
> > > ----------------------------------------
> > > Ian Thompson           tel: 408.952.2023
> > > Firmware Engineer      fax: 408.570.0910
> > > Palmchip Corporation   www.palmchip.com
>
> --
> ----------------------------------------
> Ian Thompson           tel: 408.952.2023
> Firmware Engineer      fax: 408.570.0910
> Palmchip Corporation   www.palmchip.com
