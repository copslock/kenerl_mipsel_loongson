Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54KMdM00593
	for linux-mips-outgoing; Mon, 4 Jun 2001 13:22:39 -0700
Received: from mail.palmchip.com ([63.203.52.8])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54KMch00589
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 13:22:38 -0700
Received: from palmchip.com (sabretooth.palmchip.com [10.1.10.110])
	by mail.palmchip.com (8.11.0/8.9.3) with ESMTP id f54KMVc06899;
	Mon, 4 Jun 2001 13:22:31 -0700
Message-ID: <3B1BEF48.AB0E568C@palmchip.com>
Date: Mon, 04 Jun 2001 13:27:52 -0700
From: Ian Thompson <iant@palmchip.com>
Organization: Palmchip Corporation
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: dcache_blast() bug?
References: <3B1BC6B8.C58758FA@palmchip.com> <02a901c0ed2b$2eac6300$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

oops sorry i meant to mention that.  running a mips 4kc.



"Kevin D. Kissell" wrote:
> 
> What processor are you running?
> 
>             Kevin K.
> 
> ----- Original Message -----
> From: "Ian Thompson" <iant@palmchip.com>
> To: <linux-mips@oss.sgi.com>
> Sent: Monday, June 04, 2001 7:34 PM
> Subject: dcache_blast() bug?
> 
> >
> > Hi all,
> >
> > I'm seeing some odd memory behavior around the time when blast_dcache()
> > is called, leading me to think that the method may be a little buggy.
> > It appears that memory is being corrupted (consistently so) over the
> > course of flushing the dcache.  This happens to my command line argument
> > string - arcs_cmdline.  Before the blast_dcache() call, it is
> > "console=ttyS0 ramdisk_start=0x9fcf0000 load_ramdisk=1", and after the
> > call, the corrupted data is "ttyS0 ra0".  I take it this isn't supposed
> > to happen?  any ideas of why the writeback_invalidate_d cache operation
> > may be losing data?
> >
> > thanks,
> > -ian
> >
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
