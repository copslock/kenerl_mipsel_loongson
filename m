Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03NO5M04539
	for linux-mips-outgoing; Thu, 3 Jan 2002 15:24:05 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03NO0g04536;
	Thu, 3 Jan 2002 15:24:00 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 16MGRs-0001If-00; Thu, 03 Jan 2002 22:34:56 +0000
Subject: Re: aic7xxx (O2 scsi) DMA coherency
To: vivien.chappelier@enst-bretagne.fr (Vivien Chappelier)
Date: Thu, 3 Jan 2002 22:34:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ralf@oss.sgi.com (Ralf Baechle),
   linux-mips@oss.sgi.com
In-Reply-To: <Pine.LNX.4.21.0201032247490.9064-100000@melkor> from "Vivien Chappelier" at Jan 03, 2002 10:51:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MGRs-0001If-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> scsi_result0[256]; in scan_scsis) instead of kmallocating it DMA safe as
> it should on non-coherent systems. Maybe this is the thing to change?

Please fix that - thats a real bug. Actually you may find the PPC64 people
(Anton and co) already have a patch you can use
