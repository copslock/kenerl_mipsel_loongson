Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54NS0I32370
	for linux-mips-outgoing; Mon, 4 Jun 2001 16:28:00 -0700
Received: from mail.palmchip.com ([63.203.52.8])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54NRwh32367
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 16:27:58 -0700
Received: from palmchip.com (sabretooth.palmchip.com [10.1.10.110])
	by mail.palmchip.com (8.11.0/8.9.3) with ESMTP id f54NRfc15265;
	Mon, 4 Jun 2001 16:27:41 -0700
Message-ID: <3B1C1AAD.3A62D636@palmchip.com>
Date: Mon, 04 Jun 2001 16:33:01 -0700
From: Ian Thompson <iant@palmchip.com>
Organization: Palmchip Corporation
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: dcache_blast() bug?
References: <3B1BC6B8.C58758FA@palmchip.com> <02a901c0ed2b$2eac6300$0deca8c0@Ulysses> <3B1BEF48.AB0E568C@palmchip.com> <033701c0ed3c$59ccf980$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for your help Kevin.  It may be possible that this is a hardware
bug.  I am using one of the lead vehicle chips with 16k d$ & i$,
although there is some custom hardware which may be causing trouble as
well.  Oh, and this is the 2.4.1 kernel.

It appears that when I copy the arguments into the command line
variable, they are 8-byte aligned, and the destination is also 8-byte
aligned.  However, there is an inconsistency between the data in the
cache and in memory after the blast_dcache() call.  Could it also be
possible that the cache write buffer is not quite empty, and the data in
it is being lost on the blast call?  Should some implementation of
wbflush be called before the cache ops are done?

I just wanted to see if this could be a problem before I start trying to
track down bugs in hardware...

Thanks,
-ian

"Kevin D. Kissell" wrote:
> 
> Interesting, in that the 4Kc has write-through caches,
> which make it a good deal more difficult to get into
> the kind of trouble you describe.  Are you running one
> of the 4Kc "lead vehicle" chips, or some other part?
> Which version of the kernel are you running, and are
> the CPU type and cache organization being reported
> correctly during boot-up?
> 
> The output you report from dumping the command line
> sounds is interesting.  The corruption seems to be in
> 8-byte chunks - the first 8 have disappeared, as has
> the third 8.  Lord knows where the "0" in "ra0" comes
> from.  Can you confirm that (a) the command line string
> is stored at an 8-byte aligned boundary, and (b) whether
> the data is actually being moved, or if the missing
> characters are simply being replaced with nulls or other
> non-printable characters?  I know it's not pretty, but
> can you dump the same memory addresses as seen
> through non-cacheable kseg1 (0xa0000000-0xbfffffff),
> and are the cache and memory consistent?
> 
> If the failure is happening on 8-byte, doubleword aligned
> chunks, I suspect a hardware problem more than a
> kernel bug.  If it were my system, I'd re-seat the RAM
> and CPU modules to make sure I'm not simply getting
> screwed by a bad connection when the memory interface
> suddenly gets hit with a lot of traffic following the flush.
> 
>             Kevin K.
> 
> ----- Original Message -----
> From: "Ian Thompson" <iant@palmchip.com>
> To: "Kevin D. Kissell" <kevink@mips.com>
> Cc: <linux-mips@oss.sgi.com>
> Sent: Monday, June 04, 2001 10:27 PM
> Subject: Re: dcache_blast() bug?
> 
> > oops sorry i meant to mention that.  running a mips 4kc.
> >
> >
> >
> > "Kevin D. Kissell" wrote:
> > >
> > > What processor are you running?
> > >
> > >             Kevin K.
> > >
> > > ----- Original Message -----
> > > From: "Ian Thompson" <iant@palmchip.com>
> > > To: <linux-mips@oss.sgi.com>
> > > Sent: Monday, June 04, 2001 7:34 PM
> > > Subject: dcache_blast() bug?
> > >
> > > >
> > > > Hi all,
> > > >
> > > > I'm seeing some odd memory behavior around the time when
> blast_dcache()
> > > > is called, leading me to think that the method may be a little buggy.
> > > > It appears that memory is being corrupted (consistently so) over the
> > > > course of flushing the dcache.  This happens to my command line
> argument
> > > > string - arcs_cmdline.  Before the blast_dcache() call, it is
> > > > "console=ttyS0 ramdisk_start=0x9fcf0000 load_ramdisk=1", and after the
> > > > call, the corrupted data is "ttyS0 ra0".  I take it this isn't
> supposed
> > > > to happen?  any ideas of why the writeback_invalidate_d cache
> operation
> > > > may be losing data?
> > > >
> > > > thanks,
> > > > -ian
> > > >
> > > >
> > > > --
> > > > ----------------------------------------
> > > > Ian Thompson           tel: 408.952.2023
> > > > Firmware Engineer      fax: 408.570.0910
> > > > Palmchip Corporation   www.palmchip.com
> >
> > --
> > ----------------------------------------
> > Ian Thompson           tel: 408.952.2023
> > Firmware Engineer      fax: 408.570.0910
> > Palmchip Corporation   www.palmchip.com

-- 
----------------------------------------
Ian Thompson           tel: 408.952.2023
Firmware Engineer      fax: 408.570.0910
Palmchip Corporation   www.palmchip.com
