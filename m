Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03Mq4e30465
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:52:04 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03Mq0g30462;
	Thu, 3 Jan 2002 14:52:00 -0800
Received: from resel.enst-bretagne.fr (user51609@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g03Lppb12256;
	Thu, 3 Jan 2002 22:51:51 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id WAA21133;
	Thu, 3 Jan 2002 22:51:51 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MFmB-0002Mx-00; Thu, 03 Jan 2002 22:51:51 +0100
Date: Thu, 3 Jan 2002 22:51:51 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: aic7xxx (O2 scsi) DMA coherency
In-Reply-To: <E16MFrP-00018Z-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0201032247490.9064-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 3 Jan 2002, Alan Cox wrote:

> > 	This tells the aic7xxx to use DMA safe memory for I/O.
> 
> That seems totally inappropriate. The unchecked dma option is for
> ancient ISA DMA controllers that didnt do the 16Mb check. If you
> find you need it debug your pci remapper

This is used when scaning for devices (drivers/scsi/scsi_scan.c) . When
this flag is not set, the code uses memory from the stack (unsigned char
scsi_result0[256]; in scan_scsis) instead of kmallocating it DMA safe as
it should on non-coherent systems. Maybe this is the thing to change?

regards,
Vivien Chappelier.
