Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0416jC07605
	for linux-mips-outgoing; Thu, 3 Jan 2002 17:06:45 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0416gg07602
	for <linux-mips@oss.sgi.com>; Thu, 3 Jan 2002 17:06:42 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g03NqFd01594;
	Thu, 3 Jan 2002 21:52:15 -0200
Date: Thu, 3 Jan 2002 21:52:15 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@oss.sgi.com
Subject: Re: aic7xxx (O2 scsi) DMA coherency
Message-ID: <20020103215215.A1186@dea.linux-mips.net>
References: <E16MFrP-00018Z-00@the-village.bc.nu> <Pine.LNX.4.21.0201032247490.9064-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0201032247490.9064-100000@melkor>; from vivien.chappelier@enst-bretagne.fr on Thu, Jan 03, 2002 at 10:51:51PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 03, 2002 at 10:51:51PM +0100, Vivien Chappelier wrote:

> > > 	This tells the aic7xxx to use DMA safe memory for I/O.
> > 
> > That seems totally inappropriate. The unchecked dma option is for
> > ancient ISA DMA controllers that didnt do the 16Mb check. If you
> > find you need it debug your pci remapper
> 
> This is used when scaning for devices (drivers/scsi/scsi_scan.c) . When
> this flag is not set, the code uses memory from the stack (unsigned char
> scsi_result0[256]; in scan_scsis) instead of kmallocating it DMA safe as
> it should on non-coherent systems. Maybe this is the thing to change?

Indeed, it is.  I thought this one died ages ago.

  Ralf
