Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03MkQW30235
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:46:26 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03MkKg30208;
	Thu, 3 Jan 2002 14:46:21 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 16MFrP-00018Z-00; Thu, 03 Jan 2002 21:57:15 +0000
Subject: Re: aic7xxx (O2 scsi) DMA coherency
To: vivien.chappelier@enst-bretagne.fr (Vivien Chappelier)
Date: Thu, 3 Jan 2002 21:57:15 +0000 (GMT)
Cc: ralf@oss.sgi.com (Ralf Baechle), linux-mips@oss.sgi.com
In-Reply-To: <Pine.LNX.4.21.0201032233400.8906-200000@melkor> from "Vivien Chappelier" at Jan 03, 2002 10:34:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MFrP-00018Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> 	This tells the aic7xxx to use DMA safe memory for I/O.

That seems totally inappropriate. The unchecked dma option is for
ancient ISA DMA controllers that didnt do the 16Mb check. If you
find you need it debug your pci remapper
